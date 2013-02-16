require 'nokogiri'
require 'open-uri'
require 'game_data_node'

class GameData
  attr_accessor :nodes, :game_type

  def self.from(game)
    from_xml game.xml, game.game_type, game.template.try(:xml)
  end

  def self.from_xml(xml, game_type = "OneToOne", template_data_xml = nil)
    game_data = new
    game_data.game_type = game_type
    xml_doc  = Nokogiri::XML(xml)
    xml_doc.xpath(".//node").each do |node|
      game_data.add_node(GameDataNode.from node, game_type)
    end
    game_data.add_template_data(template_data_xml)
    game_data
  end

  def node_constant
    "#{@game_type}Node".constantize
  end

  def add_template_data(xml)
    @template_data ||= TemplateData.from_xml(xml)
  end

  def template_data
    @template_data ||= TemplateData.new
  end

  def template_data_xml
    template_data.to_xml
  end

  def word_lists
    template_data.lists
  end

  def add_word(list, word)
    word_lists[list] = [] unless word_lists.has_key?(list)
    word_lists[list] << word
  end

  def initialize(game_type = "OneToOne")
    @nodes = []
    @game_type = game_type
  end

  def add_node(node)
    @nodes << node
  end

  def to_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.gamedata { @nodes.each { |node| node.to_xml(xml) } }
    end.to_xml
  end
end
