class OneToOneNode < TargetWordNode
  # A node with two corresponding elements: a question and a response
  #
  # Examples include Poker Pairs: https://www.youtube.com/watch?v=660tRSk32AM
  # =>      as well as Leap Frog: https://www.youtube.com/watch?v=12hrGdHQHYc
  #
  # As of right now, each OneToOne node has single question and single response.
  # Ideally, cmzr3 would allow a user to enter multiple possible responses for each node.
  # => e.g. "mangus" as the question could accept "big" _or_ "large" as an appropriate response.
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
    	<response name="lang" content="facietur" type="text" />
    </node>
    
    <node>
			<question name="english" content="I will be loved" type="text" />
			<response name="lang" content="amabor" type="text" />
		</node>

    <node>
			<question name="english" content="media/image/food/cake.swf" type="image" />
			<response name="lang" content="audiebar" type="text" />
		</node>    
  </gamedata>

  <templatedata></templatedata>
  <language>Spanish</language>
</xml>
