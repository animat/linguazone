require 'spec_helper'
require './lib/template_data'

describe TemplateData do
  describe ".from_xml " do
   let(:xml) {"""
        <templatedata>
          <set label=\"left target\" linkedto=\"ltarget\">
            <option name=\"value\" content=\"le\" type=\"text\" />
            <option name=\"value\" content=\"la\" type=\"text\" />
            <option name=\"value\" content=\"les\" type=\"text\" />
          </set>
          <set label=\"right target\" linkedto=\"rtarget\">
            <option name=\"value\" content=\"masculine\" type=\"text\" />
            <option name=\"value\" content=\"feminine\" type=\"text\" />
          </set>
        </templatedata>
      """}

    it "returns a wordlist" do
      template_data = TemplateData.from_xml(xml)
      template_data.lists["ltarget"].should_not be_nil
      template_data.lists["ltarget"].should =~ ["le", "la", "les"]
    end
  end

  describe "#to_xml" do
    it "returns correct xml" do
      template_data = TemplateData.new
      template_data.lists["ltarget"] = ["le", "la"]
      xml = template_data.to_xml
      xml.should_not be_nil
      xml.should have_xml "/templatedata/set/option[@content='le']"
    end

    it "returns an empty templatedata node when therer is no data" do
      TemplateData.new.to_xml.should have_xml "/templatedata"
    end
  end
end
