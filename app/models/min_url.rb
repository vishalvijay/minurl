class MinUrl < ActiveRecord::Base
  validates_presence_of :url, :token
  validates_uniqueness_of :url, :token
  validates_uniqueness_of :token_alias, allow_blank: true, allow_nil: true
  validates :url, url: true
  validate :token_alias_against_token

  has_many :min_url_requests

  before_validation :generate_token
  after_create :pre_request_image

  CHARS = ((48..57).to_a+(65..90).to_a+(97..122).to_a).map(&:chr)

  def self.find_by_token_or_token_alias t_token
    MinUrl.where("token = ? or token_alias = ?", t_token, t_token).first
  end

  def self.is_token_alias_available t_token
    return false unless t_token.present?
    !find_by_token_or_token_alias t_token
  end  

  def self.make_proper_url t_url
    unless t_url.match(/^(http:\/\/|https:\/\/)/)
      t_url = "http://#{t_url}"
    end
    t_url
  end

  def short_url
    "#{Settings.app_url}/#{token}"
  end

  def alias_url
    "#{Settings.app_url}/#{token_alias}" if token_alias
  end

  def image_url
    "https://api.thumbalizr.com/?url=#{url}&width=300"
  end

  def as_json(options = { })
    super({methods: [:short_url, :alias_url, :image_url, :report]}.merge(options))
  end

  def report
    MinUrlRequest.report self
  end

  private
    def generate_token
      return if token.present?
      min_url = MinUrl.last
      if min_url
        last_token_a = min_url.token.split ""
        new_token = get_next_token last_token_a
        while MinUrl.find_by_token_or_token_alias(new_token) do
          new_token = get_next_token new_token.split ""
        end
        self.token = new_token
      else
        self.token = CHARS[0]
      end
    end

    def get_next_token last_token_a
      is_next = false
      i = last_token_a.length-1
      while i > -1 && !is_next do
        index = CHARS.index last_token_a[i]
        if index+1 < CHARS.length
          is_next = true
          last_token_a[i] = CHARS[index+1]
        else
          last_token_a[i] = CHARS[0]
        end
        i-=1
      end
      last_token_a = last_token_a+[CHARS[0]] unless is_next
      last_token_a.join
    end

    def token_alias_against_token
      if errors[:token_alias].blank? && token_alias_changed? && (MinUrl.find_by_token_or_token_alias token_alias)
        errors.add(:token_alias, "has already been taken")
      end
    end

    def pre_request_image
       HTTParty.get url
    end
end