require 'swagger_helper'

RSpec.describe('api/v1/courses', type: :request) do
  path '/api/v1/courses' do
    get 'Retrieves all courses' do
      tags 'Courses'
      produces 'application/json'

      response '200', 'courses found' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/Course' }

        before do
          create_list(:course, 5)
        end

        run_test!
      end
    end

    post 'Creates an course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          course: {
            type: :object,
            properties: {
              title: { type: :string },
              author_id: { type: :integer },
              competences: {
                type: :array,
                items: { type: :string }
              }
            },
            required: [ 'title', 'author_id' ]
          },
        },
        required: [ 'course' ]
      }

      response '201', 'course created' do
        let(:author) { create(:author) }
        let(:course) { { course: { title: Faker::Name.name, author_id: author.id, competences: [ 'competence1', 'competence2' ] } } }
        run_test!
      end

      response '422', 'invalid request' do
        let!(:course) { { course: { title: '', competences: [] } } }
        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves an course' do
      tags 'Courses'
      produces 'application/json'

      response '200', 'course found' do
        schema '$ref' => '#/components/schemas/Course'

        let(:id) { create(:course).id }
        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates an course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          author_id: { type: :integer }
        },
        required: [ 'title' ]
      }

      response '200', 'course updated' do
        let(:id) { create(:course).id }
        let(:course) { { title: Faker::Name.name } }
        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'invalid' }
        let(:course) { { title: Faker::Name.name } }
        run_test!
      end
    end

    delete 'Deletes an course' do
      tags 'Courses'

      response '204', 'course deleted' do
        let(:id) { create(:course).id }
        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
