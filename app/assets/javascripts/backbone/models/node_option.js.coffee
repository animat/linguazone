class Linguazone.Models.NodeOption extends Backbone.Model
  urlRoot: '/node_options'

  addContent: (content) ->
    if @get("content") and @get("content") != content
      @arrayify()
      @get("content").push(content)
    else
      @set("content", content)

  set: (key, value) ->
    if key is "content" and value.content
      value = @decontent(value)
    super(key, value)

  # HACK: rails is going to return content.content sometimes.
  # this should never infect a model.
  decontent: (key) ->
    return @decontent(key.content) if key.content
    key

  arrayify: ->
    @set("content", [@get("content")]) unless typeof @get("content") == 'object'
