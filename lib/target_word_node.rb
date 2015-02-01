class TargetWordNode < GameDataNode
  # A node representing a simple question.
  #
  # Only valid for Garden Grows: http://youtube.com/watch?v=4EoRPRgil2M
  #
  # Each node will have one value.  Image nodes are not valid.
  attr_accessor :question, :options

  def self.from_hash(hash)
    new hash[:question]
  end

  def initialize(question, options = [])
    @question, @options = question, options
  end

  # Create a TargetWordNode from xml
  # Params;
  # xml: the xml containing questions and options
  #      (see example at lib/target_word_node.rb's EOF)
  def self.from_xml(xml)
    question  = NodeOption.for "question", get_content(xml, "question")
    options = []
    xml.xpath(".//option").each do |option|
      options << option["content"]
    end
    self.new(question, options)
  end

  # Get an XMl version of the Node
  # Params:
  # xml: an existing xml object to use
  def to_xml(xml)
    return unless question.present?

    xml.node do
      question.to_node_option("question").to_xml(xml)
      before_options_xml(xml)
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

  # Append more XML before writing the options node
  def before_options_xml(xml);end
end

__END__

= Example XML:

<?xml version="1.0" encoding="utf-8"?>
<xml>
  <format gamename="Garden Grows" v="2.0">
    <attribute name="english" type="question" label="English word" type="editbox" interactive="true" />
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
