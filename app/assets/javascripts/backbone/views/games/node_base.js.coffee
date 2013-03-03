Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.Marionette.ItemView
  events:
    "change input"          : "updateModel",
    "change select"         : "updateModel",
    "click .delete"         : "delete",
    "mouseover"             : "showControls"
    "mouseout"              : "hideControls"
    "load"                  : "hideControls"
    "focus .question input" : "showQuestion"
    "blur .question input"  : "hideQuestion"
    "focus .response input" : "showResponse"
    "blur .response input"  : "hideResponse"

  showQuestion: => $(".question-example").show()
  hideQuestion: => $(".question-example").hide()
  showResponse: => $(".response-example").show()
  hideResponse: => $(".response-example").hide()

  initialize: =>
    @model = @options.node
    # TODO: Can it have the tabs added in as soon as it initializes? Not sure why this is failing.
    @$el.find(".question").tabs()
    @$el.find(".response").tabs()
    @$el.find(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom")
    @$el.removeClass("ui-widget, ui-widget-content")

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  updateModel: (e) =>
    $target = $(e.currentTarget)
    @options.node.set $target.attr("name"), $target.val()

  showControls: (e) =>
    @$el.find("ul.lz_input_toggle").show()
    # Only here while it doesn't work in initialize
    @$el.find(".question").tabs()
    @$el.find(".response").tabs()
    @$el.find(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom")
    @$el.removeClass("ui-widget, ui-widget-content")

  ui:
    question: ".question-input"
    response: ".response input"

  hideControls: (e) =>
    @$el.find("ul.lz_input_toggle").hide()

  render: =>
    @options.node ||= new Linguazone.Models[@game_type]
    @$el.html _.template(@template, @options.node.attributes)
    @onRender()
    this

  onRender: ->
    @showUploads()
    @hideControls()
    @bindUIElements()

  showUploads: =>
    uploader = @$el.find(".upload").fineUploader
      request:
        endpoint: "/images"
      text:
        uploadButton: 'Select Files'
      validation:
        allowedExtensions: ['jpeg', 'jpg', 'png', 'gif'],
        sizeLimit: 512000

    uploader.on "complete", (event, id, fileName, responseJSON)  =>
      u = @$el.find(".upload")
      u.html("")
      $image = $("<img>", { src: responseJSON.url })
      u.append $image
      u.addClass("thumb")
      @options.node.set "question", responseJSON.url


  disable: =>
    @$el.find('.controls_wrapper').remove()
    @$el.find('input').attr("disabled", true)

