Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.NodeBaseView extends Backbone.Marionette.ItemView
  events:
    "change input"          : "updateModel",
    "change select"         : "updateModel",
    "click .delete"         : "delete",
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

  delete: =>
    @trigger("remove")
    @$el.remove()
    @options.node = undefined

  updateModel: (e) =>
    $target = $(e.currentTarget)
    @options.node.set $target.attr("name"), $target.val()

  ui:
    question: ".question input"
    response: ".response input"

  render: =>
    @options.node ||= new Linguazone.Models[@game_type]
    @$el.html _.template(@template, @options.node.attributes)
    @onRender()
    this

  onRender: ->
    @showUploads()
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
