require 'spec_helper'

describe Game do
  it "can return the getting started game" do
    Factory(:game, :getting_started => false)
    game = Factory(:game, :getting_started => true)
    Game.getting_started.should == game
  end
end
