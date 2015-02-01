class OneToOneNode < TargetWordNode
  # A node where one question has one answer
  #
  # An example is Poker Pairs: https://www.youtube.com/watch?v=660tRSk32AM
  #
  # Each node will have one question and one response.
  #
  # (This class just extends TargetWordNode adding response)
  attr_accessor :response

  def initialize(question, response, options = [])
    @response = response
    super(question, options)
  end

  # Create a OneToOneNode from xml
  # Params;
  # xml: the xml containing questions, responses and options
  #      (see example at lib/one_to_one_node.rb's EOF)
  def self.from_xml(xml)
    question  = NodeOption.for "question", get_content(xml, "question")
    response  = NodeOption.for "response", get_content(xml, "response")
    self.new(question, response, self.get_options_from(xml))
  end

  def self.from_hash(hash)
    new hash[:question], hash[:response]
  end

  protected

  def before_options_xml(xml)
    response.to_node_option("response").to_xml(xml)
  end
end
__END__

<?xml version="1.0" encoding="utf-8"?>
<xml>
  <format gamename="Leap Frog" v="2.0">
    <attribute name="english" type="question" label="English word" type="editbox" interactive="true" />
    <attribute name="lang" type="response" label="translation" type="editbox" interactive="true" />
  </format>
  <description>
    <text>Type in the Latin for the given verb forms.</text>
    <keyword>active </keyword>
    <keyword>passive</keyword>
  </description>

  <gamedata>
    <node>
      <question name="english" content="30" type="audio" />
    </node>

    <node>
      <question name="english" content="I will be loved" type="text" />
    </node>

    <node>
      <question name="english" content="media/image/food/cake.swf" type="image" />
    </node>
  </gamedata>

  <templatedata></templatedata>
  <language>Spanish</language>
</xml>
