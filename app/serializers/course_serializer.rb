class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :author_id
end
