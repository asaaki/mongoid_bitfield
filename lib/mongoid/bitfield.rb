# encoding: utf-8
module Mongoid
  module Bitfield
    extend ActiveSupport::Concern

    module ClassMethods

      def bitfield fieldname, *bits
        field fieldname.to_sym, :type => Integer

        bits.each do |bitname|
          define_method bitname do
            current = send(fieldname.to_sym) || 0
            current[bits.index(bitname.to_sym)] == 1 ? true : false
          end

          define_method :"#{bitname}=" do |boolean|
            unless boolean == send(bitname.to_sym)
              cur_value = send(fieldname.to_sym) || 0
              bit_value = (1 << bits.index(bitname.to_sym))
              new_value = (cur_value ^ bit_value)
              send(:"#{fieldname}=", new_value)
            end
          end

          define_method :"#{bitname}_enable!" do
            send(:"#{bitname}=", true)
            set(fieldname.to_sym, (send(fieldname.to_sym) || 0))
          end

          define_method :"#{bitname}_disable!" do
            send(:"#{bitname}=", false)
            set(fieldname.to_sym, (send(fieldname.to_sym) || 0))
          end
        end

      end

    end

  end
end