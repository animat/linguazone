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

  show_customizer = (e)  ->
    e.preventDefault()
    swf_name = $(this).find("a").data("swf")
    $(".activity").hide()
    $(this).show()
    $(this).find(".icons").hide()
    $(this).addClass("selected_activity_banner")
    $(this).css("background", "url(/games/"+swf_name+"/display/selected_banner.jpg) no-repeat")
    $(this).find(".activity_details").show()
    activity_id = $(this).find("a").data("id")
    options = $(this).find("a").data("node-options")
    options = JSON.parse options unless typeof options == "object"

    
    view = new Linguazone.Views.Games.NewView
      options:     options
      activity_id: activity_id
      game_type:   $(this).find("a").data("gameType")
      language_id: QueryString.language

    load_game_type activity_id, QueryString.language

    Linguazone.App.customizer.show view

  $(".activity").click show_customizer

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
