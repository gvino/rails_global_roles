require 'generators_helper'

# Generators are not automatically loaded by Rails
require 'generators/global_roles/install_generator'

describe GlobalRoles::Generators::InstallGenerator do
  destination File.expand_path("../../../../tmp", __FILE__)
  teardown :cleanup_destination_root

  before { prepare_destination }

  def cleanup_destination_root
    FileUtils.rm_rf destination_root
  end

  context "Specified only <model> name" do
    model_path = "app/models/user.rb"
    before(:all) { arguments %w(User) }

    before do
      capture(:stdout) do
        generator.create_file model_path do
<<-RUBY
class User < ActiveRecord::Base
end
RUBY
        end
      end
      require File.join(destination_root, model_path)
      run_generator
    end

    describe model_path do
      subject { file model_path }

      roles = ::GlobalRoles::Generators::InstallGenerator::DEFAULT_ROLES
      roles = Regexp.escape roles.inspect
      it { should contain /ROLES = #{roles}\n/ }
      it { should contain /ROLES = #{roles}\n  setup_global_roles!\n/ }
    end

    describe 'migration file' do
      subject { migration_file('db/migrate/add_global_role_to_users.rb') }

      it { should be_a_migration }
      it { should contain "def change" }
      it { should contain "add_column :users, :role, :integer, :null => :false, :default => 0" }
    end
  end

  context "Specified <model> name and list of roles" do
    model_path = "app/models/user.rb"
    before(:all) { arguments %w(User role1 role2) }

    before do
      capture(:stdout) do
        generator.create_file model_path do
<<-RUBY
class User < ActiveRecord::Base
end
RUBY
        end
      end
      require File.join(destination_root, model_path)
      run_generator
    end

    describe model_path do
      subject { file model_path }
      roles = [:role1, :role2]
      roles = Regexp.escape roles.inspect

      it { should contain /ROLES = #{roles}\n/ }
      it { should contain /ROLES = #{roles}\n  setup_global_roles!\n/ }
    end

  end

end
