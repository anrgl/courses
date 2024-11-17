FactoryBot.define do
  factory :course, class: 'Course' do
    title { Faker::Book.title }
    author
  end
end
