class TemplateData
  attr_accessor :lists

  def initialize
    @lists = {}
  end

  def self.from_xml(xml)
    template = self.new

    xml_doc  = Nokogiri::XML(xml)
    xml_doc.xpath(".//set").each do |node|
      template.lists[node["linkedto"]] = []
      node.xpath(".//option").each do |option|
        template.lists[node["linkedto"]] << option["content"]
      end
    end
    return template
  end

  def to_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.templatedata do
        lists.keys.each do |key|
          xml.set do
            lists[key].each do |value|
              xml.option :content => value, :type => "text"
            end
          end
        end
      end
    end.to_xml
  end
end
