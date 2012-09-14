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
      $(this).hide()
      activity_id = $(this).data("id")
      view = new Linguazone.Views.Games.NewView
        activity_id: activity_id
        language_id: QueryString.language
      window.Linguazone.AppView = view.render()
      $("#customizer").append(window.Linguazone.AppView.el)

$ window.Linguazone.init

