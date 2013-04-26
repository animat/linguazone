#= require ../flickr_search/show
class Linguazone.Views.Games.NodeOption extends Backbone.Marionette.ItemView
  views: []
  className: "nodeOption backbone"

  template: """
    <div class="input"></div>

    add: <a href="#" class="text-link">text</a>
    <a href="#" class="image-link">image</a>

    <div class="instruction-label"></div>

    <a href="#">add correct response</a>
  """

  ui:
    input:      "input"
    image_link: "image-link"
    text_link:  "text-link"

  updateContent: =>
    if @model and @model.get("content") and @model.get("content").content
      @model.set("content", @model.get("content").content)

  events:
    #TODO: add new view here
    "click .image-link"   : 'showImage'
    ".image-link click"   : 'showImage'

    "click .text-link"    : 'showText'
    'change .input input' : 'changeValue'

  changeValue: (e) =>
    @model.set("content", $(e.currentTarget).val())

  showInput: =>
    @$el.find(".input").show()
    @$el.find(".image").hide()

  isImage: (content) =>
     regex = /(.+\/.*\.(?:|gif|jpeg|png|jpg))/
     content.match(regex)

  showText: (content) =>
    @removeEmptyViews()
    content = null unless typeof content is "string"
    view = new Linguazone.Views.Games.TextContent(content: content, model: @model)
    @views.push view.render()
    @$el.find(".input").append(view.el)

  showImage: (image_url) =>
    @removeEmptyViews()
    image_url = null unless typeof image_url is "string"
    view = new Linguazone.Views.Games.ImageContent(content: image_url, model: @model)
    @views.push view.render()
    @$el.find(".input").append(view.el)

  removeEmptyViews: ->
    emptyView = _.findWhere(@views, (v) -> not v.populated)
    emptyView.remove() if emptyView

  showInput: =>
    if @model.get("content").type == "image"
      @showImage(@model.get("content").content)
    else
      @showText(@model.get("content").content)

  render: =>
    @updateContent()
    @$el.html _.template(@template, @model)
    @showInput()
    @useOptions()
    this

  toggleAddMoreLink: =>

  useOptions: =>
    return unless @options.node_options

    unless _.contains(@options.node_options.types, "image")
      @$el.find(".image-link").hide()

    unless _.contains(@options.node_options.types, "text")
      @$el.find(".text-link").hide()

    @$el.find(".instruction-label").text @options.node_options.prompt
