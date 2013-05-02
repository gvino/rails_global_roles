ActiveRecord::Schema.define do

  self.verbose = false

  [ :users, :accessible_users, :admin_users ].each do |table|
    create_table(table) do |t|
      t.string :login
      t.integer :role, :default => 0
    end
  end
end

