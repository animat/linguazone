# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

states = State.create([{:name => "Alabama", :abbr => "AL", :intl => 0}, {:name => "Pennsylvania", :abbr => "PA", :intl => 1}])
plans = SubscriptionPlan.create([
  {:name => "basic", :max_teachers => 1, :cost => 79},
  {:name => "basic", :max_teachers => 3, :cost => 149},
  {:name => "basic", :max_teachers => 6, :cost => 225},
  {:name => "basic", :max_teachers => -1, :cost => 299},
  {:name => "premium", :max_teachers => 1, :cost => 99},
  {:name => "premium", :max_teachers => 3, :cost => 199},
  {:name => "premium", :max_teachers => 6, :cost => 299},
  {:name => "premium", :max_teachers => -1, :cost => 399},
  {:name => "trial", :max_teachers => 1, :cost => 0}
  ])
subscription = Subscription.create({:subscription_plan_id => plans.last.id, :pin => 11111, :created_at => Time.now,
                :updated_at => Time.now, :expired_at => Time.now + 5.years})
school = School.create({:name => "Test School", :address => "111 Test Road", :city => "Testville", :state_id => states.first.id, :zip => "10101",
                :created_at => Time.now, :updated_at => Time.now})
#Test user's password: test
teacher = User.create({:email => "test@lz.com", :crypted_password => "098f6bcd4621d373cade4e832627b4f6", :password_salt => "", :first_name => "Test", :last_name => "Teacher",
                :school_id => school.id, :role => "teacher", :subscription_id => subscription.id, :created_at => Time.now})
teacher.password= "password"
teacher.save
