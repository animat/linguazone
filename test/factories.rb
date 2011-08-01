Factory.define :teacher, :class => "User" do |f|
  f.email "test@example.com"
  f.display_name "Joe Teacher"
  f.password "test"
  f.first_name "Joe"
  f.last_name "Teacher"
end