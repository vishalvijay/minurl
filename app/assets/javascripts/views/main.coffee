class MU.V.Main extends Backbone.View

  template: JST["main"]

  initialize: ->
    @setupViews()
    @screenResizeCallBacks = {}
    MU.U.resize @onScreenResize

  render: ->
    $(@el).html(@template())
    @renderSubviews()
    setTimeout @afterRender, 10
    this

  afterRender: =>
    @registerCallbacks()

  registerCallbacks: ->
    @registerScreenResize "fix-footer-min-height", @fixWelcomeHeight
    @onScreenResize()

  setupViews: ->
    @navbarView = new MU.V.Navbar()
    @footerView = new MU.V.Footer()
    @widgetView = new MU.V.Widget()

  renderSubviews: ->
    MU.U.renderView @$(".navbar-container"), @navbarView
    MU.U.renderView @$(".footer-container"), @footerView
    MU.U.renderView @$(".welcome-section"), @widgetView
  
  registerScreenResize: (key, callback) ->
    @screenResizeCallBacks[key] = callback

  unregisterScreenResize: (key) ->
    delete @screenResizeCallBacks[key]

  onScreenResize: =>
    _.each @screenResizeCallBacks, (callback) ->
      callback()

  fixWelcomeHeight: ->
    # navbarHeight = @$(".navbar-container").outerHeight()
    # windowHeight = $(window).outerHeight()
    # @$("#welcome-container").css "min-height", windowHeight-navbarHeight

  showApiError: =>
    alert "Request could not be processed"