require 'spec_helper'
require 'lib/game_data'
require 'lib/game_data_node'

describe GameData do
  context "Green Nodes" do
    let(:game_data)  { GameData.new }
    let(:node)       { OneToOneNode.new("How are you?", "Fine", ["Fine", "Bad", "Okay"]) }
    let(:empty_node) { OneToOneNode.new(nil, nil, nil) }

    it "can add a node" do
      game_data.add_node(node)
      game_data.nodes.count.should == 1
    end

    describe OneToOneNode do
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
        xml.should have_xml "/gamedata/node/question[@content='How are you?']"
        xml.should have_xml "/gamedata/node/response[@content='Fine']"
        xml.should have_xml "/gamedata/node/options/option[@content='Bad']"
      end
    end

    describe "#to_xml doesn't return empty nodes" do
      before do
        game_data.add_node(node)
        game_data.add_node(empty_node)
      end

      it "is valid xml" do
        xml = game_data.to_xml
        GameData.from_xml(xml).nodes.length.should == 1
      end
    end
  end

  context "DoubleWordMatchNode" do
    let(:game_data)  { GameData.new }
    let(:node)       { DoubleWordMatchNode.new("How are you?", "Fine", ["Fine", "Bad", "Okay"]) }

    describe "#to_xml" do
      before { game_data.add_node(node) }

      it "is valid xml" do
        xml = game_data.to_xml
      end
    end
  end
end

describe GameData do
  describe ".from" do
    context "for blue games" do
      let(:template) { Factory(:template, :xml => """
  <templatedata>
    <set label='left target' linkedto='ltarget'>
      <option name='value' content='le' type='text' />
      <option name='value' content='la' type='text' />
      <option name='value' content='les' type='text' />
    </set>
    <set label='right target' linkedto='rtarget'>
      <option name='value' content='masculine' type='text' />
      <option name='value' content='feminine' type='text' />
    </set>
  </templatedata>
""")}

      let(:game) { Factory(:game, :xml => """
<gamedata>
  <node>
    <question name='question' content='maison' type='text' />
    <responses answer='all'>
      <ltarget name='ltarget' content='la' type='text' />
      <rtarget name='rtarget' content='feminine' type='text' />
    </responses>
  </node>
  <node>
    <question name='question' content='mot' type='text' />
    <responses answer='all'>
      <ltarget name='ltarget' content='le' type='text' />
      <rtarget name='rtarget' content='masculine' type='text' />
    </responses>
  </node>
</gamedata>
""", :template => template) }

      it "populates the nodes" do
        game.stubs(:game_type => "DoubleWordMatch")

        game_data = GameData.from(game)
        game_data.nodes.length.should == 2
        game_data.nodes.first.question.should == 'maison'
        game_data.nodes.first.ltarget.should == "la"
        game_data.nodes.first.rtarget.should == "feminine"
      end
    end

    context "for one to one games" do
      let(:game) { Factory(:game, :xml => """
  <?xml version=\"1.0\"?>
  <gamedata>
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
        node.question.content.content.should == "How are you?"
        node.options.length.should == 3
        node.options.should include "Bad"
        node.options.should include "Fine"
      end
    end
  end
end
