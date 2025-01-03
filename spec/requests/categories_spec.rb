require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  let!(:categories) { create_list(:category, 5) }
  let(:category_id) { categories.first.id }

  describe "GET /categories" do
    it "returns all categories" do
      get '/categories'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe "GET /categories/:id" do
    context "when the category exists" do
      it "returns the category" do
        get "/categories/#{category_id}"

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['id']).to eq(category_id)
        expect(body['name']).to eq(categories.first.name)
      end
    end

    context "when the category does not exist" do
      it "returns a 404 not found" do
        get "/categories/99999"

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['error']).to eq("Couldn't find Category with 'id'=99999")
      end
    end
  end

  describe "POST /categories" do
    let(:valid_attributes) { { name: "New Category", description: "A new category" } }
    let(:invalid_attributes) { { name: "" } }

    context "with valid attributes" do
      it "creates a new category" do
        expect {
          post '/categories', params: { category: valid_attributes }
        }.to change(Category, :count).by(1)

        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)
        expect(body['name']).to eq("New Category")
      end
    end

    context "with invalid attributes" do
      it "returns a 422 unprocessable entity" do
        post '/categories', params: { category: invalid_attributes }

        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body['errors']).to include("Name can't be blank")
      end
    end
  end

  describe "PUT /categories/:id" do
    let(:valid_attributes) { { name: "Updated Category" } }
    let(:invalid_attributes) { { name: "" } }

    context "when the category exists" do
      it "updates the category" do
        put "/categories/#{category_id}", params: { category: valid_attributes }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['name']).to eq("Updated Category")
        expect(Category.find(category_id).name).to eq("Updated Category")
      end
    end

    context "when the category does not exist" do
      it "returns a 404 not found" do
        put "/categories/99999", params: { category: valid_attributes }

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['error']).to eq("Couldn't find Category with 'id'=99999")
      end
    end

    context "with invalid attributes" do
      it "returns a 422 unprocessable entity" do
        put "/categories/#{category_id}", params: { category: invalid_attributes }

        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body['errors']).to include("Name can't be blank")
      end
    end
  end

  describe "DELETE /categories/:id" do
    context "when the category exists" do
      it "deletes the category" do
        expect {
          delete "/categories/#{category_id}"
        }.to change(Category, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the category does not exist" do
      it "returns a 404 not found" do
        delete "/categories/99999"

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['error']).to eq("Couldn't find Category with 'id'=99999")
      end
    end
  end
end
