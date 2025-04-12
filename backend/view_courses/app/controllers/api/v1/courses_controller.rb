# app/controllers/api/v1/courses_controller.rb
module Api
  module V1
    class CoursesController < ApplicationController
      before_action :authorized

      # GET /api/v1/courses
      def index
        @courses = Course.all

        # ensure that the id of each course is included in the response
        @courses = @courses.map do |course|
          course.as_json.merge(id: course.id) # Add the id to the course JSON representation
        end
        render json: @courses
      end

      # GET /api/v1/courses/search?code=STDISCM
      def search
        if params[:code].present?
          code = params[:code].upcase.strip
          courses = Course.where('UPPER(code) = ?', code)

          # ensure that the id of each course is included in the response
          courses = courses.map do |course|
            course.as_json.merge(id: course.id) # Add the id to the course JSON representation
            render json: courses, status: :ok
          end

          if courses.empty?
            render json: { message: 'No courses found' }, status: :not_found
          else

          
        else
          render json: { error: "Missing 'code' query parameter" }, status: :bad_request
        end
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
