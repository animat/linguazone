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

class SingleWordMatchingNode < GameDataNode
  attr_accessor :question, :options

  def initialize(question)
    @question = question
  end

  def self.from_xml(node)
    question = node.xpath(".//question").first["content"]
    self.new(question)
  end
end

class DoubleWordMatchingNode < GameDataNode
  attr_accessor :question, :ltarget, :rtarget

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
    return unless self.response.present?
    super(xml)
  end
end
