class MU.Router extends Backbone.Router
  routes:
    '': 'index'

  initialize: ->
    @routesHit = 0
    Backbone.history.on "route", (->
      @routesHit++
    ), @

  index: ->

  back: (url = "") =>
    if @routesHit > 1
      window.history.back()
    else
      @navigate url,
        trigger: true
        replace: true