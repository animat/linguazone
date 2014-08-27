require 'spec_helper'

describe AvailableWordList do
  describe "for_course" do
    let(:course) { Factory(:course) }
    it "returns wordlists for the course" do
      AvailableWordList.for(course)
      AvailableWordList.for(course).to_a.should_not be_nil
    end
  end
end
