require 'spec_helper'

describe MediaCategory do
  it "can be created from a Factory" do
    media_category = Factory(:media_category)
    media_category.should be_valid
  end

  it { should have_many :medias }

  describe ".active" do
    let!(:active_category)   { Factory(:media_category) }
    let!(:inactive_category) { Factory(:media_category) }
    let!(:media)             { Factory(:media, :media_category => active_category) }

    it "only returns media categories" do
      MediaCategory.active.should == [active_category]
    end
  end
end
