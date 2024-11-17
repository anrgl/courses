# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
author1 = Author.create(name: 'Ruby author')
author2 = Author.create(name: 'PHP author')
author3 = Author.create(name: 'Java author')

competence1 = Competence.create(title: 'dev')
competence2 = Competence.create(title: 'ruby')
competence3 = Competence.create(title: 'ruby on rals')
competence4 = Competence.create(title: 'php')
competence5 = Competence.create(title: 'laravel')
competence6 = Competence.create(title: 'java')
competence7 = Competence.create(title: 'spring')

Course.create(title: 'Learn Ruby', author: author1, competences: [ competence1, competence2 ])
Course.create(title: 'Learn RoR', author: author1, competences: [ competence1, competence3 ])
Course.create(title: 'Learn PHP', author: author2, competences: [ competence1, competence4 ])
Course.create(title: 'Learn Laravel', author: author2, competences: [ competence1, competence5 ])
Course.create(title: 'Learn Java', author: author3, competences: [ competence1, competence6 ])
Course.create(title: 'Learn Spring', author: author3, competences: [ competence1, competence7 ])
