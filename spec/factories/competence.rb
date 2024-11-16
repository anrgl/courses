FactoryBot.define do
  factory :competence, class: 'Competence' do
    title { Faker::Book.title }
  end
end
