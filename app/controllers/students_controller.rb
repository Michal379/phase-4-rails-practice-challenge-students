class StudentsController < ApplicationController

    def index
        students = Student.all
        render json: instructors, status: :created    
        end
    
        def show
        student = find_student
        render json: student.to_json(except: [:created_at, :updated_at]), status: :created
        end
    
        def create
        student = Student.new(student_params)
        if student.save
            render json: student.to_json(except: [:created_at, :updated_at]), status: :created
          else
            render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
          end
        end
       
        def destroy
        student = find_student
        if student
        student.destroy
        head :no_content 
        else
            render json: { errors: "Oops! student not found"}, status: :not_found 
        end
    end
    
    private
    def find_student
        Instructor.find_by(id: params[:id])
    end
    
    private 
    def student_params
        params.permit(:name)
    end
    
end
