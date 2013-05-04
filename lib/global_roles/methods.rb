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
      write_attribute(:global_role, self.class::global_role_id_for_name(name))
    end

    def global_role_id=(id)
      unless id.is_a? Fixnum
        raise ArgumentError, "Expected a Fixnum, but got \#{id.inspect}"
      end
      @global_role = nil
      write_attribute(:global_role, id)
    end

    module ClassMethods
      def values_for_global_role
        self::ROLES
      end

      def global_role_id_for_name(r)
        r.is_a?(Integer) ? r : self::ROLES.index(r.to_sym)
      end

      def with_global_role(r)
        self.send(:where, :global_role => global_role_id_for_name(r))
      end
    end

  end
end
