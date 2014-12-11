class Linguazone.Models.Game extends Backbone.Model
  urlRoot: '/game_data'
  paramRoot: 'game'

  initialize: ->
    @game_type = @get("game_type")
    @set("nodes",  new Linguazone.Collections.NodeCollection)
    @classes = new Linguazone.Collections.ClassCollection
    console.log "Initializing the game model. Fetching classes."
    console.log @classes
    @classes.fetch
      success: (response, xhr) ->
        console.log(response)
        classCollectionView = new Linguazone.Views.ClassCollectionView({ collection: response, $el: $("#classes_metadata") })
        return

      error: (errorResponse) ->
        console.log "Red alert!" + errorResponse
        return


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