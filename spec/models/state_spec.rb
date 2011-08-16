require 'spec_helper'
describe State do
  let(:international_state) { Factory(:state, :intl => true) }
  let(:national_state) { Factory(:state,      :intl => false) }

  describe '.international' do
    it "returns international states" do
      State.international.should == [international_state]
    end
  end

  describe '.national' do
    it "returns national states" do
      State.national.should == [national_state]
    end
  end
end
