module GlobalRoles
  module Methods
    extend ::ActiveSupport::Concern

    def role
      @role ||= self.class::ROLES[self.role_id]
    end

    def role_id
      self.read_attribute :role
    end

    def reload_role
      @role = nil
    end

    def role=(name)
      write_attribute(:role, self.class::role_id_for_name(name))
    end

    def role_id=(id)
      unless id.is_a? Fixnum
        raise ArgumentError, "Expected a Fixnum, but got \#{id.inspect}"
      end
      @role = nil
      write_attribute(:role, id)
    end

    module ClassMethods
      def values_for_role
        self::ROLES
      end

      def role_id_for_name(r)
        r.is_a?(Integer) ? r : self::ROLES.index(r.to_sym)
      end

      def with_role(r)
        self.send(:where, :role => role_id_for_name(r))
      end
    end

  end
end
