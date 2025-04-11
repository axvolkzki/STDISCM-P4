module Api
    module V1
      class DashboardController < ApplicationController
        before_action :authenticate_user 
  
        def student
          if @current_user&.role == 'student'
            render json: {
              student: {
                first_name: @current_user.first_name,
                last_name: @current_user.last_name,
                middle_name: @current_user.middle_name,
                student_id: @current_user.id
              }
            }, status: :ok
          else
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end

        def professor
          if @current_user&.role == 'faculty'
            render json: {
              professor: {
                first_name: @current_user.first_name,
                last_name: @current_user.last_name,
                middle_name: @current_user.middle_name,
                professor_id: @current_user.id
              }
            }, status: :ok
          else
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        end
  
        private
  
        def authenticate_user
          token = request.headers['Authorization']&.split(' ')&.last
          if token && (decoded_token = JwtService.decode(token))
            @current_user = User.find_by(id: decoded_token['user_id'])

            unless @current_user
              render json: { error: 'Invalid user' }, status: :unauthorized
            end
          else
            render json: { error: 'Unauthorized' }, status: :unauthorized
          end
        rescue JWT::DecodeError, JWT::ExpiredSignature
          render json: { error: 'invalid or expired session token' }, status: :unauthorized
        end
      end
    end
  end