class Linguazone.Models.NodeOption extends Backbone.Model
  urlRoot: '/node_options'

  addContent: (content) ->
    if @get("content") and @get("content") != content
      @arrayify()
      @get("content").push(content)
    else
      @set("content", content)

  arrayify: ->
    @set("content", [@get("content")]) unless typeof @get("content") == 'object'

