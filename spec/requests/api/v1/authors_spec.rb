require 'swagger_helper'

RSpec.describe('api/v1/authors', type: :request) do
  path '/api/v1/authors' do
    get 'Retrieves all authors' do
      tags 'Authors'
      produces 'application/json'

      response '200', 'authors found' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/Author' }

        before do
          create_list(:author, 5)
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.count).to eq(5)
        end
      end
    end

    post 'Creates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'author created' do
        let(:name) { Faker::Name.name }
        let(:author) { { name: name } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(name)
        end
      end

      response '422', 'invalid request' do
        let(:author) { { name: '' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to include('name')
        end
      end
    end
  end

  path '/api/v1/authors/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Retrieves an author' do
      tags 'Authors'
      produces 'application/json'

      response '200', 'author found' do
        schema '$ref' => '#/components/schemas/Author'

        let(:id) { create(:author).id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(id)
        end
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response.status).to eq(404)
        end
      end
    end

    put 'Updates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [ 'name' ]
      }

      response '200', 'author updated' do
        let(:id) { create(:author).id }
        let(:name) { Faker::Name.name }
        let(:author) { { name: name } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(name)
        end
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        let(:author) { { name: Faker::Name.name } }
        run_test! do |response|
          expect(response.status).to eq(404)
        end
      end
    end

    delete 'Deletes an author' do
      tags 'Authors'

      response '204', 'author deleted' do
        let(:id) { create(:author).id }
        run_test! do |response|
          expect(response.status).to eq(204)
          expect(response.body).to be_empty
        end
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        run_test! do |response|
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
