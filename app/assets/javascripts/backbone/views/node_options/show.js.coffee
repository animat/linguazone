#= require ../flickr_search/show
class Linguazone.Views.Games.NodeOption extends Backbone.Marionette.ItemView
  views: []
  className: "nodeOption backbone"

  template: """
    <div class="instruction-label"></div>

    <div class="input"></div>

    <span class="add-content">
      <a href="#" class="text-link" tabindex="-1">+ text</a>
      <a href="#" class="image-link" tabindex="-1">+ image</a>
    </span>
  """

  ui:
    input:       "input"
    image_link:  ".image-link"
    text_link:   ".text-link"
    add_content: ".add-content"

  updateContent: =>
    if @model and @model.get("content") and @model.get("content").content
      @model.set("content", @model.get("content").content)

  events:
    #TODO: add new view here
    "click .image-link"   : 'showImage'
    ".image-link click"   : 'showImage'

    "click .text-link"    : 'showText'
    'change .input input' : 'changeValue'
    'keydown .input input': 'checkEnter'

  checkEnter: (e) ->
    return unless (e.keyCode is 13 or e.keyCode is 10)
    e.preventDefault()
    @trigger("enter:pressed")

  changeValue: (e) =>
    @model.set("content", $(e.currentTarget).val())

  showInput: =>
    @$el.find(".input").show()
    @$el.find(".image").hide()

  isImage: (content) =>
     regex = /(.+\/.*\.(?:|gif|jpeg|png|jpg))/
     content.match(regex)

  showText: (content) =>
    arguments[0].preventDefault() if _.isFunction(arguments[0]?.preventDefault)
    content = null unless typeof content is "string"
    view = new Linguazone.Views.Games.TextContent(content: content, model: @model)
    @views.push view.render()
    @$el.find(".input").append(view.el)

  showImage: (image_url) =>
    arguments[0].preventDefault() if _.isFunction(arguments[0].preventDefault)
    image_url = null unless typeof image_url is "string"
    view = new Linguazone.Views.Games.ImageContent(content: image_url, model: @model)
    @views.push view.render()
    @$el.find(".input").append(view.el)

  showInput: =>
    if @model.get("content")?.type == "image"
      @showImage(@model.get("content").content)
    else
      content = @model.get("content")
      # HACK: can this still happen?
      if content.content
        @showText(content.content)
      else
        @showText(content)

  onRender: =>
    @updateContent()
    @showInput()
    @useOptions()

  useOptions: =>
    return unless @options.node_options

    if @options.node_options.multiple is false
      @ui.add_content.hide()

    unless @options.node_options.allowImage
      @ui.image_link.hide()

    if _.contains(@options.node_options.types, "image")
      @$el.find(".image-link").show()

    if _.contains(@options.node_options.types, "text")
      @$el.find(".text-link").show()

    @$el.find(".instruction-label").text @options.node_options.prompt
