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
  wordLists:  "#word-lists"

Linguazone.App.on "initialize:after", ->
  $(".activity a").click (e) ->
    e.preventDefault()
    swf_name = $(this).data("swf")
    $(".activity").hide()
    $(this).parent(".activity").show()
    $(this).parent(".activity").find(".icons").hide()
    $(this).parent(".activity").addClass("selected_activity_banner")
    $(this).parent(".activity").css("background", "url(/games/"+swf_name+"/display/selected_banner.jpg) no-repeat")
    $(this).parent(".activity").find(".activity_details").show()
    $(this).hide()
    activity_id = $(this).data("id")

    view = new Linguazone.Views.Games.NewView
      activity_id: activity_id
      game_type:   $(this).data("gameType")
      language_id: QueryString.language

    game_type = new Linguazone.Models.GameType
    game_type.fetch
      data:
        activity_id: activity_id
        # TODO: The language ID won't always be available in the querystring (if the user has a default language set)
        language_id: QueryString.language
      success: ->
        Linguazone.App.examples.show(view) new Linguazone.Views.GameType({ model: game_type })

    window.Linguazone.AppView = view.render()

    $customizer = $("#customizer")

    l_list_view = new Linguazone.Views.Games.WordListView({name: "ltarget"})

    Linguazone.App.wordLists.show l_list_view
    Linguazone.App.customizer.show(window.Linguazone.AppView)

   $editor = $("#game-editor")
   if $editor.length
     model = new Linguazone.Models.Game
       id: $editor.data("gameId")
     model.fetch()
     view = new Linguazone.Views.Games.EditView
       model: model
     window.Linguazone.AppView = view

     $("#customizer").append(window.Linguazone.AppView.el)

$ -> Linguazone.App.start()
