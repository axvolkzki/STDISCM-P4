module Api
    module V1
      class AuthenticationController < ApplicationController
        class AuthenticationError < StandardError; end
  
        rescue_from ActionController::ParameterMissing, with: :parameter_missing
        rescue_from AuthenticationError, with: :handle_unauthenticated
  
        def login
          raise AuthenticationError unless user
          raise AuthenticationError unless user.authenticate(params.require(:password))
        
          now = Time.current.to_i
          payload = {
            user_id: user.id,
            role: user.is_professor ? 'professor' : 'student',
            iat: now,
            exp: 1.hour.from_now.to_i
          }
        
          token = JwtService.encode(payload) # This uses 15 min expiration now
        
          render json: {
            token: token,
            user: {
              id: user.id,
              first_name: user.first_name,
              last_name: user.last_name,
              role: user.role
            }
          }, status: :created
        end

        # def logout
        #   raise AuthenticationError unless decoded_token && current_user
        
        #   current_user.update(last_logout_at: Time.current)
        
        #   render json: { message: 'Logged out successfully' }, status: :ok
        # end

        def logout
          raise AuthenticationError unless current_user 
  
          current_user.update(last_logout_at: Time.current)
  
          render json: { message: 'Logged out successfully' }, status: :ok
        end

        # Check if the token is valid and not expired for idle time
        def refresh
          raise AuthenticationError unless decoded_token
        
          new_token = JwtService.encode({
            user_id: decoded_token['user_id'],
            role: decoded_token['role']
          })
        
          render json: { token: new_token }, status: :ok
        end

        def validate 
          raise AuthenticationError unless decoded_token

          render json: {
            valid: true,
            user_id: decoded_token['user_id'],
            role: decoded_token['role']
          }, status: :ok
        end
  
        private
  
        def user
          @user ||= User.find_by(id: params.require(:id))
        end

        def decoded_token
          token = request.headers['Authorization']&.split(' ')&.last
          return unless token
        
          decoded = JwtService.decode(token)
          return nil unless decoded
        
          # Invalidate token if user logged out after it was issued
          user = User.find_by(id: decoded['user_id'])
          if user&.last_logout_at.present? && decoded['iat'] < user.last_logout_at.to_i
            Rails.logger.info("Token issued at #{decoded['iat']} is before last logout at #{user.last_logout_at}")
            return nil
          end
        
          decoded
        rescue JWT::DecodeError, JWT::ExpiredSignature
          nil
        end
  
        def parameter_missing(e)
          render json: { error: e.message }, status: :unprocessable_entity
        end
  
        def handle_unauthenticated
          render json: { error: 'Invalid ID Number or Password' }, status: :unauthorized
        end      
        
        def current_user
          @current_user ||= User.find_by(id: decoded_token['user_id']) if decoded_token
        end
      end
    end
  end