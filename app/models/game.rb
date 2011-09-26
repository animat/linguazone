class Game < ActiveRecord::Base
  belongs_to :activity
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :language
  has_many :available_games
  has_many :high_scores

  def self.getting_started
    self.find_by_getting_started(true)
  end
end
