class AddGlobalRoleTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>, :global_role, :integer, :null => :false, :default => <%= default_value %>
    add_index :<%= table_name %>, :global_role
  end
end
