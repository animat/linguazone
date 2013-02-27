Linguazone.Views.Games ||= {}
Linguazone.Options ||= {}

class Linguazone.Views.Games.OptionListView extends Backbone.View
  template: """<h4>Add Words</h4><textarea style='height: 100px;'></textarea> """

  events: "blur textarea" : "updateOptionList"

  initialize: (options) ->
    @name = options.name
    Linguazone.Options[@name] = new Linguazone.Collections.OptionCollection
    if options.list
      Linguazone.Options[@name].update_from options.list

  collection: =>
    Linguazone.Options[@name]

  words: () -> @$el.find("textarea").val().split("\n")

  updateOptionList: =>
    @collection().update_from @words()
    Linguazone.Options[@name] = @collection()
    Linguazone.App.vent.trigger("wordlist:update")

  render: =>
    @$el.html(@template)
    if @collection()
      @$el.find("textarea").text(@collection().to_a().join("\n"))
    @$el.css("float", "left").css("padding", "20px")
    return this
