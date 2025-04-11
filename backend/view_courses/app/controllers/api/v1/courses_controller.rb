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

          JwtService.decode(token) # Reuse your JWT service
      rescue JWT::DecodeError
          nil
      end

      def current_user
          if decoded_token
              user_id = decoded_token['user_id']
              @user = User.find_by(id: user_id)
          end
      end

      def authorized
        unless !!current_user
          render json: { message: 'Please log in' }, status: :unauthorized    
        end
      end
    end
  end
end