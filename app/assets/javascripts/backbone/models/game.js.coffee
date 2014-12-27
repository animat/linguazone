class Linguazone.Models.Game extends Backbone.Model
  urlRoot: '/game_data'
  paramRoot: 'game'

  initialize: ->
    @game_type = @get("game_type")
    @set("nodes",  new Linguazone.Collections.NodeCollection)
    @classes = new Linguazone.Collections.ClassCollection
    @classes.fetch
      success: (response, xhr) ->
        classCollectionView = new Linguazone.Views.ClassCollectionView({ collection: response, $el: $("#classes_metadata") })

      error: (errorResponse) ->
        console.error? "couldn't load classes", errorResponse

  fetch: ->
    super
      success: (model, response) =>
        nodes = new Linguazone.Collections.NodeCollection
        _.each response.nodes, (nodeHash) =>
          node = new Linguazone.Models["#{@get("game_type")}Node"] nodeHash
          nodes.add node
        model.set("nodes", nodes)

  addBlankNode: =>
    @get("nodes").add new Linguazone.Models["#{@get("game_type")}Node"]

  defaults:
    activity_id: null
    description: "You ought to put a description on your games."

class Linguazone.Collections.GameCollection extends Backbone.Collection
  model: Linguazone.Models.Game
  url: '/game'
