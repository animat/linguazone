class Activity < ActiveRecord::Base
  has_many :games

  class NodeAbility
    attr_accessor :name, :options
  end
end
