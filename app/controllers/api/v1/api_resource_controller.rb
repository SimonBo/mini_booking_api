class Api::V1::ApiResourceController < JSONAPI::ResourceController
  before_action :authenticate

  private

  def authenticate
    authenticate_api_key || render_unauthorized
  end

  def authenticate_api_key
    api_key = request.headers['X-Api-Key']
    api_key == '12345'
  end

  def render_unauthorized
    render json: 'Bad credentials', status: 401
  end
end
