class OneToOneNode < TargetWordNode
  attr_accessor :response

  def initialize(question, response, options = [])
    @response = response
    super(question, options)
  end

  def self.from_xml(node)
    question  = NodeOption.for "question", get_content(node, "question")
    response  = NodeOption.for "response", get_content(node, "response")
    options = []
    node.xpath(".//option").each do |option|
      options << option["content"]
    end
    self.new(question, response, options)
  end

  def self.from_hash(hash)
    new hash[:question], hash[:response]
  end

  protected

    def before_options_xml(xml)
      response.to_node_option("response").to_xml(xml)
    end
end
