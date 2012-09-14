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

