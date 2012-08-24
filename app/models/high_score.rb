class HighScore < ActiveRecord::Base
  belongs_to :available_game
  belongs_to :user
end
