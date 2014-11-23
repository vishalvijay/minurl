class MU.V.Footer extends Backbone.View

  template: JST['footer']

  render: ->
    $(@el).html(@template())
    this