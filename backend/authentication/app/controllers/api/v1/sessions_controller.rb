module Api::V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token             # Skip CSRF token verification for API requests
      skip_before_action :authenticate_request, only: [:create] # Skip authentication for the create action
      
      def create
        user = User.find_by(id: params[:id])

        if user&.authenticate(params[:password])
          token = JwtService.encode(user_id: user.id)           # Store the token in the session

          render json: { 
            logged_in: true,
            token: token, # send jwt token instead of session id
            user: user.as_json(except: [:password_digest, :created_at, :updated_at]),
            message: 'Login successful'
          }, status: :ok
        else
          render json: { 
            status: 401,
            errors: ['Invalid credentials']
          }, status: :unauthorized
        end
      end
  
      def destroy
        render json: { status: 200, logged_out: true }
      end
  
      def show
        if @current_user # If the user is logged in, return their information.
          render json: {
            logged_in: true,
            user: @current_user.as_json(except: [:password_digest, :created_at, :updated_at])
          }
        else
          render json: {
            logged_in: false,
            message: 'No user logged in'
          }
        end
      end
  
      private
  
      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
    end
  end