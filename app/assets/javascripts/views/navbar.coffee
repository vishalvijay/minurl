class MU.V.Navbar extends Backbone.View

  template: JST['navbar']

  render: ->
    $(@el).html(@template())
    this