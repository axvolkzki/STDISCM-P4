module Api
    module V1
      class AuthenticationController < ApplicationController
        class AuthenticationError < StandardError; end
  
        rescue_from ActionController::ParameterMissing, with: :parameter_missing
        rescue_from AuthenticationError, with: :handle_unauthenticated
  
        def login
          raise AuthenticationError unless user
          raise AuthenticationError unless user.authenticate(params.require(:password))
  
          payload = { 
            user_id: user.id,
            role: user.role # Uses the method we just defined
          }
          
          token = JwtService.encode(payload)
  
          render json: { token: token }, status: :created
        end
  
        private
  
        def user
          @user ||= User.find_by(id: params.require(:id))
        end
  
        def parameter_missing(e)
          render json: { error: e.message }, status: :unprocessable_entity
        end
  
        def handle_unauthenticated
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end

        def validate
          token = request.headers['Authorization']&.split(' ')&.last
          raise AuthenticationError unless decoded_token

          render json: {
            valid: true,
            user_id: decoded_token.first['user_id'],
            role: decoded_token.first['role']
          }, status: :ok
        end
      end
    end
  end