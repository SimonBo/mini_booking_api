require 'rails_helper'

RSpec.describe 'Rentals', type: :request do
  let(:rental) { create :rental, daily_rate: 100 }
  let(:headers) { { 'Content-Type': 'application/vnd.api+json' } }

  describe 'GET index' do
    it 'responds with rentals' do
      rentals = create_list :rental, 3
      get api_v1_rentals_path, params: {}, headers: headers
      expect(response.status).to eq(200)
      expect(response.body).to be_json_api_response_for('rentals')
    end

    it 'responds with sorted results' do
      r1 = create :rental, daily_rate: 100
      r2 = create :rental, daily_rate: 200
      r3 = create :rental, daily_rate: 300

      get api_v1_rentals_path, params: { sort: '-daily-rate' }, headers: headers
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)
      rentals_ids = parsed_body['data'].map { |r| r['attributes']['daily-rate'].to_i }
      expect(rentals_ids).to eq([300, 200, 100])
    end

    it 'responds with paginated results' do
      r1 = create :rental, daily_rate: 100
      r2 = create :rental, daily_rate: 200
      r3 = create :rental, daily_rate: 300

      get api_v1_rentals_path, params: { sort: '-daily-rate', page: { size: 1, number: 2 } }, headers: headers
      expect(response.status).to eq(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['data'].size).to eq(1)
    end
  end

  describe 'GET show' do
    it 'responds with a rental' do
      get api_v1_rental_path(rental), params: {}, headers: headers
      expect(response.status).to eq(200)
      expect(response.body).to be_json_api_response_for('rentals')
    end
  end

  describe 'POST create' do
    it 'creates a rental' do
      params ={
        data: {
          type: 'rentals',
          attributes: {
            name: "King\'s Landing",
            'daily-rate': 1000
          }
        }
      }.to_json
      post api_v1_rentals_path, params: params, headers: headers

      expect(response.status).to eq(201)
      expect(response.body).to be_json_api_response_for('rentals')
    end

    it 'responds with errors' do
      params = {
        data: {
          type: 'rentals',
          attributes: {
          }
        }
      }.to_json
      post api_v1_rentals_path, params: params, headers: headers

      expect(response.status).to eq(422)
      expect(response.body).to have_jsonapi_errors_for('/data/attributes/name')
    end
  end

  describe 'PUT update' do
    it 'updates the resource' do
      params = {
        data: {
          type: 'rentals',
          id: rental.id,
          attributes: {
            'daily-rate': 1000
          }
        }
      }.to_json

      put api_v1_rental_path(rental), params: params, headers: headers
      expect(response.status).to eq(200)
      expect(rental.reload.daily_rate).to eq 1000
      expect(response.body).to be_json_api_response_for('rentals')
    end

    it 'responds with errors' do
      params = {
        data: {
          type: 'rentals',
          id: rental.id,
          attributes: {
            'daily-rate': nil
          }
        }
      }.to_json
      put api_v1_rental_path(rental), params: params, headers: headers

      expect(response.status).to eq(422)
      expect(response.body).to have_jsonapi_errors_for('/data/attributes/daily-rate')
    end
  end

  describe '#DELETE destroy' do
    it 'deletes the resource' do
      delete api_v1_rental_path(rental), params: {}, headers: headers
      expect(response.status).to eq(204)
      expect(Rental.count).to eq 0
    end
  end
end
