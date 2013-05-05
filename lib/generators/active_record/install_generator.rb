require 'rails/generators/active_record'
require 'active_support/core_ext'

module ActiveRecord
  module Generators
    class InstallGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_global_roles_migration
        migration_template "migration.rb", "db/migrate/add_global_role_to_#{table_name}"
      end

      def model_path
        File.join("app", "models", "#{file_path}.rb")
      end

      def default_value
        args.first == -1 ? 0 : args.first
      end

    end
  end
end
