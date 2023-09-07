# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StringRotationsController, type: :controller do
  describe 'create string_rotation' do
    context 'given string to be converted into ROT13' do
      let!(:original_string) { 'This is a test string 13' }
      let!(:create_valid_params) do
        { string_rotation: { original_string: original_string } }
      end
      let!(:create_invalid_params) do
        { string_rotation: { original_string: nil } }
      end
      let!(:create_empty_params) do
        { string_rotation: { original_string: '' } }
      end

      it 'converts a string to ROT13' do
        post :create, params: create_valid_params, as: :json

        expect(response.status).to eq(200)
        expect(StringRotation.count).to eq 1
      end

      it 'should not create an object for invalid params' do
        post :create, params: create_invalid_params

        expect(response.status).to eq(422)
        expect(StringRotation.count).to eq 0
      end

      it 'should not create an object for empty params' do
        post :create, params: create_empty_params

        expect(response.status).to eq(422)
        expect(StringRotation.count).to eq 0
      end
    end
  end
end
