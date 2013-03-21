#= require ../flickr_search/show
class Linguazone.Views.Games.NodeOption extends Backbone.Marionette.ItemView
  template: """
    <div class="input">
      <input type="text" value="<%= get("content") %>">
    </div>
    <div class="image">
    </div>

    <a href="#" class="text-link">text</a>
    <a href="#" class="image-link">image</a>

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

  # HACK:
  updateContent: =>
    if @model and @model.get("content") and @model.get("content").content
      @model.set("content", @model.get("content").content)

  events:
    "click .image-link"   : 'showModal'
    "click .text-link"    : 'showInput'
    ".image-link click"   : 'showModal'
    'change .input input' : 'changeValue'

  changeValue: (e) =>
    @model.set("content", $(e.currentTarget).val())

  showInput: =>
    @$el.find(".input").show()
    @$el.find(".image").hide()


  showModal: =>
    @$el.find(".input").hide()
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

  selectImageAndClose: (image_url) =>
    @updateContent()
    @modal.dialog("close")
    @showImage(image_url)

  showImage: (image_url) =>
    @$el.find(".input").hide()
    u = @$el.find(".image").show()
    u.html("")
    $image = $("<img>", { src: image_url })

    # need to ||= because $.fn.dialog removes the modal from the element.
    #@$preview ||= @$el.find(".preview")
    #@$preview.html("")
    #@$preview.find(".image-div").append($image.clone())
    #@$preview.show()

    $image.on "click", @selectNewImage
    u.append $image
    u.addClass("thumb")

    @model.set("content", image_url)

  selectNewImage: =>
    @showModal()

  isImage: (content) =>
     regex = /(.+\/.*\.(?:|gif|jpeg|png|jpg))/
     content.match(regex)

  render: =>
    @updateContent()
    @$el.html _.template(@template, @model)
    @showImage(@model.get("content")) if @isImage(@model.get("content"))
    @showUploads()
    this

  ui:
    input:      "input"
    image_link: "image-link"
    text_link:  "text-link"

  val: -> @ui.input.val()

