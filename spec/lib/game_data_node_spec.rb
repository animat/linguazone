require 'spec_helper'
require 'lib/game_data'
require 'lib/game_data_node'

describe GameDataNode do
  describe SingleWordMatchNode do
    let(:xml) {"""
      <node>
        <question type=\"text\" content=\"gato\"/>
        <responses answer=\"all\">
          <ltarget name=\"ltarget\" content=\"el\" type=\"text\" />
        </responses>
      </node>
    """}

    it "can populate from double word xml" do
      node = SingleWordMatchNode.from_xml(Nokogiri::XML(xml))
      node.question.should == "gato"
      node.ltarget.should  == "el"
    end
  end

  describe DoubleWordMatchNode do
    let(:xml) {"""
      <node>
        <question type=\"text\" content=\"gato\"/>
        <responses answer=\"all\">
          <ltarget name=\"ltarget\" content=\"el\" type=\"text\" />
          <rtarget name=\"rtarget\" content=\"masculine\" type=\"text\" />
        </responses>
      </node>
    """}

    it "can populate from double word xml" do
      node = DoubleWordMatchNode.from_xml(Nokogiri::XML(xml))
      node.question.should == "gato"
      node.ltarget.should  == "el"
      node.rtarget.should  == "masculine"
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
