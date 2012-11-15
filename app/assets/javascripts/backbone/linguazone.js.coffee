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
  init: ->
    $(".activity a").click (e) ->
      e.preventDefault()
      $(".activity").hide()
      $(this).parent(".activity").show()
      # TODO: Would it be useful to consider adding a CSS class/ tweaking the UI to add a large banner image BG for each game?
      $(this).parent(".activity").addClass("selected_activity_banner")
      $(this).parent(".activity").find(".activity_details").show()
      $(this).hide()
      activity_id = $(this).data("id")

      view = new Linguazone.Views.Games.NewView
        activity_id: activity_id
        game_type:   $(this).data("gameType")
        language_id: QueryString.language
      window.Linguazone.AppView = view.render()
      $("#customizer").append(window.Linguazone.AppView.el)

     $editor = $("#game-editor")
     if $editor.length
       model = new Linguazone.Models.Game
         id: $editor.data("gameId")
       model.fetch()
       view = new Linguazone.Views.Games.EditView
         model: model
       window.Linguazone.AppView = view

       $("#customizer").append(window.Linguazone.AppView.el)

$ window.Linguazone.init

