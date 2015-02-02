require 'node_option'
#  Abstract Base class for nodes.
#
#  Nodes don't have much in common, so this base class's responsibility is
#  basically as a Factory, taking in some XML and deciding what type of Node
#  to return.
class GameDataNode
  # Make the decision based on the node, calls another class method that knows how to parse the XML.
  def self.from(node, type)
    Kernel.const_get("#{type}Node").from_xml node
  end

  def self.get_options_from(xml)
    Array.new.tap do |options|
      xml.xpath(".//option").each do |option|
        options << option["content"]
      end
    end
  end

  def add_options_to(xml)
    before_options_xml(xml)
    if self.options.present?
      xml.options {
        self.options.each do |option|
          xml.option :content => option, :type => "text"
        end
      }
    end
  end

  def self.get_content(node, type)
    options = []
    node.xpath(".//#{type}").each do |n|
      options << n["content"]
    end
    options.length > 1 ? options : options.first
  end

  protected

  # Append more XML before writing the options node
  def before_options_xml(xml);end
end
