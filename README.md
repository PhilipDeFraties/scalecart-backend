# ScaleCart Backend

ScaleCart is a scalable e-commerce backend built with Ruby on Rails. This application includes features like product management via a RESTful API, detailed documentation, and robust testing.

## Ruby Version

Ruby 3.2.5

## System Dependencies

- Rails 7.x
- PostgreSQL
- Bundler

## Configuration

1. Clone the repository:

   ```bash
   git clone https://github.com/PhilipDeFraties/scalecart-backend.git
   cd scalecart-backend
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Set up environment variables as needed for database and other services.

## Database Creation

1. Create and migrate the database:
   ```bash
   rails db:create db:migrate
   ```

## Database Initialization

1. Seed the database with sample data for development:
   ```bash
   rails db:seed
   ```

## How to Run the Test Suite

1. Run the test suite using RSpec:

   ```bash
   bundle exec rspec
   ```

2. Run tests for specific components:
   - **Model Tests**: `spec/models`
   - **Request Tests**: `spec/requests`

Example:

```bash
bundle exec rspec spec/requests/products_spec.rb
```

## Products API

### Endpoints

#### 1. Get All Products

- **URL**: `GET /products`
- **Description**: Retrieves all products in the database.

#### 2. Get a Single Product

- **URL**: `GET /products/:id`
- **Description**: Retrieves a specific product by its ID.

#### 3. Create a Product

- **URL**: `POST /products`
- **Description**: Creates a new product.

#### 4. Update a Product

- **URL**: `PUT /products/:id`
- **Description**: Updates an existing product by its ID.

#### 5. Delete a Product

- **URL**: `DELETE /products/:id`
- **Description**: Deletes a product by its ID.

## Deployment Instructions

1. Ensure the database is migrated and seeded in the production environment.
2. Deploy the application using your chosen hosting provider, ensuring all environment variables are set.
