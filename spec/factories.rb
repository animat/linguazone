
Factory.define :state do |p|
  p.name "Pennsylvania"
  p.abbr 'PA'
end

Factory.define :user do |u|
  u.email      "john@smith.com"
  u.password    "test"
  u.first_name "John"
  u.last_name  "Smith"
  u.association :school
end

Factory.define :student, :parent => :user do |s|
  s.role "student"
end

Factory.define :language do |l|
  l.name "Spanish"
  l.special_characters "N"
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

Factory.define :demo do |d|
  d.association :game
  d.association :activity
  d.association :language
  d.category    "sample"
end

Factory.define :word_list do |g|
  g.description "Challenging word list"
  g.xml         "<game></game>"
  g.association :language
end

Factory.define :post do |p|
  p.title         "Sample post #___"
  p.content       "Lorem ipsum text here..."
  p.audio_id      3000
  p.shared        true
  p.created_at    Time.now
  p.updated_at    Time.now
  p.association   :course
end

Factory.define :available_game do |ag|
  ag.association :game
  ag.association :user
end

Factory.define :subscription_plan do |p|
  p.name          "trial"
  p.max_teachers  50
  p.cost          5
end

Factory.define :subscription do |s|
  s.pin         "ABC12"
  s.association :subscription_plan
  s.expired_at  5.months.from_now
end

Factory.define :school do |s|
  s.name        "Xavier's School of Gifted Youngsters"
  s.address     "1407 Graymalkin Lane"
  s.city        "Salem Center"
  s.association :state
  s.zip         "19103"
end

Factory.define :course do |c|
  c.name          "Latin 3A"
  c.guid          rand(5**10).to_s(36)
  c.association   :user
end

Factory.define :teacher, :class => "User" do |f|
  f.email "test@example.com"
  f.display_name "Joe Teacher"
  f.password "test"
  f.first_name "Joe"
  f.last_name "Teacher"
  f.role "teacher"
  f.association :school
  f.association :subscription
end

Factory.define :media_category do |m|
  m.name "unscramble"
end

Factory.define :media_type do |m|
  m.ext "swf"
end

Factory.define :media do |m|
  m.name         "Unscrambling Game"
  m.descrip      "A fun game"
  m.path         "/"
  m.assigned_to  "John"
  m.published    true
  m.pending      false
  m.used_count   4
  m.association  :media_type
  m.association  :media_category
end

