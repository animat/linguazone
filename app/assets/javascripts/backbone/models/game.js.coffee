class Linguazone.Models.Game extends Backbone.Model
  urlRoot: '/game_data'
  paramRoot: 'game'

  initialize: ->
    @game_type = @get("game_type")
    @set("nodes",  new Linguazone.Collections.NodeCollection)

  fetch: ->
    super
      success: (model, response) =>
        nodes = new Linguazone.Collections.NodeCollection
        _.each response.nodes, (nodeHash) =>
          node = new Linguazone.Models["#{@get("game_type")}Node"] nodeHash
          nodes.add node
        model.set("nodes", nodes)

  addBlankNode: =>
    console.log 'yeah'
    console.log "Game Type", @get("game_type")
    @get("nodes").add new Linguazone.Models["#{@get("game_type")}Node"]

  defaults:
    activity_id: null

class Linguazone.Collections.GameCollection extends Backbone.Collection
  model: Linguazone.Models.Game
  url: '/game'
