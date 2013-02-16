Linguazone.Views.Games ||= {}
Linguazone.Words ||= {}

class Linguazone.Views.Games.WordListView extends Backbone.View
  template: """<h4>Add Words</h4><textarea style='height: 100px;'></textarea> """

  events: "blur textarea" : "updateWordList"

  initialize: (options) ->
    @name = options.name
    Linguazone.Words[@name] = new Linguazone.Collections.WordCollection

  collection: =>
    Linguazone.Words[@name]

  words: () -> @$el.find("textarea").val().split("\n")

  updateWordList: =>
    @collection().update_from @words()
    Linguazone.Words[@name] = @collection()
    Linguazone.App.vent.trigger("wordlist:update")

  render: =>
    @$el.html(@template)
    @$el.css("float", "left").css("padding", "20px")
    return this
