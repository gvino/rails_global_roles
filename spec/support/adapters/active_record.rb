require 'active_record'

RSpec::Matchers::OperatorMatcher.register(ActiveRecord::Relation, '=~', RSpec::Matchers::BuiltIn::MatchArray)
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

load File.dirname(__FILE__) + '/../schema.rb'

# Standard user class
class User < ActiveRecord::Base
  ROLES = [:regular, :admin, :moderator]
  setup_global_roles!
end

# User with admin accessible role setting
class AccessibleUser < ActiveRecord::Base
  ROLES = [:regular, :admin, :moderator]
  setup_global_roles!

  attr_accessible :login
  attr_accessible :role, :as => :admin
end

# User wit default role :admin
class AdminUser < ActiveRecord::Base
  ROLES = [:regular, :admin, :moderator]
  setup_global_roles! :default => :admin

  attr_accessible :login
  attr_accessible :role, :as => :admin
end
