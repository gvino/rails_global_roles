require "spec_helper"

# TODO Make specs readable

describe User, "with installed global role" do
  context "class" do
    describe "should have class methods" do
      subject { User }

      it { should respond_to(:values_for_role) }
      it { User.values_for_role.should be_eql(User::ROLES) }
      it { should respond_to(:with_role).with(1).arguments }
      it { should respond_to(:role_id_for_name).with(1).arguments }

    end

    def logins_by_role_id(id)
      (0..8).select{ |i| i % 3 == id }.map{ |i| "user#{i}" }
    end

    context "should find by" do
      describe "role id" do
        before(:all) do
          @with_role0 = User.with_role(0)
          @with_role1 = User.with_role(1)
        end


        it { @with_role0.count.should be_eql(3) }
        it { @with_role1.count.should be_eql(3) }

        it { @with_role0.map(&:login).sort.should be_eql(logins_by_role_id 0) }
        it { @with_role1.map(&:login).sort.should be_eql(logins_by_role_id 1) }
      end

      describe "role name" do
        before(:all) do
          @with_role_regular = User.with_role(:regular)
          @with_role_admin   = User.with_role(:admin)
        end

        it { @with_role_regular.count.should be_eql(3) }
        it { @with_role_admin.count.should be_eql(3) }
      end
    end
  end

  context "update_attributes" do
    context "as admin" do
      context "should set correct role" do
        describe "by id" do

          # FIXME Fix this spec to use `update_attributes`
          before (:each) do
            @user = AccessibleUser.first
#            @user.update_attributes(:role => 1, :as => :admin)
            @user.role = 1; @user.save!
          end

          it { @user.class::role_id_for_name(@user.role).should be_eql(1) }
          it { @user.role.should be_eql(:admin) }
        end

        describe "by name" do
          before (:each) do
            @user = AccessibleUser.first
            @user.role = :moderator; @user.save!
          end

          it { @user.role_id.should be_eql(2) }
          it { @user.role.should be_eql(:moderator) }
        end
      end
    end
  end

  context "if specified :default value" do
    describe "new user should have right default value" do
      before (:all) { @user = AdminUser.new }
      subject { @user }

      it { @user.role.should be_eql(:admin) }
    end
  end
end
