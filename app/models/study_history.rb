class StudyHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :word_list
end
