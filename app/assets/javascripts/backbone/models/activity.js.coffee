class Linguazone.Models.Activity extends Backbone.Model

class Linguazone.Models.ActivityCollection extends Backbone.Collection
  url: "/activities.json"
  model: Linguazone.Models.Activity

Linguazone.App.reqres.addHandler "entities:activities:fetch", ->
  console.log "'fetching activity'", 'fetching activity'
  @collection or= new Linguazone.Models.ActivityCollection
  return if @collection.models?.length > 0
  @collection.fetch()
  @collection

Linguazone.App.reqres.addHandler "entities:activity:fetch", (activityId) ->
  model = new Linguazone.Models.Activity
  collection = Linguazone.App.request "entities:activities:fetch"
  Linguazone.App.execute "when:fetched", collection, ->
    match = collection.find((m) -> m.id.toString() == activityId)
    model.set match.attributes
  model._fetch = collection._fetch
  model
