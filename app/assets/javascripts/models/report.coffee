class MU.M.Report extends Backbone.RelationalModel

  getClicks: ->
    @get("clicks")

  getBestReferrers: ->
    @get "best_referrers"

  getMostBrowsers: ->
    @get "most_browsers"

  getMostPlatforms: ->
    @get "most_platforms"

  getMostCountries: ->
    @get "most_countries"