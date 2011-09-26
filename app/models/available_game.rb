class AvailableGame < ActiveRecord::Base
  belongs_to :course
  belongs_to :game
end
