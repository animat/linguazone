class Linguazone.Models.Game extends Backbone.Model
  urlRoot: '/game_data'
  paramRoot: 'game'

  initialize: ->
     @set("nodes",  new Linguazone.Collections.NodeCollection)
     @get("nodes").add new Linguazone.Models.Node

  fetch: ->
    super
      success: (model, response) ->
        nodes = new Linguazone.Collections.NodeCollection
        _.each response.nodes, (nodeHash) ->
          node = new Linguazone.Models.Node nodeHash
          nodes.add node
        model.set("nodes", nodes)

  defaults:
    activity_id: null

class Linguazone.Collections.GameCollection extends Backbone.Collection
  model: Linguazone.Models.Game
  url: '/game'