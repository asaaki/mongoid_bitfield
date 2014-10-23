# encoding: utf-8
module Mongoid
  module Bitfield
    extend ActiveSupport::Concern

    module ClassMethods

      def bitfield fieldname, *bits
        fieldsymbol = fieldname.to_sym
        field fieldsymbol, :type => Integer

        bits.each do |bitname|
          bitsymbol = bitname.to_sym
          define_method bitname do
            current = send(fieldsymbol) || 0
            current[bits.index(bitsymbol)] == 1 ? true : false
          end

          define_method :"#{bitname}=" do |boolean|
            unless boolean == send(bitsymbol)
              cur_value = send(fieldsymbol) || 0
              bit_value = (1 << bits.index(bitsymbol))
              new_value = (cur_value ^ bit_value)
              send(:"#{fieldname}=", new_value)
            end
          end

          define_method :"#{bitname}_enable!" do
            send(:"#{bitname}=", true)
            set(fieldsymbol, (send(fieldsymbol) || 0))
          end

          define_method :"#{bitname}_disable!" do
            send(:"#{bitname}=", false)
            set(fieldsymbol, (send(fieldsymbol) || 0))
          end
        end
      end
    end
  end
end
