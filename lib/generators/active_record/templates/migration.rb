class AddGlobalRoleTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>, :role, :integer, :null => :false, :default => 0
    add_index :<%= table_name %>, :role
  end
end
