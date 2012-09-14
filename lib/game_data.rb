require 'nokogiri'
require 'open-uri'

class GameData
  attr_accessor :nodes

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
