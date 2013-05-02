require 'rubygems'
require "bundler/setup"

require 'global_roles'
require 'rails/all'

module TestApp
  class Application < ::Rails::Application
    config.root = File.dirname(__FILE__)
  end
end

require 'ammeter/init'
