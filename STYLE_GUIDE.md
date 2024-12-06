# ScaleCart Style Guide

This document defines the coding standards and conventions for the ScaleCart backend project. Following these guidelines ensures consistency, maintainability, and readability across the codebase.

## Language and Framework Conventions

- **Ruby**: Follow the [Ruby Style Guide](https://rubystyle.guide).
- **Rails**: Follow the [Rails Style Guide](https://rails.rubystyle.guide).
- Use **RuboCop** to enforce coding standards:
  ```bash
  bundle exec rubocop
  ```
- Ensure all code is clean and passes RuboCop checks before submitting a pull request.

## Naming Conventions

- **Models**: Singular and CamelCase (e.g., `Product`).
- **Controllers**: Plural and CamelCase (e.g., `ProductsController`).
- **Database Tables**: Plural and snake_case (e.g., `products`).
- **Files**: snake_case for all Ruby files (e.g., `products_controller.rb`).
- **Variables and Methods**:
  - Use `snake_case` for variables and method names.
  - Use `CamelCase` for classes and modules.
  - Make variable names descriptively accurate to what they represent. (e.g. `total_cost_after_tax`)

## Testing Practices

- Use **RSpec** for all tests.
- Use `FactoryBot` for test data. Include factories for all models.
  ```ruby
  let(:product) { create(:product) }
  ```
- Prefer `is_expected.to` for one-liner specs.
  ```ruby
  it { is_expected.to validate_presence_of(:name) }
  ```
- Structure tests into:
  - **Unit Tests**: Test individual models and services.
  - **Integration Tests**: Test multiple layers (e.g., API endpoints).

## Commit and Branch Naming

- **Commit Messages**:

  ```
  <type>(<scope>): <subject>

  Example:
  feature(products): add CRUD endpoints for products
  ```

  - Use one of the following types:
    - `feature`: New feature.
    - `bugfix`: Fix for a bug.
    - `chore`: Maintenance tasks or refactoring.
    - `docs`: Updates to documentation.

- **Branch Names**:
  - Use descriptive branch names following this pattern:
    - `feature/add-products-endpoints`
    - `bugfix/fix-products-validation`

## Documentation Standards

- All new features must be documented in `API.md` (for API details) or other relevant documentation files.
- Write clear and concise comments for methods, especially for complex logic.

## Linting Tools

- **RuboCop**: Enforces Ruby and Rails style guidelines.
  ```bash
  bundle exec rubocop
  ```
- Run auto-corrections where applicable:
  ```bash
  bundle exec rubocop -A
  ```

## Code Review Standards

- All pull requests must:
  - Pass CI checks, including RuboCop and RSpec tests.
  - Follow the conventions outlined in this guide.
  - Include meaningful commit messages and well-structured code.
  - Contain updates to documentation when applicable.
- Pull requests should focus on a single feature or change to make reviews efficient.

## Additional Guidelines

- **Database Changes**:

  - Always add indexes for columns used in uniqueness validations or frequent queries.
  - Avoid destructive migrations unless absolutely necessary.

- **Scalability**:
  - Plan for scaling (e.g., avoid N+1 queries, optimize queries with `.includes`, paginate results).
  - Use caching where appropriate to reduce load.

## Updating the Style Guide

This document is a living guide. Updates and changes should be proposed via pull requests and discussed with the team.
