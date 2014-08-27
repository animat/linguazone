class NodeValue
  attr_accessor :type, :content

  def initialize(content)
    @content = content
    @type = get_content_type(@content)
  end

  def to_xml(xml, name)
    create_local_image_if_remote_url(content) if is_image?(content)
    xml.send name, :content => @content, :type => @type
  end

  private

    def create_local_image_if_remote_url(url)
      image = Image.new
      image.image_url= url
      image.save!
      @content = image.image.url
    end

    def get_content_type(content)
      is_image?(content) ? "image" : "text"
    end

    def image_regex
      /(.+\/.*\.(?:|gif|jpeg|png|jpg))/
    end

    def is_image?(content)
      content = content.first if content.kind_of?(Array)
      content.match image_regex
    end
end
