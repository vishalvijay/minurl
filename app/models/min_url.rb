class MinUrl < ActiveRecord::Base
  validates_presence_of :url, :token, :alias
  validates :url, :token, :alias, uniqueness: true

  has_many min_url_requests
end
