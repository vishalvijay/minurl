class MainController < ApplicationController
  def index
    token = params[:token]
    if token.present?
      min_url = MinUrl.find_by_token_or_token_alias token
      if min_url
        min_url.min_url_requests << MinUrlRequest.new(ip: request.remote_ip, ref_url: request.referer)
        redirect_to(min_url.url) and return
      else
        @token = token
      end
    end
    render nothing: true
  end
end