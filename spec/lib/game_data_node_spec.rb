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
      node.question.content.should == "gato"
      node.ltarget.content.should  == "el"
    end

    context "when question is an image" do
      let(:xml) {"""
        <node>
          <question type=\"image\" content=\"/images/gato.jpg\"/>
          <responses answer=\"all\">
            <ltarget name=\"ltarget\" content=\"el\" type=\"text\" />
          </responses>
        </node>
      """}

      it "gets te correct node option" do
        node = SingleWordMatchNode.from_xml(Nokogiri::XML(xml))
        node.question.type.should == "image"
      end

      it "writes the correct content type in the url" do
        node = SingleWordMatchNode.from_xml(Nokogiri::XML(xml))
        xml = Nokogiri::XML::Builder.new do |xml|
          node.to_xml xml
        end
        xml.to_xml.should have_xml '/node/question[@type="image"]'
      end
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
