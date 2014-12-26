#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Linguazone =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

Linguazone.App = new Backbone.Marionette.Application()

Linguazone.App.addRegions
  customizer: "#customizer"
  examples:   "#examples"

Linguazone.App.on "initialize:after", ->
  load_game_type = (activity_id, language_id) =>

    game_type = new Linguazone.Models.GameType
    game_type.fetch
      data:
        activity_id: activity_id
        # TODO: The language ID won't always be available in the querystring (if the user has a default language set)
        language_id: language_id

      success: ->
        Linguazone.App.examples.show new Linguazone.Views.GameType({ model: game_type })

        _.each game_type.get("lists"), (list) ->
          view = new Linguazone.Views.Games.OptionListView({name: list.linkedto })
          $("#option-lists").append(view.render().el)

  style_activity = ($activity) ->
    swf_name = $activity.find("a").data("swf")

    $activity.show().find(".icons").hide()
    $activity.addClass("selected_activity_banner")
    $activity.css("background", "#ECF8F9 url(/games/#{swf_name}/display/selected_banner.jpg) no-repeat 160px") if swf_name and false
    $activity.css("text-align", "left")

    $activity.css("padding-left", "160px")
    $activity.find(".activity_details").show()

  show_customizer = (e)  ->
    e.preventDefault()
    $activity = $(this)

    style_activity($activity)

    $(".step1").hide()
    $(".activity").hide()

    activity_id = $activity.find("a").data("id")
    options = $activity.find("a").data("node-options")

    if options and typeof options isnt "object"
      options = JSON.parse options

    view = new Linguazone.Views.Games.NewView
      options:     options
      activity_id: activity_id
      game_type:   $activity.find("a").data("gameType")
      language_id: QueryString.language

    load_game_type activity_id, QueryString.language

    Linguazone.App.customizer.show view

  $(".activity").click show_customizer
  $(".activity a").click show_customizer

  $editor = $("#game-editor")

  if $editor.length
    model = new Linguazone.Models.Game
      id: $editor.data("gameId")
    model.fetch().success =>
      lists = model.get("lists")
      views= []
      for name of lists
        view = new Linguazone.Views.Games.OptionListView({name: name, list: lists[name] })
        views.push view
        $("#option-lists").append(view.render().el)

      for view in views
        view.updateOptionList()

      editView = new Linguazone.Views.Games.EditView
        model: model

      Linguazone.App.customizer.show(editView)

$ ->
  Linguazone.App.start()
  $(".venobox").venobox()
  $('.body').mixItUp()
