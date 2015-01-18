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

    activityId = $activity.find("a").data("id")
    gameType = $activity.find("a").data("gameType")

    style_activity($activity)

    $(".step1").hide()
    $(".activity").hide()

    route = "activity/#{activityId}/gameType/#{gameType}/new"

    options = $activity.find("a").data("node-options")

    if options and typeof options isnt "object"
      options = JSON.parse options

    # HACK: move all this data client side instead of DOM
    Linguazone.currentNodeOptions = options

    Backbone.history.navigate route, trigger: true

  $(".activity").click show_customizer

  Backbone.history.start()

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

Linguazone.App.commands.addHandler "message", (message, type="log") ->
  console[type]?(message)
  alert(message)

Linguazone.App.reqres.addHandler "current_activity_id", ->
  re = /activity\/([0-9]+)\/(.)+/
  Backbone.history.getFragment().match(re)[1]

_.extend Backbone.Marionette.Renderer,
  render: (template, data) ->
    if _.isFunction(template)
      template(data)
    else
      _.template(template)?(data)



# When Fetched Helper
# Stolen from Brian Mann. http://backbonerails.com
#
# But a _fetch variable on a backbone colleciton that'll contain an xhr of the sync performed.
do (Backbone) ->
  _sync = Backbone.sync

  Backbone.sync = (method, entity, options = {}) ->
    _.defaults options,
      beforeSend: _.bind(methods.beforeSend,  entity)
      complete:   _.bind(methods.complete,    entity)

    sync = _sync(method, entity, options)
    if !entity._fetch and method is "read"
      entity._fetch = sync
    sync

  methods =
    beforeSend: ->
      @trigger "sync:start", @

    complete: ->
      @trigger "sync:stop", @

# Perform the callback only after all entities passed in have been
# fetched.  Can take a single collection or an array.
Linguazone.App.commands.addHandler "when:fetched", (entities, options) ->
  if _.isFunction(options)
    success = options
  else
    { success, error, always } = options

  xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

  $.when(xhrs...).done(success)  if success
  $.when(xhrs...).always(always) if always
  $.when(xhrs...).fail(error)    if error


$ ->
  Linguazone.App.start()
  $(".venobox").venobox()
  $('.body').mixItUp()
