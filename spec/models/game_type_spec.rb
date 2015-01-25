require 'spec_helper'
require './lib/game_data'
require './lib/game_data_node'

describe GameType do
  describe ".target_word" do
    let(:game_type) { GameType.target_word }

    it "has a question and an answer" do
      game_type.questions.map{|q| q.name}.should == ["Question"]
    end
  end

  describe ".one_to_one" do
    let(:activity) { Factory(:activity, :game_type => "OneToOne") }

    it "has a question and answer" do
      GameType.for(activity).questions.map{|q| q.name}.should == ["Question", "Answer"]
    end
  end

  describe ".for" do
    let!(:activity) { Factory(:activity, :game_type => "OneToOne") }
    let!(:example1) { Factory(:example,  :default => false, :activity => activity, :node_key_name => "question", :node_value => "how are you") }
    let!(:example2) { Factory(:example,  :default => false, :activity => activity, :node_key_name => "response", :node_value => "good", :language => example1.language) }

    it "news up the correct instance of itself" do
      activity.game_type = "BlahToBlah"
      struct = Struct.new(:activity).new
      GameType.stubs(:blah_to_blah => struct)
      GameType.for(activity).should == struct
    end

    it "includes example node for an activity" do
      node = GameType.for(activity).example_node_for(example1.language)
      node.should_not be_nil
      node.question.should == "how are you"
      node.response.should == "good"
    end

    describe "when there are no example nodes" do
      let(:language) { Factory(:language) }

      it "returns an empty node" do
        node = GameType.for(activity).example_node_for(language)
        node.question.should be_nil
        node.response.should be_nil
      end
    end
  end
end

