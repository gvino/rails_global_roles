# GlobalRoles

_**Disclamer:** My english is awful, so feel free to send me 
corrections of this text._

This is a simple gem to add global role to any model in your
Ruby on Rails application.

## Usage

For example if you have model `User` and want to add global
role to it, you should do following things:

    $ rails generate global_roles:install User
    $ rake db:migrate

If you want to specify your own roles list, you should provide it 
after model name, e.g.

    $ rails generate global_roles:install User role1 role2

If you want to specify role that will be default for model you 
should mark it as default in roles list:

    $ rails generate global_roles:install User role1 role2:default

**Be careful! If you don't specify default role, it will be first 
role in list.**

After this you will see something like this in your model:

```ruby
  class User < ActiveRecord::Base
    ROLES = [:regular, :admin, :moderator]
    # or, if you provide roles list
    # ROLES = [:role1, :role2, ...]
    setup_global_roles!

    <your old code here>
  end
```

Constant `ROLES` contains list of roles that you will be able to set 
to your model.  You can add new roles to the and of this array but 
not between existing elements since there are any models with roles 
in your database otherwise you won't like results.

If you pass optional argument `default: <role_name>` to 
`setup_global_roles!` it will set `<role_name>` as default global 
role for new instances of your model.

You can check model's role anywhere in your application using query 
methods `global_<role_name>?`, for example:

```ruby
  if @user.global_admin?
    <some actions>
  end
```

If you want to set role to model, you can do it two ways. You may 
pass role name

```ruby
  @user.global_role = :admin
```

or role index:

```ruby
  @user.global_role = 2 # set User::ROLES[2] role
```

If you need to collect all models with particular role, you should 
use `Model.with_global_role` method:

```ruby
  User.with_global_role(:moderator) # will return list of moderators
```

## TODO

- [x] Add validation to model
- [x] Make `with_global_role` method a scope
- [x] Add possibility to set default role through generator
- [ ] **Make specs readable**

## License

This code is distributed under terms of MIT-LICENSE