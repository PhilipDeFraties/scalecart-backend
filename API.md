# ScaleCart API Documentation

This file contains documentation for all API endpoints in the ScaleCart application. Each section describes the available endpoints, request formats, and expected responses.

---

## Endpoints Overview

- [Products](#products)

---

## Products

### 1. Get All Products

**GET** `/products`

- **Description**: Retrieves a list of all products.
- **Response**:
  ```json
  {
    "success": true,
    "data": [
      {
        "id": 1,
        "name": "Product 1",
        "description": "Description",
        "price": 9.99,
        "stock_quantity": 100
      },
      {
        "id": 2,
        "name": "Product 2",
        "description": "Description",
        "price": 19.99,
        "stock_quantity": 50
      }
    ]
  }
  ```

---

### 2. Get a Single Product

**GET** `/products/:id`

- **Description**: Retrieves details for a specific product by ID.
- **Response (Success)**:

  ```json
  {
    "success": true,
    "data": {
      "id": 1,
      "name": "Product 1",
      "description": "Description",
      "price": 9.99,
      "stock_quantity": 100
    }
  }
  ```

- **Response (Error)**:
  ```json
  {
    "success": false,
    "error": "Couldn't find Product"
  }
  ```

---

### 3. Create a New Product

**POST** `/products`

- **Description**: Creates a new product.
- **Request Body**:

  ```json
  {
    "product": {
      "name": "New Product",
      "description": "Amazing Product",
      "price": 19.99,
      "stock_quantity": 10
    }
  }
  ```

- **Response**:
  ```json
  {
    "success": true,
    "data": {
      "id": 6,
      "name": "New Product",
      "description": "Amazing Product",
      "price": 19.99,
      "stock_quantity": 10
    }
  }
  ```

---

### 4. Update a Product

**PUT** `/products/:id`

- **Description**: Updates an existing product by ID.
- **Request Body**:

  ```json
  {
    "product": {
      "name": "Updated Product"
    }
  }
  ```

- **Response**:

  ```json
  {
    "success": true,
    "data": {
      "id": 1,
      "name": "Updated Product",
      "description": "Description",
      "price": 9.99,
      "stock_quantity": 100
    }
  }
  ```

- **Response (Error)**:
  ```json
  {
    "success": false,
    "error": "Couldn't find Product"
  }
  ```

---

### 5. Delete a Product

**DELETE** `/products/:id`

- **Description**: Deletes an existing product by ID.
- **Response**:

  ```json
  {
    "success": true,
    "data": null
  }
  ```

- **Response (Error)**:
  ```json
  {
    "success": false,
    "error": "Couldn't find Product"
  }
  ```
