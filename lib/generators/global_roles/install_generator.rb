require 'rails/generators/migration'
require 'active_support/core_ext'

module GlobalRoles
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      Rails::Generators::ResourceHelpers

      DEFAULT_ROLES = [:regular, :admin, :moderator]

      source_root File.expand_path('../templates', __FILE__)
      argument :roles, :type => :array, :default => [], :banner => "role1 role2 role3 ..."

      desc "Inject roles list and `set_global_roles` method in the specified class"

      def inject_user_class
        inject_into_file(model_path, :after => inject_global_roles_method) do
<<RUBY

  # Global roles
  ROLES = #{roles_list}
  set_global_roles!

RUBY
        end
      end

      def setup_migration
        invoke "active_record:install", [ name ]
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
        (roles.empty? ? DEFAULT_ROLES : roles).map{ |r| r.to_sym }
      end

    end
  end
end
