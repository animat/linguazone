require './lib/game_data'
class Game < ActiveRecord::Base
  belongs_to :activity
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :language
  belongs_to :template
  has_many :available_games
  has_many :high_scores
  has_many :available_games, :dependent => :destroy

  delegate :game_type, :to => :activity

  def large_icon_src
    "/games/#{self.activity.swf}/display/icon.jpg" unless self.activity.nil?
  end

  def header_text
    ""
  end

  def description_text
    "#{self.description}"
  end

  def self.getting_started
    self.find_by_getting_started(true)
  end

  def game_data
    @game_data ||= GameData.from(self)
  end
end
