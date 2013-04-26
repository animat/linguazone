class Linguazone.Views.Games.NodeValue extends Backbone.View
  populated: false
  className: "nodeValue backbone"

  constructor: (options) ->
    @content = options.content
    @model   = options.model
    @options = options
    super

  events:
    "change input" : "populate"
    "click .deleteContent" : "remove"

  populate: =>
    @$el.find(".deleteContent").show()
    @populated = true

class Linguazone.Views.Games.TextContent extends Linguazone.Views.Games.NodeValue
  className: "textRow"

  template: """
    <input type="text" value="<%= content %>">
    <span class="deleteContent" style="display:none">x</span>
  """

  render: ->
    @$el.html(_.template(@template, { content: @content}))
    @populate() if @content
    this


class Linguazone.Views.Games.ImageContent extends Linguazone.Views.Games.NodeValue
  template: """
    <div class="image">
    </div>

    <div class="modal" style="display:none;">
      <div class="preview" style="display:none">
        <h3>Change Image</h3>
        <div class="image-div"></div>
      </div>

      <div class="upload">
      <h3>Upload An Image</h3>
      <div class="uploader">Select Files...</div>
    </div>
    <p/>
    <div class="image-search"></div>

  """

  showModal: =>
    @createModal() unless @modal
    @modal.show().dialog("open")
    @$preview ||= @modal.find(".preview")
    false

  createModal: =>
    @modal ||= @$el.find(".modal").dialog
      title: "Select an Image."
      height: 800
      width: 1050
    view = new Linguazone.Views.FlickrSearch.Show(model: @model)
    view.on "select", (url) => @selectImageAndClose(url)
    @modal.find(".image-search").html(view.render().el)

  showUploads: =>
    uploader = @$el.find(".uploader").fineUploader
      request:
        endpoint: "/images"
      text:
        uploadButton: 'Select Files'
      validation:
        allowedExtensions: ['jpeg', 'jpg', 'png', 'gif'],
        sizeLimit: 1024000

    uploader.on "complete", (event, id, fileName, responseJSON)  =>
      @selectImageAndClose(image_url)

  displayImage: (image_url) =>
    return unless image_url

    u = @$el.find(".image").show()
    u.html("")
    $image = $("<img>", { src: image_url })

    $image.on "click", @selectNewImage
    u.append $image
    u.addClass("thumb")

  selectNewImage: => @showModal()

  selectImageAndClose: (image_url) =>
    @model.addContent(image_url)
    @modal.dialog("close")
    @displayImage(image_url)

  render: ->
    @$el.html(_.template(@template, { content: @content}))
    if @content
      @displayImage(@content)
    else
      @showModal()
    @showUploads()
    @populate() if @content
    this
