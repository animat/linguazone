FactoryGirl.define do
  
  factory :state do
    name "Pennsylvania"
    abbr 'PA'
  end

  factory :user do
    email      "john@smith.com"
    password    "test"
    first_name "John"
    last_name  "Smith"
    association :school
  end

  factory :student, :parent => :user do
    role "student"
  end

  factory :language do
    name "Spanish"
    special_characters "N"
  end

  factory :activity do
    swf           "mantis"
    name          "Mantis"
    hints_xml     "<hint></hint>"
    help          "click on it"
    youtube_embed "click on it"
  end

  factory :game do
    description "Fun game"
    audio_ids   "1,2"
    template_id 2
    xml         "<game></game>"
    association :activity
    association :language
  end

  factory:template do
    xml "<templatedata></templatedata>"
    association :game
  end

  factory :demo do
    association :game
    association :activity
    association :language
    category    "sample"
  end

  factory :word_list do
    description "Challenging word list"
    xml         "<game></game>"
    association :language
  end

  factory :post do
    title         "Sample post #___"
    content       "Lorem ipsum text here..."
    audio_id      3000
    shared        true
    created_at    Time.now
    updated_at    Time.now
    association   :course
  end
  
  factory :comment do
    association   :user
    audio_id      1234
    content       "This is a comment"
    teacher_note  "Note from teacher"
    association   :available_post
  end

  factory :available_game do 
    association :game
    association :user
  end

  factory :subscription_plan do
    name          "trial"
    max_teachers  50
    cost          5
  end

  factory :subscription do
    pin         "ABC12"
    association :subscription_plan
    expired_at  5.months.from_now
  end

  factory :school do
    name        "Xavier's School of Gifted Youngsters"
    address     "1407 Graymalkin Lane"
    city        "Salem Center"
    association :state
    zip         "19103"
  end

  factory :course do
    name          "Latin 3A"
    guid          SecureRandom.base64(36)
    association   :user
  end

  factory :teacher, :class => "User" do
    email "test@example.com"
    display_name "Joe Teacher"
    password "test"
    first_name "Joe"
    last_name "Teacher"
    role "teacher"
    association :school
    association :subscription
  end

  factory :media_category do
    name "unscramble"
  end

  factory :media_type do
    ext "swf"
  end

  factory :media do
    name         "Unscrambling Game"
    descrip      "A fun game"
    notes        "A great media"
    path         "/"
    assigned_to  "John"
    published    true
    pending      false
    used_count   4
    association  :media_type
    association  :media_category
  end

  factory :example do
    default       true
    association   :activity
    association   :language
    node_value    "hello"
    node_key_name "question"
  end
end
