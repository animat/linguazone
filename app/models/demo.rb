class Demo < ActiveRecord::Base
  belongs_to :game
  belongs_to :activity
  belongs_to :language
end
