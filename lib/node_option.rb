class NodeOption
  attr_accessor :content, :type, :name
  def self.for(name, content)
    self.new name, content, get_content_type(content)
  end

  def initialize(name, content, type="text")
    @content = content
    @type = type
    @name = name
  end

  def to_xml(xml)
    xml.send name, :content => @content, :type => @type
  end

  private

    def self.image_regex
      /(.+\/.*\.(?:|gif|jpeg|png|jpg))/
    end

    def self.is_image?(value)
      value.match image_regex
    end

    def self.get_content_type(value)
      is_image?(value) ? "image" : "text"
    end
end
