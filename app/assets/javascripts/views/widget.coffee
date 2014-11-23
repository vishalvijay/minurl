class MU.V.Widget extends Backbone.View

  template: JST['widget']

  events:
    "submit #create-form" : "createSortUrl"
    "keyup #create-form input" : "valiadteUrl"
    "change #create-form input" : "valiadteUrl"

  initialize: ->
    @collection = new MU.C.MinUrls()

  render: ->
    $(@el).html(@template())
    this

  createSortUrl: (event) ->
    event.preventDefault()
    return unless @valiadteUrl()
    @$(".details-container").slideUp()
    submitButton = Ladda.create($("#create-form button")[0])
    submitButton.start()
    input = @$("#create-form input")
    url = MU.U.getValue input
    @collection.reset()
    Backbone.Relational.store.unregister(@minUrl) if @minUrl
    _this = @
    @minUrl = @collection.create {url: url},
      success: ->
        view = _this.$(".details-container")
        MU.U.renderView view, new MU.V.Details(model: _this.minUrl)
        view.slideDown()
      error: (data) ->
        if data.status = 422
          _this.$(".error").fadeIn()
        else
          MU.app.view.showApiError()
        input.focus()
      complete: ->
        submitButton.stop()

  valiadteUrl: ->
    url = MU.U.getValue @$("#create-form input")
    urlRegExp = /^(?:(?:https?):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/i
    unless urlRegExp.test(url)
      @$(".error").fadeIn()
      MU.U.changeDisableState @$("#create-form button")
      false
    else
      @$(".error").fadeOut()
      MU.U.changeDisableState @$("#create-form button"), false
      true