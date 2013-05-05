$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "global_roles/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "global_roles"
  s.version     = GlobalRoles::VERSION
  s.authors     = ["George Vinogradov"]
  s.email       = ["g-vino@yandex.ru", "g.vinogradov@itima.ru"]
  s.homepage    = "http://github.com/gvino/rails_global_roles"
  s.summary     = "Simple roles gem"
  s.description = "Simple gem to provide global roles for ActiveRecrod models without using of another models"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.require_paths = ["lib"]

  s.add_development_dependency "activerecord", ">= 3.2.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "bundler"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "ammeter"
end
