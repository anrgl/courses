class Author < ApplicationRecord
  include AuthorRansacker

  has_many :courses

  validates :name, presence: true

  before_destroy :reassign_courses

  private

  def reassign_courses
    new_author = Author.where.not(id: self.id).order('RANDOM()').first
    if new_author
      courses.update_all(author_id: new_author.id)
    else
      errors.add(:base, 'Cannot delete the last author as there is no other author to assign courses to.')
      throw(:abort)
    end
  end
end
