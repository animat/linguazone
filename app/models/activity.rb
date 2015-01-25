class Activity < ActiveRecord::Base
  has_many :games

  def node_class
    "::#{self.game_type}Node".constantize
  end

  class NodeAbility
    attr_accessor :name, :options
  end
end
