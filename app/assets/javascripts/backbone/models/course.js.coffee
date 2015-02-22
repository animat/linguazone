class Linguazone.Collections.Courses extends Backbone.Collection
  url: '/courses.js'

courses = undefined
Linguazone.App.reqres.addHandler "entities:courses:list", ->
  # cache this in a closue
  return courses if courses

  courses = new Linguazone.Collections.Courses
  courses.fetch()
  courses
