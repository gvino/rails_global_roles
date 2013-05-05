require 'rails/generators/migration'
require 'active_support/core_ext'

module GlobalRoles
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      Rails::Generators::ResourceHelpers

      DEFAULT_ROLES = %w(regular admin moderator)

      source_root File.expand_path('../templates', __FILE__)
      argument :roles, :type => :array, :default => DEFAULT_ROLES,
                       :banner => "role1[:default] role2[:default] role3[:default] ..."

      desc "Inject roles list and `set_global_roles` method in the specified class"

      def inject_user_class
        inject_into_file(model_path, :after => inject_global_roles_method) do
<<RUBY

  # Global roles
  ROLES = #{roles_list}
  setup_global_roles!#{default_role}

RUBY
        end
      end

      def setup_migration
        invoke "active_record:install", [ name, fetch_default ]
      end

      protected

      def inject_global_roles_method
        Regexp.union(
          /class #{class_name.camelize}\n/,
          /class #{class_name.camelize} .*\n/,
          /class #{class_name.demodulize.camelize}\n/,
          /class #{class_name.demodulize.camelize} .*\n/
        )
      end

      def model_path
        File.join("app", "models", "#{file_path}.rb")
      end

      def roles_list
        roles.map{ |r| r.split(':').first.to_sym }
      end

      def fetch_default
        d = roles.map {|r| r.split(':') }.select {|r| r[1] == 'default'}
        d.empty? ? -1 : roles_list.index(d[0].first.to_sym)
      end

      def default_role
        a = fetch_default
        (a == -1) ? '' : " default: :#{roles_list[a]}"
      end
    end
  end
end
