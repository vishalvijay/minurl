class MU.V.Navbar extends Backbone.View

  template: JST['navbar']

  events:
    "click li": "navigate"

  render: ->
    $(@el).html(@template())
    @setUpMenuNavigation()
    this

  navigate: (event)->
    @$("li").removeClass "active"
    @$(event.currentTarget).addClass "active"

  setUpMenuNavigation: ->
    _this = @
    $(window).scroll ->
      if _this.isViewVisible("#about-us")
        _this.changeMenuActive "#about-us-menu"
      else if _this.isViewVisible("#api")
        _this.changeMenuActive "#api-menu"
      else if _this.isViewVisible("#home")
        _this.changeMenuActive "#home-menu"

  isViewVisible: (elem) ->
    docViewTop = $(window).scrollTop()
    docViewBottom = docViewTop + $(window).height()
    elemTop = $(elem).offset().top
    elemBottom = elemTop + $(elem).height()
    (elemBottom <= docViewBottom) and (elemTop >= docViewTop)

  changeMenuActive: (elem) ->
    @$("li").removeClass "active"
    @$(elem).addClass "active"