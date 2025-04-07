# app/controllers/api/v1/courses_controller.rb
module Api
  module V1
    class CoursesController < ApplicationController
      before_action :authenticate_request
      before_action :set_course, only: [:show]

      # GET /api/v1/courses
      def index
        @courses = Course.all
        render json: @courses
      end

      # GET /api/v1/courses/:id
      def show
        render json: @course
      end

      private

      def authenticate_request
        auth_client = AuthServiceClient.new
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        
        begin
          response = auth_client.validate_token(token)
          @current_user = response[:user] if response[:valid]
        rescue => e
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end

      def set_course
        @course = Course.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Course not found" }, status: :not_found
      end
    end
  end
end