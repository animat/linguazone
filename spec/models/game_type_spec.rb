require 'spec_helper'

describe GameType do
  describe ".one_to_one" do
    let(:game_type) { GameType.one_to_one }

    it "has a question and an answer" do
      game_type.questions.map{|q| q.name}.should == ["Question", "Answer"]
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
    let!(:example1) { Factory(:example,  :activity => activity, :question_name => "question", :node_input => "how are you") }
    let!(:example2) { Factory(:example,  :activity => activity, :question_name => "response", :node_input => "good", :language => example1.language) }

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
  end
end

