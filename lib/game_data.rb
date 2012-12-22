require 'nokogiri'
require 'open-uri'

class GameData
  attr_accessor :nodes, :game_type

  def self.from(game)
    from_xml game.xml, game.game_type, game.template.try(:xml)
  end

  def self.from_xml(xml, game_type = "OneToOne", template_data_xml = nil)
    game_data = new
    game_data.game_type = game_type
    xml_doc  = Nokogiri::XML(xml)
    xml_doc.xpath(".//node").each { |node| game_data.add_node(GameData::Node.from node) }
    game_data.add_template_data(template_data_xml)
    game_data
  end

  def add_template_data(data)

  end

  def initialize
    @nodes = []
    @game_type = "OneToOne"
  end

  def add_node(node)
    @nodes << node
  end

  def to_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.gamedata { @nodes.each { |node| node.to_xml(xml) } }
    end.to_xml
  end


  #  Abstract Base class for nodes.
  #
  #  Nodes don't have much in common, so this base class's responsibility is
  #  basically as a Factory, taking in some XML and deciding what type of Node
  #  to return.
  class Node
    # Make the decision based on the node, calls another class method that knows how to parse the XML.
    def self.from(node)
      if node.xpath(".//response").present?
        self.from_green_xml(node)
      else
        self.from_blue_xml(node)
      end
    end

    private

      def self.from_green_xml(node)
        question = node.xpath(".//question").first["content"]
        response = node.xpath(".//response").first["content"]
        options = []
        node.xpath(".//option").each do |option|
          options << option["content"]
        end
        GameData::GreenNode.new(question, response, options)
      end

      def self.from_blue_xml(node)
        question = node.xpath(".//question").first["content"]
        responses = node.xpath(".//responses")
        ltarget   = responses.first.xpath("ltarget").first["content"]
        rtarget   = responses.first.xpath("rtarget").first["content"]
        GameData::BlueNode.new(question, ltarget, rtarget)
      end
  end

  class BlueNode < Node
    attr_accessor :question, :ltarget, :rtarget

    def initialize(question, ltarget, rtarget)
      @question, @ltarget, @rtarget = question, ltarget, rtarget
    end
  end

  class GreenNode < Node
    attr_accessor :question, :response, :options

    def initialize(question, response, options = [])
      @question, @response, @options = question, response, options
    end

    def to_xml(xml)
      return unless question.present?

      xml.node do
        xml.question :content => self.question, :type => "text"
        xml.response :content => self.response, :type => "text"
        if self.options.present?
          xml.options {
            self.options.each do |option|
              xml.option :content => option, :type => "text"
            end
          }
        end
      end
    end
  end
end
