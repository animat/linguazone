require 'spec_helper'
require 'lib/game_data'
require 'lib/game_data_node'

describe GameDataNode do
  describe SingleWordMatchingNode do
    let(:xml) {"""
      <node>
      <question type=\"text\" content=\"How are you?\"/>
      <options>
        <option type=\"text\" content=\"Fine\"/>
        <option type=\"text\" content=\"Bad\"/>
        <option type=\"text\" content=\"Okay\"/>
      </options>
      </node>
    """}

    it "can populate form double word xml" do
      node = SingleWordMatchingNode.from_xml(Nokogiri::XML(xml))
      node.question.should == "How are you?"
      node.options.length.should == 3
    end
  end

  describe OneToOneNode do
    let(:xml) {"""
      <node>
     <question type=\"text\" content=\"How are you?\"/>
      <response type=\"text\" content=\"Fine\"/>
      <options>
        <option type=\"text\" content=\"Fine\"/>
        <option type=\"text\" content=\"Bad\"/>
        <option type=\"text\" content=\"Okay\"/>
      </options>
      </node>
    """}

    it "can populate form double word xml" do
      node = OneToOneNode.from_xml(Nokogiri::XML(xml))
      node.question.should == "How are you?"
      node.response.should == "Fine"
      node.options.length.should == 3
    end
  end
end
