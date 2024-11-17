class Api::V1::AuthorsController < Api::V1::ApplicationController
  def index
    authors = Author.includes(courses: :competences)
      .ransack(params[:q])
      .result
      .distinct

    respond_with authors, each_serializer: AuthorSerializer
  end

  def show
    author = Author.find(params[:id])

    respond_with author, serializer: AuthorSerializer
  end

  def create
    author = Author.new(author_params)
    author.save

    respond_with author, serializer: AuthorSerializer
  end

  def update
    author = Author.find(params[:id])
    author.update(author_params)

    respond_with author, serializer: AuthorSerializer
  end

  def destroy
    author = Author.find(params[:id])
    author.destroy

    respond_with author, serializer: AuthorSerializer
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
