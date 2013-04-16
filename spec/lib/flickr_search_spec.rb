require 'spec_helper'
require 'lib/flickr_search'

describe FlickrSearch do
  describe "#search" do
    it "returns creative common results" do
      VCR.use_cassette 'flickr_search' do
        FlickrSearch.search("cats")[0].url.should_not be_nil
      end
    end
  end
end
