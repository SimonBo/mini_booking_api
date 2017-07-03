class Api::V1::ApiResourceController < JSONAPI::ResourceController
  include JSONAPI::Utils
  include Concerns::JwtHandling

  before_action :authenticate
  rescue_from ActiveRecord::RecordNotFound, with: :jsonapi_render_not_found

  private

  def authenticate
    authenticate_api_key || render_unauthorized
  end

  def authenticate_api_key
    api_key = request.headers['X-Api-Key']
    api_key == '12345'
  end

  def render_unauthorized
    jsonapi_render_errors json: [{ title: 'Bad credentials' }], status: 401
  end
end
