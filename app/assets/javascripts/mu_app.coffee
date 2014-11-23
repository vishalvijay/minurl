class MU.App

  initialize: ->
    @migrate()
    @startApp()

  migrate: ->

  startApp: ->
    @initData()
    @view = new MU.V.Main()
    @openApp()

  openApp: ->
    MU.U.renderView $("#mu-app"), @view
    @router = new MU.Router()
    Backbone.history.start root: MU.C.APP_URL, pushState: true

  initData: ->