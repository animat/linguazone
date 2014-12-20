require 'spec_helper'

describe Example do
  let!(:spanish)  { Factory(:language, :name => "Spanish") }
  let!(:english)  { Factory(:language, :name => "English") }
  let!(:activity) { Factory(:activity) }
  let!(:example)  { Factory(:example, :default => true, :language => spanish, :activity => activity) }

  describe ".for" do
    context "when an example exists for that language" do
      let!(:specific_example1)  { Factory(:example, :language => english, :activity => activity, :question_name => "yes") }
      let!(:specific_example2)  { Factory(:example, :language => english, :activity => activity, :question_name => "no") }

      it "returns the example" do
        Example.for(english, activity).should == [specific_example2, specific_example1]
      end
    end

    context "when no example exists for that language" do
      it "returns the default example for that activity" do
        Example.for(english, activity).should == [example]
      end
    end
  end

  describe "#game_data" do
    let(:example) { Factory.build(:example) }

#    it "can be populated from xml" do
#      pending
#      example.game_data.nodes.length.should == 2
#    end
  end
end
