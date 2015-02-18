class Linguazone.Views.Games.NodeValue extends Backbone.Marionette.ItemView
  className: "nodeValue backbone"

  constructor: (options) ->
    @content = options.content || ""
    @multiple = options.multiple || false
    super

  events:
    "change input"         : "populate"
    "click .deleteContent" : "remove"

  populate: =>
    @$el.find(".deleteContent").show() if @content and @multiple

class Linguazone.Views.Games.TextContent extends Linguazone.Views.Games.NodeValue
  className: "textRow"

  template: """
    <h2></h2>

    <div class="textContent">
      <input type="text" value="<%= getContent() %>">
      <span class="deleteContent" style="display:none">x</span>
    </div>
  """

  templateHelpers: ->
    getContent: => @content

  onRender: ->
    @populate()

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
      <h2>Upload an image</h2>
      <div class="uploader">Select files...</div>
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
    # TODO: Yuck. Why doesn't the modal overlay cover the rest of the screen once I scroll?
    @modal ||= @$el.find(".modal").dialog
      title: "Add an image"
      height: 600
      width: 945
      draggable: false
      modal: true
      # TODO @Len: Clicking outside of the modal window should dismiss it
      #open: ->
      #  $('.ui-widget-overlay').bind('click', ->
      #    $('.modal').dialog('close');
    
    view = new Linguazone.Views.FlickrSearch.Show(model: @model)
    view.on "select", (url) => @selectImageAndClose(url)
    @modal.find(".image-search").html(view.render().el)
    @modal.find(".search").focus()

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
