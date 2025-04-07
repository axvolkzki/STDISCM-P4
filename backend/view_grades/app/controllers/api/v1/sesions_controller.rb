module Api::V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      
      def create
        user = User.find_by(id: params[:id])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: { 
            logged_in: true,
            user: user.as_json(except: [:password_digest, :created_at, :updated_at]),
            redirect_to: dashboard_path # Add this line
          }
        else
          render json: { 
            status: 401,
            errors: ['Invalid credentials']
          }, status: :unauthorized
        end
      end
  
      def destroy
        reset_session
        render json: { status: 200, logged_out: true }
      end
  
      def show
        if current_user
          render json: {
            logged_in: true,
            user: current_user.as_json(except: [:password_digest, :created_at, :updated_at])
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