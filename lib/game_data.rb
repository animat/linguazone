require 'nokogiri'
require 'open-uri'

class GameData
  attr_accessor :nodes

  def self.from(game)
    game_data = new

    xml_doc  = Nokogiri::XML(game.xml)
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
  end

  def add_node(node)
    @nodes << node
  end

  def to_xml
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.gamedata {
        xml.nodes {
          @nodes.each do |node|
            xml.question :content => node.question, :type => "text"
            xml.response :content => node.response, :type => "text"
            xml.options {
              node.options.each do |option|
                xml.option :content => option, :type => "text"
              end
            }
          end
        }
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
