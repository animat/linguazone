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
