class Api::V1::MinUrlsController < AppController
  before_action :set_min_url, only: [:show, :update]

  def create
    t_params = min_urls_params
    t_params["url"] = MinUrl.make_proper_url t_params["url"]
    @min_url = MinUrl.find_or_create_by(t_params)
    if @min_url
      respond_with @min_url, status: :created, location: "/"
    else
      respond_with @min_url.errors, status: :unprocessable_entity
    end
  end

  def update
    if @min_url.update(min_urls_params)
      respond_with @min_url, status: :ok
    else
      respond_with @min_url.errors, status: :unprocessable_entity
    end
  end

  def show
    respond_with @min_url
  end

  def is_token_alias_available
    respond_with({is_available: MinUrl.is_token_alias_available(params[:token_alias])})
  end

  private

    def set_min_url
      @min_url = MinUrl.find_by_token(params[:token])
    end

    def min_urls_params
      params.require(:min_url).permit(:url, :token_alias)
    end

end