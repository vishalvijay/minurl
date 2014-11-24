class MU.App

  initialize: ->
    @migrate()
    @startApp()

  migrate: ->

  startApp: ->
    @view = new MU.V.Main()
    @openApp()

  openApp: ->
    MU.U.renderView $("#mu-app"), @view
    @router = new MU.Router()
    Backbone.history.start root: MU.CN.APP_URL