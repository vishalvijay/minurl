class MU.V.Details extends Backbone.View

  template: JST['details']
  className: "details-section"
  
  render: ->
    $(@el).html(@template())
    this