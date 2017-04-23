class Api::V1::BookingsController < Api::V1::ApiResourceController
  include JSONAPI::Utils

  #using jsonapi_render to override the default action, just as an example
  def index
    do_some_sophisticated_thing
    jsonapi_render json: Booking.all
  end

  private

  def do_some_sophisticated_thing
    p 'Hello world!'
  end
end
