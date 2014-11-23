class MU.M.MinUrl extends Backbone.RelationalModel
  idAttribute: "token"

  relations: [
    type: Backbone.HasOne,
    key: 'report',
    relatedModel: 'MU.M.Report',
    reverseRelation: {
      type: Backbone.HasOne,
      key: 'min_url'
    }
  ]

  getUrl: ->
    @get "url"

  getShortUrl: ->
    @get "short_url"

  getAliasUrl: ->
    @get "alias_url"

  getToken: ->
    @get "token"

  getTokenAlias: ->
    @get "token_alias"

  getCreatedAt: ->
    new Date(@get "created_at").toDateString()

  getImageUrl: ->
    @get "image_url"

  getReport: ->
    @get "report"