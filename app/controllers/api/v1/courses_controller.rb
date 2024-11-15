class Api::V1::CoursesController < Api::V1::ApplicationController
  def index
    courses = Course.all

    respond_with courses, each_serializer: CourseSerializer
  end

  def show
    course = Course.find(params[:id])

    respond_with course, serializer: CourseSerializer
  end

  def create
    course = Course.new(course_params)
    course.save

    respond_with course, serializer: CourseSerializer
  end

  def update
    course = Course.find(params[:id])
    course.update(course_params)

    respond_with course, serializer: CourseSerializer
  end

  def destroy
    course = Course.find(params[:id])
    course.destroy

    head :no_content
  end

  private

  def course_params
    params.require(:course).permit(:title, :author_id)
  end
end
