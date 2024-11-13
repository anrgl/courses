class Author < ApplicationRecord
  has_many :courses

  validate :name, presence: true
end
