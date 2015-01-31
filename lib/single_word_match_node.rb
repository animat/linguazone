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
