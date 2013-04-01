require 'spec_helper'

describe Media do
  it { should belong_to :media_category }
  it { should belong_to :media_type }

  it "can be created from a Factory" do
    media = Factory(:media)
    media.should be_valid
  end

  describe "keywords" do
    let(:media) { Factory(:media) }

    it "creats many media keywords on save" do
      media.keywords = "one, two, three"
      media.save!
      media.reload
      media.media_keywords.length.should == 3
    end

    it "gets hyrdated from media keywords" do
      media.keywords = "one, two, three"
      media.save!
      media.reload
      media.keywords.should == "one, two, three"
    end
  end
end
