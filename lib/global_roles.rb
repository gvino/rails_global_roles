require 'active_record'
require 'active_support'
require 'global_roles/methods.rb'

module GlobalRoles
  extend ::ActiveSupport::Concern

  module ClassMethods
    protected
    def setup_global_roles!(options = {})
      self::ROLES.freeze
      include GlobalRoles::Methods

      if default = options[:default]
        after_initialize do
          self.global_role = default unless global_role? || persisted?
        end
      end

    end
  end

  def reload(*)
    super
    reload_role
    self
  end
end

ActiveRecord::Base.send :include, GlobalRoles
