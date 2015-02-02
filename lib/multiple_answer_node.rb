class MultipleAnswerNode < GameDataNode
  attr_accessor :question, :response, :options

  def initialize(question, response, options)
    raise "Question required" unless @question = question
    raise "Response required" unless @response = response
    raise "Options required" unless @options  = options
  end

  def self.from_hash(hash)
    if hash["options"].class == String
      hash["options"] = hash["options"].split(",")
    end
    new hash[:question], hash[:response], hash["options"]
  end

  def self.from_xml(node)
    question = NodeOption.for "question", get_content(node, "question")
    response = NodeOption.for "response", get_content(node, "response")
    options  = []
    node.xpath(".//option").each do |option|
      options << get_content(option, "option")
    end
    self.new(question, response, options)
  end

  def to_xml(xml)
    xml.node do
      question.to_node_option("question").to_xml(xml)
      response.to_node_option("response").to_xml(xml)
      xml.options {
        self.options.each do |option|
          xml.option :content => option, :type => "text"
        end
      }
    end
  end
end

