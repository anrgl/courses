class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :author_id

  has_many :competences, serializer: CompetenceSerializer
end
