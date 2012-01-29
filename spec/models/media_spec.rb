require 'spec_helper'

describe Media do
  it { should belong_to :media_category }
  it { should belong_to :media_type }

  it "can be created from a Factory" do
    media = Factory(:media)
    media.should be_valid
  end
end
