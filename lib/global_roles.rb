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

      if default = options[:default] || 0
        after_initialize do
          self.global_role = default unless global_role? || persisted?
        end
      end

      self::ROLES.each do |r|
        define_method("global_#{r}?".to_sym) do
          global_role == r
        end
      end

      self.class_eval %(
        scope :with_global_role,
          proc { |r|
            where(:global_role => #{self}::global_role_id_for(r))
          }
      )
    end
  end

  def reload(*)
    super
    reload_role
    self
  end
end

ActiveRecord::Base.send :include, GlobalRoles
