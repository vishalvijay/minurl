class MU.V.Details extends Backbone.View

  template: JST['details']
  className: "details-section"

  events:
    "keyup #alias-form input" : "validateInput"
    "change #alias-form input" : "validateInput"
    "submit #alias-form" : "updateAlias"

  initialize: ->
    @model.on "change", @render, @
  
  render: ->
    $(@el).html(@template(mu: @model))
    @initViews()
    setTimeout @afetrRender, 10
    this

  afetrRender: =>
    @$(".short-url input").select()
    @$(".readonly").tooltip("show")
    @initAddThis()
  
  initViews: ->
    @$('[data-toggle="tooltip"]').tooltip()

  initAddThis: ->
    addthis.button("#share-button") if window.addthis

  validateInput: ->
    if MU.U.getValue(@$("#alias-form input")).length
      MU.U.changeDisableState @$("#alias-form button"), false
      true
    else
      MU.U.changeDisableState @$("#alias-form button")
      false

  updateAlias: (event) ->
    event.preventDefault()
    return unless @validateInput()
    submitButton = Ladda.create($("#alias-form button")[0])
    submitButton.start()
    input = @$("#alias-form input")
    alias = MU.U.getValue input
    _this = @
    @model.save {token_alias: alias},
      success: ->
        _this.model.fetch()
      error: (data) ->
        if data.status = 422
          _this.$(".error").fadeIn()
        else
          MU.app.view.showApiError()
        input.focus()
      complete: ->
        submitButton.stop()
