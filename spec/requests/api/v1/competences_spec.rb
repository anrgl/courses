require 'swagger_helper'

RSpec.describe('api/v1/competences', type: :request) do
  path '/api/v1/competences' do
    get 'Retrieves all competences' do
      tags 'Competences'
      produces 'application/json'

      response '200', 'competences found' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/Competence' }

        before do
          create_list(:competence, 5)
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.count).to eq(5)
        end
      end
    end

    post 'Creates an competence' do
      tags 'Competences'
      consumes 'application/json'
      parameter name: :competence, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
        },
        required: [ 'title' ]
      }

      response '201', 'competence created' do
        let(:title) { Faker::Name.name }
        let(:competence) { { title: title } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['title']).to eq(title)
        end
      end

      response '422', 'invalid request' do
        let(:competence) { { title: '' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to include('title')
        end
      end
    end
  end

  path '/api/v1/competences/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves an competence' do
      tags 'Competences'
      produces 'application/json'

      response '200', 'competence found' do
        schema '$ref' => '#/components/schemas/Competence'

        let(:id) { create(:competence).id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
        end
      end

      response '404', 'competence not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response.status).to eq(404)
        end
      end
    end

    put 'Updates an competence' do
      tags 'Competences'
      consumes 'application/json'
      parameter name: :competence, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
        },
        required: [ 'title' ]
      }

      response '200', 'competence updated' do
        let(:id) { create(:competence).id }
        let(:title) { Faker::Name.name }
        let(:competence) { { title: title } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['title']).to eq(title)
        end
      end

      response '404', 'competence not found' do
        let(:id) { 'invalid' }
        let(:competence) { { title: Faker::Name.name } }
        run_test! do |response|
          expect(response.status).to eq(404)
        end
      end
    end

    delete 'Deletes an competence' do
      tags 'Competences'

      response '204', 'competence deleted' do
        let(:id) { create(:competence).id }
        run_test! do |response|
          expect(response.status).to eq(204)
          expect(response.body).to be_empty
        end
      end

      response '404', 'competence not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
