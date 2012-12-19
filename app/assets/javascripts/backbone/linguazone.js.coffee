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

      game_type = new Linguazone.Models.GameType
      game_type.fetch
        data:
          activity_id: activity_id
          language_id: QueryString.language
        success: ->
          view = new Linguazone.Views.GameType({ model: game_type })

          #_.each examples.models, (model) ->

          #  # setting this class name will let us position the examples correctly in css.
          #  #
          #  # TODO: consider moving to a question class, and having activities have a list of questions.
          #  # that would still require something to know how to position questions.
          #  className = "#{model.get("question_name")}-example"

          #  view = new Linguazone.Views.Examples.ExampleView({ example: model, className: className})
          $("#examples").append(view.render().$el)
          #  view.$el.hide()

      window.Linguazone.AppView = view.render()
      $("#customizer").append(window.Linguazone.AppView.el)

     $editor = $("#game-editor")
     if $editor.length
       model = new Linguazone.Models.Game
         id: $editor.data("gameId")
         game_type: game_type
       model.fetch()
       view = new Linguazone.Views.Games.EditView
         model: model
       window.Linguazone.AppView = view

       $("#customizer").append(window.Linguazone.AppView.el)

$ window.Linguazone.init

