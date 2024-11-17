module CompetenceRansacker
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_attributes(auth_object = nil)
      [ 'id', 'title' ]
    end

    def ransackable_associations(auth_object = nil)
      [ 'courses' ]
    end
  end
end
