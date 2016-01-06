class StudyHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :available_word_list
  
  has_many :sources, :as => :sourceable
end
