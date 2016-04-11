class MinUrlRequest < ActiveRecord::Base
  belongs_to :min_url

  before_save :validate_country

  def self.report mu
    {
      clicks: clicks(mu),
      best_referrers: best_referrers(mu),
      most_browsers: most_browsers(mu),
      most_platforms: most_platforms(mu),
      most_countries: most_countries(mu)
    }
  end

  private
    def self.clicks mu
      {
        total: mu.min_url_requests.count,
        this_months: click_on_or_after(mu, DateTime.now.at_beginning_of_month, "B"),
        last_months: click_bw(mu, 1.months.ago.beginning_of_month, 1.month.ago.end_of_month, "B"),
        this_year: click_on_or_after(mu, DateTime.now.at_beginning_of_year, "Y"),
        last_year: click_bw(mu, 1.years.ago.beginning_of_month, 1.years.ago.end_of_month, "Y")
      }
    end

    def self.click_on_or_after mu, date, type
      {
        name: date.strftime("%#{type}"),
        count: mu.min_url_requests.where("created_at >= ?", date).count
      }
    end

    def self.click_bw mu, date1, date2, type
      {
        name: date1.strftime("%#{type}"),
        count: mu.min_url_requests.where('created_at >= ? and created_at <= ?', date1, date2).count
      }
    end

    def self.best_referrers mu
      mu.min_url_requests.group(:ref_url).limit(10).order('count(*) desc').count.to_a.map{|item|
        name = item[0] ? Addressable::URI.parse(item[0]).host : "Direct"
        {
          href: item[0], count: item[1], name: name
        }
      }
    end

    def self.most_browsers mu
      mu.min_url_requests.group(:browser).limit(10).order('count(*) desc').count.to_a.map{|item|
        {
          name: item[0], count: item[1]
        }
      }
    end

    def self.most_platforms mu
      mu.min_url_requests.group(:platform).limit(10).order('count(*) desc').count.to_a.map{|item|
        {
          name: item[0], count: item[1]
        }
      }
    end

    def self.most_countries mu
      mu.min_url_requests.group(:country).limit(10).order('count(*) desc').count.to_a.map{|item|
        {
          name: item[0], count: item[1]
        }
      }
    end

    def validate_country
      self.country = "Unknown" if country == "Reserved" || !country
    end

end
