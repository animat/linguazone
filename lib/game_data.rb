require 'nokogiri'
require 'open-uri'

class GameData
  attr_accessor :nodes, :game_type

  def self.from(game)
    from_xml game.xml, game.game_type
  end

  def self.from_xml(xml, game_type = "OneToOne")
    game_data = new
    game_data.game_type = game_type
    xml_doc  = Nokogiri::XML(xml)
    xml_doc.xpath(".//node").each do |node|
      question = node.xpath(".//question").first["content"]
      response = node.xpath(".//response").first["content"]
      options = []
      node.xpath(".//option").each do |option|
        options << option["content"]
      end
      game_data.add_node(GameData::Node.new question, response, options)
    end
    game_data
  end

  def initialize
    @nodes = []
    @game_type = "OneToOne"
  end

  def add_node(node)
    @nodes << node
  end

  def to_xml
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.gamedata {
        #TODO: let node render itself probably need to load different classes based on @game_type
        @nodes.each do |node|
          unless node.question.nil?
            xml.node {
                xml.question :content => node.question, :type => "text"
                xml.response :content => node.response, :type => "text"
                xml.options {
                  node.options.each do |option|
                    xml.option :content => option, :type => "text"
                  end
                }
            }
          end
        end
      }
    end

    builder.to_xml
  end

  class Node
    attr_accessor :question, :response, :options

    def initialize(question, response, options = [])
      @question, @response, @options = question, response, options
    end
  end
end
