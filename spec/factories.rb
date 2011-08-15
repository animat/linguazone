Factory.define :state do |p|
  p.name "Pennsylvania"
  p.abbr 'PA'
end

Factory.define :user do |u|
  u.email      "john@smith.com"
  u.first_name "John"
  u.last_name  "Smith"
end

Factory.define :student, :parent => :user do |s|
  s.role "student"
end

Factory.define :language do |l|
  l.name "Spanish"
  l.special_characters "ñ"
end

Factory.define :activity do |a|
  a.swf           "blah.swf"
  a.name          "fun"
  a.hints_xml     "<hint></hint>"
  a.help          "click on it"
  a.youtube_embed "click on it"
end

Factory.define :game do |g|
  g.description "Fun game"
  g.audio_ids   "1,2"
  g.template_id 2
  g.xml         "<game></game>"
  g.association :activity
  g.association :language
end

Factory.define :subscription_plan do |p|
  p.name "Trial"
  p.max_teachers 50
  p.cost 5
end

Factory.define :subscription do |s|
  s.association :subscription_plan
end


Factory.define :school do |s|
  s.name        "Xavier's School of Gifted Youngsters"
  s.address     "1407 Graymalkin Lane"
  s.city        "Salem Center"
  s.association :state
  s.zip         "19103"
  s.pin          999
end

Factory.define :teacher, :class => "User" do |f|
  f.email "test@example.com"
  f.display_name "Joe Teacher"
  f.password "test"
  f.first_name "Joe"
  f.last_name "Teacher"
end
