class MU.V.Navbar extends Backbone.View

  template: JST['navbar']

  events:
    "click li": "navigate"

  render: ->
    $(@el).html(@template())
    this

  navigate: (event)->
    @$("li").removeClass "active"
    @$(event.currentTarget).addClass "active"