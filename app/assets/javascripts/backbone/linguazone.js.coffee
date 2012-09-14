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

$ ->
  $(".activity a").click (e) ->
    e.preventDefault()
    $(".activity").hide()
    $(this).parent(".activity").show()
    $(this).hide()

    view = new Linguazone.Views.Games.NewView
    $("#customizer").append(view.render().el)

