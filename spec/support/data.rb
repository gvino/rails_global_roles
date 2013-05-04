[ User, AccessibleUser ].each do |user|
  user.destroy_all

  9.times do |i|
    u = user.create(:login => "user#{i}", :global_role => i % 3)
    u.send(:write_attribute, :global_role, i % 3)
    u.save
  end
end
