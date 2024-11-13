class Competence < ApplicationRecord
  has_many :course_competences
  has_many :courses, through: :course_competences

  validate :title, presence: true
end
