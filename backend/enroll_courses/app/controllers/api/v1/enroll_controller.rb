module Api
    module V1
      class EnrollController < ApplicationController
        before_action :authorized
        
        def list
            enrollments = EnrolledCourse
              .includes(:course)
              .where(users_id: current_user.id)
          
            result = enrollments.map do |enroll|
              course = enroll.course
              {
                course_id: course.id,
                code: course.code,
                name: course.name,
                maxStudents: course.maxStudents,
                numStudents: course.numStudents,
                section: course.section
              }
            end
          
            render json: result
          end
          

        def enroll
            course = Course.find_by(id: params[:course_id])
  
            unless course
                return render json: { error: 'cannot find class' }, status: :not_found
            end
  
            if course.numStudents >= course.maxStudents
                return render json: { error: 'This class is already full' }, status: :unprocessable_entity
            end
  
            if EnrolledCourse.exists?(users_id: current_user.id, courses_id: course.id)
                return render json: { error: 'You already enrolled in this class' }, status: :conflict
            end

            enrolled = EnrolledCourse.new(users_id: current_user.id, courses_id: course.id)
            if enrolled.save
                course.increment!(:numStudents)
                render json: { message: 'Enrollment successful :>', enrolled: enrolled }, status: :created
            else
                render json: { error: 'Enrollment failed XD XD XD' }, status: :unprocessable_entity
            end
        end
  
        def index
          @enrolled_courses = EnrolledCourse
                                .joins('INNER JOIN "courses" ON "courses".id = "enrolled_courses".courses_id')
                                .joins('INNER JOIN "users" ON "users".id = "enrolled_courses".users_id')
                                .select("enrolled_courses.*, users.*, courses.*")
                                .order("enrolled_courses.id DESC")
  
          render json: @enrolled_courses
        end
  
        private
  
        def decoded_token
          token = request.headers['Authorization']&.split(' ')&.last
          return unless token
  
          JwtService.decode(token)
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
  