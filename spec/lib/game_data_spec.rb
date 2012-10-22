require 'spec_helper'
require 'lib/game_data'

describe GameData do
  let(:game_data) { GameData.new }
  let(:node) { GameData::Node.new("How are you?", "Fine", ["Fine", "Bad", "Okay"]) }

  it "can add a node" do
    game_data.add_node(node)
    game_data.nodes.count.should == 1
  end

  describe GameData::Node do
    it "has a question" do
      node.question.should == "How are you?"
    end

    it "has a response" do
      node.response.should == "Fine"
    end

    it "has many options" do
      node.options.length.should == 3
      node.options.should include "Okay"
    end
  end

  describe "#to_xml" do
    before { game_data.add_node(node) }

    it "is valid xml" do
      xml = game_data.to_xml
      xml.should_not be_nil
      xml.should have_xml "/gamedata/nodes/question[@content='How are you?']"
      xml.should have_xml "/gamedata/nodes/response[@content='Fine']"
      xml.should have_xml "/gamedata/nodes/options/option[@content='Bad']"
    end
  end
end

describe GameData do
  describe ".from" do
    let(:game) { Factory(:game, :xml => """
<?xml version=\"1.0\"?>\n<gamedata>
  <node>
    <question type=\"text\" content=\"How are you?\"/>
    <response type=\"text\" content=\"Fine\"/>  
    <options>
      <option type=\"text\" content=\"Fine\"/>
      <option type=\"text\" content=\"Bad\"/>
      <option type=\"text\" content=\"Okay\"/>
    </options>
  </node>
</gamedata>
""")}

    it "hydrates game data from a game object" do
      game_data = GameData.from(game)
      game_data.should_not be_nil
      game_data.nodes.length.should == 1
      node = game_data.nodes.first
      node.question.should == "How are you?"
      node.response.should == "Fine"
      node.options.length.should == 3
      node.options.should include "Bad"
      node.options.should include "Fine"
    end
  end
end
