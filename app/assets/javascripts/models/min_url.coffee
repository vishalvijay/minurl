class MU.M.MinUrl extends Backbone.RelationalModel
  url: "/api/min_urls.json"

  relations: [
    type: Backbone.HasOne,
    key: 'report',
    relatedModel: 'MU.M.Report',
    reverseRelation: {
      type: Backbone.HasOne,
      key: 'min_url'
    }
  ]