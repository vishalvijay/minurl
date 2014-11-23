class MU.M.Customer extends Backbone.Model

  getCustomer: ->
    @get("customer").customer

  getAddress: ->
    @get("addresses")

  getName: ->
    @getCustomer().name

  getEmail: ->
    @getCustomer().email

  getPoints: ->
    @getCustomer().points

  isCustomer: ->
    not not @getCustomer()

  getPhone: ->
    @getCustomer().phone