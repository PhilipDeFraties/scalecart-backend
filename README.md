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

## Categories API

### Endpoints

#### 1. Get All Categories

- **URL**: `GET /categories`
- **Description**: Retrieves all categories in the database.
- **Request Example**: `curl -X GET http://localhost:3000/categories`
- **Response Example**: 
```
[{"id": 1, "name": "Electronics", "description": "Devices and gadgets", "parent_id": null, "created_at": "2024-12-01T12:34:56Z", "updated_at": "2024-12-01T12:34:56Z"}, {"id": 2, "name": "Smartphones", "description": "Mobile phones", "parent_id": 1, "created_at": "2024-12-01T12:34:56Z", "updated_at": "2024-12-01T12:34:56Z"}]
```

#### 2. Get a Single Category

- **URL**: `GET /categories/:id`
- **Description**: Retrieves a specific category by its ID, including subcategories.
- **Request Example**: `curl -X GET http://localhost:3000/categories/1`
- **Response Example**: 
```
{"id": 1, "name": "Electronics", "description": "Devices and gadgets", "parent_id": null, "created_at": "2024-12-01T12:34:56Z", "updated_at": "2024-12-01T12:34:56Z", "subcategories": [{"id": 2, "name": "Smartphones", "description": "Mobile phones", "parent_id": 1, "created_at": "2024-12-01T12:34:56Z", "updated_at": "2024-12-01T12:34:56Z"}]}
```

#### 3. Create a Category

- **URL**: `POST /categories`
- **Description**: Creates a new category.
- **Request Example**: 
```
curl -X POST http://localhost:3000/categories -H "Content-Type: application/json" -d '{"category": {"name": "New Category", "description": "Category Description", "parent_id": 1}}'
```
- **Response Example**: 
```
{"id": 3, "name": "New Category", "description": "Category Description", "parent_id": 1, "created_at": "2024-12-01T12:34:56Z", "updated_at": "2024-12-01T12:34:56Z"}
```

#### 4. Update a Category

- **URL**: `PUT /categories/:id`
- **Description**: Updates an existing category by its ID.
- **Request Example**: 
```
curl -X PUT http://localhost:3000/categories/1 -H "Content-Type: application/json" -d '{"category": {"name": "Updated Category Name"}}'
```
- **Response Example**: 
```
{"id": 1, "name": "Updated Category Name", "description": "Devices and gadgets", "parent_id": null, "created_at": "2024-12-01T12:34:56Z", "updated_at": "2024-12-02T08:00:00Z"}
```

#### 5. Delete a Category

- **URL**: `DELETE /categories/:id`
- **Description**: Deletes a category by its ID.
- **Request Example**: `curl -X DELETE http://localhost:3000/categories/1`
- **Response Example**: `{"message": "Category successfully deleted."}`

## Authentication API

### Endpoints

#### 1. Login

- **URL**: `POST /login`
- **Description**: Authenticates a user and establishes a session.
- **Request Example**:
```
curl -X POST http://localhost:3000/login -H "Content-Type: application/json" -d '{
 "email": "user@example.com",
 "password": "password123"
}'
```
-**Response Example**: `{"message": "Logged in successfully"}`

#### 2. Logout

- **URL**: `DELETE /logout`
- **Description**: Logs out the authenticated user and destroys the session.
- **Request Example**: `curl -X DELETE http://localhost:3000/logout -b cookies.txt`
- **Response Example**: `{"message": "Logged out successfully"}`


## Deployment Instructions

1. Ensure the database is migrated and seeded in the production environment.
2. Deploy the application using your chosen hosting provider, ensuring all environment variables are set.
