window.MU =
  M: {} #Models
  C: {} #Collections
  V: {} #Views

$ ->
  Backbone.ajax = MU.U.api
  MU.app = new MU.App()
  MU.app.initialize()