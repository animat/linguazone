class Linguazone.Views.Games.NodeOption extends Backbone.Marionette.ItemView
  template: """
    <div class="input">
      <input type="text" value="<%= get("content") %>">
    </div>

    <a href="#" class="image-link">image</a>

    <div class="modal" style="display:none;">
      <div class="upload">
        <h3>Upload An Image</h3>
        <div class="uploader">Select Files...</div>
      </div>

      <p/>

      <div class="image-search">
        <h3>Search For an Image</h3>
        <input type="text" placeholder="Search for an Image"/>
        <div class="results">
        </div>
      </div>
    </div>
  """

  events:
    "click .image-link"   : 'showModal'
    ".image-link click"   : 'showModal'
    'change .input input' : 'changeValue'

  changeValue: (e) =>
    @model.set("content", $(e.currentTarget).val())

  showModal: =>
    @modal = @$el.find(".modal").show().dialog
      title: "Select an Image."
      height: 300
      width: 350
    false

  showUploads: =>
    uploader = @$el.find(".uploader").fineUploader
      request:
        endpoint: "/images"
      text:
        uploadButton: 'Select Files'
      validation:
        allowedExtensions: ['jpeg', 'jpg', 'png', 'gif'],
        sizeLimit: 512000

    uploader.on "complete", (event, id, fileName, responseJSON)  =>
      @modal.dialog("close")
      @showImage(responseJSON.url)
      @$el.find("a").hide()

  showImage: (image_url) =>
    u = @$el.find(".input")
    u.html("")
    $image = $("<img>", { src: image_url })
    u.append $image
    u.addClass("thumb")
    @model.set("content", image_url)

  isImage: (content) =>
     regex = /(.+\/.*\.(?:|gif|jpeg|png|jpg))/
     content.match(regex)

  render: =>
    @$el.html _.template(@template, @model)
    @showImage(@model.get("content")) if @isImage(@model.get("content"))
    @showUploads()
    this

  ui:
    input: "input"

  val: -> @ui.input.val()

