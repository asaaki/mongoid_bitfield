module Mongoid
  module Bitfield
    extend ActiveSupport::Concern

    module ClassMethods
      def bitfield(fieldname, *bits)
        fieldsymbol = fieldname.to_sym
        field fieldsymbol, :type => Integer

        bits.each do |bitname|
          bitsymbol = bitname.to_sym
          bit       = 1 << bits.index(bitsymbol)

          define_method bitname do
            result = send(fieldsymbol) & bit
            result && result > 0
          end

          define_method :"#{bitname}=" do |boolean|
            unless boolean == send(bitsymbol)
              current_value = send(fieldsymbol) || 0
              new_value     = current_value ^ bit

              send(:"#{fieldname}=", new_value)
            end
          end

          define_method :"#{bitname}_enable!" do
            send(:"#{bitname}=", true)
            bit(fieldsymbol => { or: bit })
          end

          define_method :"#{bitname}_disable!" do
            send(:"#{bitname}=", false)
            bit(fieldsymbol => { and: ~bit })
          end
        end
      end
    end
  end
end
