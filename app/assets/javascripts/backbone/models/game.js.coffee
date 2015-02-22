class Linguazone.Models.Game extends Backbone.Model
  urlRoot: '/game_data'
  paramRoot: 'game'

  initialize: ->
    @set("nodes",  new Linguazone.Collections.NodeCollection)
  fetch: ->
    super
      success: (model, response) =>
        nodes = new Linguazone.Collections.NodeCollection
        _.each response.nodes, (nodeHash) =>
          throw "No Game Type Defined" unless @get('game_type')
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
