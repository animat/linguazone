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
      node.question.content.content.should == "gato"
      node.ltarget.content.content.should  == "el"
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
        node.question.content.type.should == "image"
      end

      it "writes the correct content type in the url" do
        NodeValue.any_instance.stubs(:create_local_image_if_remote_url => nil)
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
      node.question.content.content.should == "How are you?"
      node.response.content.content.should == "Fine"
      node.options.length.should == 3
    end
  end

  describe OneToOneNode do
    let(:xml) {"""
        <node>
        <question type=\"text\" content=\"How are you?\"/>

        <responses>
          <response content=\"Fine\"/>
          <response content=\"Bad\"/>
        </responses>

        <options>
          <option type=\"text\" content=\"Fine\"/>
          <option type=\"text\" content=\"Bad\"/>
          <option type=\"text\" content=\"Okay\"/>
        </options>
        </node>
    """}


    it "can handle multiple values" do
      node = OneToOneNode.from_xml(Nokogiri::XML(xml))
      node.response.content.first.content.should == "Fine"
      node.response.content.last.content.should == "Bad"
    end
  end

  describe MultipleAnswerNode do
    let(:xml) {"""
      <node>
        <question type=\"text\" content=\"How are you?\"/>

          <response content=\"Fine\">

            <options>
              <option type=\"text\" content=\"Fine\"/>
              <option type=\"text\" content=\"Bad\"/>
              <option type=\"text\" content=\"Okay\"/>
            </options>
          </response>
      </node>
    """}

    it "handles the correct node" do
      node = MultipleAnswerNode.from_xml(Nokogiri::XML(xml))
      node.question.content.content.should == "How are you?"
      node.responses.content.length.should == 3
    end
  end

  describe OneToOneNode do
    let(:xml) {"""
        <node>
        <question type=\"text\" content=\"How are you?\"/>

        <responses>
          <response content=\"Fine\"/>
          <response content=\"http://imgur.com/blah.jpg\"/>
        </responses>

        <options>
          <option type=\"text\" content=\"Fine\"/>
          <option type=\"text\" content=\"Bad\"/>
          <option type=\"text\" content=\"Okay\"/>
        </options>
        </node>
    """}


    it "can handle multiple values of different types" do
      node = OneToOneNode.from_xml(Nokogiri::XML(xml))
      node.response.content.first.type.should == "text"
      node.response.content.last.type.should == "image"
      node.response.content.last.content.should == "http://imgur.com/blah.jpg"
    end
  end
end
