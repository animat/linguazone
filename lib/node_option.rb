require 'lib/node_value'

class NodeOption
  attr_accessor :content, :name

  def self.for(name, content)
    self.new name, content
  end

  def initialize(name, content)
    create_values(content)
    @name = name
  end

  def to_xml(xml)
    if @content.kind_of?(Array)
      @content.each do |n|
        n.to_xml(xml, name)
      end
    else
      @content.to_xml(xml, name)
    end

  end

  def to_s
    name
  end

  def to_node_option(name)
    self
  end

  private

    def create_values(content)
      if content.kind_of?(Array)
        @content = []
        content.each do |v|
          @content << NodeValue.new(v)
        end
      else
        @content = NodeValue.new(content)
      end
    end
end

class String
  def to_node_option(name)
    NodeOption.new(name, self)
  end
end

