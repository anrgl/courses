class Api::V1::CompetencesController < Api::V1::ApplicationController
  def index
    competences = Competence.all

    respond_with competences, each_serializer: CompetenceSerializer
  end

  def show
    competence = Competence.find(params[:id])

    respond_with competence, serializer: CompetenceSerializer
  end

  def create
    competence = Competence.new(competence_params)
    competence.save

    respond_with competence, serializer: CompetenceSerializer
  end

  def update
    competence = Competence.find(params[:id])
    competence.update(competence_params)

    respond_with competence, serializer: CompetenceSerializer
  end

  def destroy
    competence = Competence.find(params[:id])
    competence.destroy

    respond_with competence, serializer: CompetenceSerializer
  end

  private

  def competence_params
    params.require(:competence).permit(:title)
  end
end
