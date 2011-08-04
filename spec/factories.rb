Factory.define :state do |p|
  p.name "Pennsylvania"
  p.abbr 'PA'
end

Factory.define :subscription_plan do |p|
  p.name "Trial"
  p.max_teachers 50
  p.cost 5
end

Factory.define :teacher, :class => "User" do |f|
  f.email "test@example.com"
  f.display_name "Joe Teacher"
  f.password "test"
  f.first_name "Joe"
  f.last_name "Teacher"
end
