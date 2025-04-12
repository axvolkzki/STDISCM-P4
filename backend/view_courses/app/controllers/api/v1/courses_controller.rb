# app/controllers/api/v1/courses_controller.rb
module Api
  module V1
    class CoursesController < ApplicationController
      before_action :authorized

      # GET /api/v1/courses
      def index
        @courses = Course.all
        render json: @courses
      end

      def decoded_token
          token = request.headers['Authorization']&.split(' ')&.last
          return unless token

          begin
            JwtService.decode(token)
          rescue => e
            Rails.logger.error "JWT Decode Failed: #{e.class} - #{e.message}"
            nil
          end
      end

      def current_user
          if decoded_token
            @current_user_payload
          end
      end

      def authorized
        @current_user_payload = decoded_token
        unless @current_user_payload
          render json: { message: 'Please log in' }, status: :unauthorized    
        end
      end
    end
  end
end