require 'rails_helper'

RSpec.describe "Products API", type: :request do
  let!(:products) { create_list(:product, 5) }
  let(:product_id) { products.first.id }

  describe "GET /products" do
    it "returns all products" do
      get '/products'

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['success']).to be(true)
      expect(body['data'].size).to eq(5)
    end
  end

  describe "GET /products/:id" do
    context "when the product exists" do
      it "returns the product" do
        get "/products/#{product_id}"

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['success']).to be(true)
        expect(body['data']['id']).to eq(product_id)
        expect(body['data']['name']).to eq(products.first.name)
      end
    end

    context "when the product does not exist" do
      it "returns a 404 not found" do
        get "/products/99999"

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['success']).to be(false)
        expect(body['error']).to eq("Couldn't find Product")
      end
    end
  end

  describe "POST /products" do
    let(:valid_attributes) { { name: "New Product", description: "Amazing Product", price: 19.99, stock_quantity: 10 } }
    let(:invalid_attributes) { { name: "", price: -10 } }

    context "with valid attributes" do
      it "creates a new product" do
        expect do
          post '/products', params: { product: valid_attributes }
        end.to change(Product, :count).by(1)

        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)
        expect(body['success']).to be(true)
        expect(body['data']['name']).to eq("New Product")
      end
    end

    context "with invalid attributes" do
      it "returns a 422 unprocessable entity" do
        post '/products', params: { product: invalid_attributes }

        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body['success']).to be(false)
        expect(body['error']).to include("Name can't be blank", "Price must be greater than or equal to 0")
      end
    end
  end

  describe "PUT /products/:id" do
    let(:valid_attributes) { { name: "Updated Product" } }
    let(:invalid_attributes) { { name: "" } }

    context "when the product exists" do
      it "updates the product" do
        put "/products/#{product_id}", params: { product: valid_attributes }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['success']).to be(true)
        expect(body['data']['name']).to eq("Updated Product")
        expect(Product.find(product_id).name).to eq("Updated Product")
      end
    end

    context "when the product does not exist" do
      it "returns a 404 not found" do
        put "/products/99999", params: { product: valid_attributes }

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['success']).to be(false)
        expect(body['error']).to eq("Couldn't find Product")
      end
    end

    context "with invalid attributes" do
      it "returns a 422 unprocessable entity" do
        put "/products/#{product_id}", params: { product: invalid_attributes }

        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body['success']).to be(false)
        expect(body['error']).to include("Name can't be blank")
      end
    end
  end

  describe "DELETE /products/:id" do
    context "when the product exists" do
      it "deletes the product" do
        expect do
          delete "/products/#{product_id}"
        end.to change(Product, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the product does not exist" do
      it "returns a 404 not found" do
        delete "/products/99999"

        expect(response).to have_http_status(:not_found)
        body = JSON.parse(response.body)
        expect(body['success']).to be(false)
        expect(body['error']).to eq("Couldn't find Product")
      end
    end
  end
end
