class Competence < ApplicationRecord
  include CompetenceRansacker

  has_many :course_competences, dependent: :destroy
  has_many :courses, through: :course_competences

  validates :title, presence: true
end
