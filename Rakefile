#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
require 'rspec/core/rake_task'
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'GlobalRoles'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:generators) do |task|
  task.pattern = "spec/generators/**/*_spec.rb"
end

task :default => :spec

desc "Run all specs"
task "spec" do
  Rake::Task['generators'].invoke
  return_code1 = $?.exitstatus
  fail if return_code1 != 0
end
