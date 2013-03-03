require 'node_option'
#  Abstract Base class for nodes.
#
#  Nodes don't have much in common, so this base class's responsibility is
#  basically as a Factory, taking in some XML and deciding what type of Node
#  to return.
class GameDataNode
  # Make the decision based on the node, calls another class method that knows how to parse the XML.
  def self.from(node, type)
    const_get("#{type}Node").from_xml node
  end
end

class SingleWordMatchNode < GameDataNode
  attr_accessor :question, :ltarget

  def self.from_xml(node)
    responses = node.xpath(".//responses")
    question  = NodeOption.for "question", node.xpath(".//question").first["content"]
    ltarget   = NodeOption.for "ltarget", responses.first.xpath("ltarget").first["content"]
    self.new(question, ltarget)
  end

  def self.from_hash(hash)
    new hash[:question], hash[:ltarget]
  end

  def initialize(question, ltarget)
    raise "Question Must be a NodeOption" unless question.respond_to? "content"
    @question, @ltarget = question, ltarget
  end

  def to_xml(xml)
    xml.node do
      question.to_xml(xml)
      xml.responses do
        ltarget.to_xml(xml)
      end
    end
  end
end

class DoubleWordMatchNode < GameDataNode
  attr_accessor :question, :ltarget, :rtarget

  def self.from_hash(hash)
    new hash[:question], hash[:ltarget], hash[:rtarget]
  end

  def initialize(question, ltarget, rtarget)
    @question, @ltarget, @rtarget = question, ltarget, rtarget
  end

  def self.from_xml(node)
    question = node.xpath(".//question").first["content"]
    responses = node.xpath(".//responses")
    ltarget   = responses.first.xpath("ltarget").first["content"]
    rtarget   = responses.first.xpath("rtarget").first["content"]
    self.new(question, ltarget, rtarget)
  end

  def to_xml(xml)
    xml.node do
      xml.question :content => self.question, :type => "text"
      xml.responses do
        xml.ltarget :content => self.ltarget, :type => "text"
        xml.rtarget :content => self.rtarget, :type => "text"
      end
    end
  end
end


class TargetWordNode < GameDataNode
  attr_accessor :question, :options

  def initialize(question, options = [])
    @question, @options = question, options
  end

  def self.from_xml(node)
    question = node.xpath(".//question").first["content"]
    options = []
    node.xpath(".//option").each do |option|
      options << option["content"]
    end
    self.new(question, options)
  end

  def to_xml(xml)
    return unless question.present?

    xml.node do
      xml.question :content => self.question, :type => "text"
      before_options(xml)
      if self.options.present?
        xml.options {
          self.options.each do |option|
            xml.option :content => option, :type => "text"
          end
        }
      end
    end
  end

  protected

    def before_options(xml)
    end
end

class OneToOneNode < TargetWordNode
  attr_accessor :response

  def initialize(question, response, options = [])
    @response = response
    super(question, options)
  end

   def self.from_xml(node)
    question = node.xpath(".//question").first["content"]
    response = node.xpath(".//response").first["content"]
    options = []
    node.xpath(".//option").each do |option|
      options << option["content"]
    end
    self.new(question, response, options)
  end

  def to_xml(xml)
    super(xml)
  end

  protected

    def before_options(xml)
      xml.response :content => self.response, :type => "text"
    end
end
