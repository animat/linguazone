class StudyHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :available_word_list
end
