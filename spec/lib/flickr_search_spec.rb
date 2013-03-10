require 'spec_helper'

describe FlickrSearch do
  describe "#search" do
    it "returns creative common results" do
      VCR.use_cassette 'flickr_search' do
        FlickRaw.search("cats")[0].url.should_not be_nil
      end
    end
  end
end
