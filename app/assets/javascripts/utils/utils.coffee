#Utils
MU.U =
  isScreen: (type = "tab_or_mob") ->
    if type is "tab"
      MU.U.isScreen("tab_or_mob") && !MU.U.isScreen("mob")
    else if type is "mob"
      $(window).width() < 768
    else if type is "tab_or_mob"
      $(window).width() < 992
    else if type is "desk"
      $(window).width() >= 992
    else if type is "desk-small"
      $(window).width() < 1130 and MU.U.isScreen("desk")
    else
      MU.U.error("Unknown screen")

  getValue: (view) ->
    view.val().trim()

  api: (options = {}) ->
    default_opt =
      contentType: "application/json"
      headers:
        Accept: "application/vnd.min_url+json;version=1"
      dataType: "json"
      error: MU.app.view.showApiError
    $.ajax $.extend({}, default_opt, options)

  resize: (callback) ->
    $(window).resize $.throttle(250, callback)

  tPath: (t)->
    "templates/" + t

  error: (msg) ->
    throw new Error(msg)

  renderView: (parent, view, isAppend = false, isAnimate = false) ->
    if isAnimate
      parent.hide()
      parent.fadeIn "fast"
    unless isAppend
      parent.html view.render().el
    else
      parent.append view.render().el

  buildUrl: (url) ->
    "#{MU.CN.APP_URL}#{url}"

  linkNavigate: (event) ->
    event.preventDefault()
    link = $(event.currentTarget).attr('href')
    Backbone.history.navigate link.substr(MU.CN.APP_URL.length), true

  ellipsed: (string, limit) ->
    if not string or string.length <= limit
      string
    else
      "#{string.substring(0, limit-2)}..."

  changeDisableState: (view, isDisabled = true) ->
    if isDisabled
      view.attr "disabled", "disabled"
    else
      view.removeAttr "disabled"