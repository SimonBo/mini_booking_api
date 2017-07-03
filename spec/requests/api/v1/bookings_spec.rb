require 'rails_helper'

RSpec.describe 'Bookings', type: :request do
  let(:booking) { create :booking }
  let(:rental) { create :rental }
  let(:headers) { { 'Content-Type': 'application/vnd.api+json', 'X-Api-Key': '12345' } }

  describe 'GET index' do
    it 'responds with bookings' do
      bookings = create_list :booking, 3
      get api_v1_bookings_path, params: {}, headers: headers
      expect(response.status).to eq(200)
      expect(response.body).to be_json_api_response_for('bookings')
    end

    it "responds with unauthorized if api_key is missing" do
      get api_v1_bookings_path, {
        params: {},
        headers: { 'Content-Type': 'application/vnd.api+json' }
      }
      expect(response.status).to eq(401)
    end

    it "responds with unauthorized if api_key is invalid" do
      get api_v1_bookings_path, {
        params: {},
        headers: { 'Content-Type': 'application/vnd.api+json', 'X-Api-Key': '1234512' }
      }
      expect(response.status).to eq(401)
    end
  end

  describe 'GET show' do
    it 'responds with a booking' do
      get api_v1_booking_path(booking), params: {}, headers: headers
      expect(response.status).to eq(200)
      expect(response.body).to be_json_api_response_for('bookings')
    end
  end

  describe 'POST create' do
    it 'creates a booking' do
      user = create :user

      params ={
        data: {
          type: 'bookings',
          attributes: {
            'start-at': 1.day.ago,
            'end-at': Time.current,
            price: 100,
            'client-email': 'arnold@schwarzenegger.com'
          },
          relationships: {
            rental: {
              data: {
                type: 'rentals',
                id: rental.id
              }
            },
            user: {
              data: {
                type: 'users',
                id: user.id
              }
            }
          }
        }
      }.to_json
      post api_v1_bookings_path, params: params, headers: headers

      expect(response.status).to eq(201)
      expect(response.body).to be_json_api_response_for('bookings')
    end

    it 'responds with errors' do
      params ={
        data: {
          type: 'bookings',
          attributes: {
            'start-at': 1.day.ago,
            'end-at': Time.current,
            price: 100
          },
          relationships: {
            rental: {
              data: {
                type: 'rentals',
                id: rental.id
              }
            }
          }
        }
      }.to_json

      post api_v1_bookings_path, params: params, headers: headers

      expect(response.status).to eq(422)
      expect(response.body).to have_jsonapi_errors_for('/data/attributes/client-email')
    end
  end

  describe 'PUT update' do
    it 'updates the resource' do
      params = {
        data: {
          type: 'bookings',
          id: booking.id,
          attributes: {
            'client-email': 'szymon@email.com'
          }
        }
      }.to_json
      put api_v1_booking_path(booking), params: params, headers: headers

      expect(response.status).to eq(200)
      expect(booking.reload.client_email).to eq 'szymon@email.com'
      expect(response.body).to be_json_api_response_for('bookings')
    end

    it 'responds with errors' do
      params = {
        data: {
          type: 'bookings',
          id: booking.id,
          attributes: {
            'client-email': nil
          }
        }
      }.to_json
      put api_v1_booking_path(booking), params: params, headers: headers

      expect(response.status).to eq(422)
      expect(response.body).to have_jsonapi_errors_for('/data/attributes/client-email')
    end
  end

  describe '#DELETE destroy' do
    it 'deletes the resource' do
      delete api_v1_booking_path(booking), params: {}, headers: headers
      expect(response.status).to eq(204)
      expect(Booking.count).to eq 0
    end
  end
end
