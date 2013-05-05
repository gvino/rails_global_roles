module GlobalRoles
  module Methods
    extend ::ActiveSupport::Concern

    def global_role
      @global_role ||= self.class::ROLES[self.global_role_id]
    end

    def global_role_id
      self.read_attribute :global_role
    end

    def reload_global_role
      @global_role = nil
    end

    def global_role=(name)
      write_attribute(:global_role, self.class::global_role_id_for(name))
    end

    def global_role_id=(id)
      unless id.is_a? Fixnum
        raise ArgumentError, "Expected a Fixnum, but got \#{id.inspect}"
      end
      id = self.class::global_role_id_for(id)
      @global_role = nil
      write_attribute(:global_role, id)
    end

    module ClassMethods
      def values_for_global_role
        self::ROLES
      end

      def global_role_id_for(r)
        if !valid_role?(r)
          raise ArgumentError, "Unsupported value for `global_role': #{r.inspect}"
        end
        (r.is_a? Integer) ? r : self::ROLES.index(r)
      end

      private
      def valid_role?(r)
        if (r.is_a? Integer)
          if !(0...self::ROLES.size).include?(r)
            return false
          end
        else
          return self::ROLES.include?(r.respond_to?(:to_sym) ? r.to_sym : r)
        end
        true
      end
    end

  end
end
