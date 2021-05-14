class StudentsController < ApplicationController

  def index
    students = Student.all
    render json: students
  end

  def create
    student = Student.create(student_params)
    if student.valid?
      render json: student, status: :created
    else
      render json: { error: student.errors }, status: :unprocessable_entity
    end
  end

  def show
    student = Student.find_by(id: params[:id])
    if student
      render json: student
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  def destroy
    student = Student.find_by(id: params[:id])
    if student
      student.destroy!
      head :no_content
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end
  
  def update
    student = Student.find_by(id: params[:id])
    if student
      student.update(student_params)
      render json: student
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  private
  
  def student_params
    params.permit(:first_name, :last_name)
  end
end
