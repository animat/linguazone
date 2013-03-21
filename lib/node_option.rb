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
    create_local_image_if_remote_url(content) if NodeOption.is_image?(content)
    xml.send name, :content => @content, :type => @type
  end

  def to_s
    name
  end

  def to_node_option(name)
    self
  end

  private

    def create_local_image_if_remote_url(url)
      image = Image.new
      image.image_url= url
      image.save!
      @content = image.image.url
    end

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

class String
  def to_node_option(name)
    NodeOption.new(name, self)
  end
end

