# frozen_string_literal: true

# api/v1/controllers/string_rotations_controller.rb
module Api
  module V1
    class StringRotationsController < BaseController
      before_action :check_string_rotation

      def create
        @string_rotation = StringRotation.new(string_rotation_params)
        @string_rotation.save!
      end

      private

      def string_rotation_params
        params.require(:string_rotation).permit(:original_string)
      end

      def check_string_rotation
        @string_rotation = StringRotation.find_by(original_string: string_rotation_params[:original_string])
        render @string_rotation if @string_rotation.present?
      end
    end
  end
end
