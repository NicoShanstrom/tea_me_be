# README

## Project Setup

### Ruby version
- **Ruby**: 3.2.2

### Rails version
- **Rails**: 7.1.3.4

### Installation
1. Clone the repo to your machine:
    ```sh
    git clone <github_repo_url>
    cd <repo_directory>
    ```
2. Install dependencies:
    ```sh
    bundle install
    ```
3. Set up the database:
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```
4. Run the tests:
    ```sh
    bundle exec rspec
    ```
5. Start the server:
    ```sh
    rails server
    ```

## Endpoints

### Create a Subscription
- **Endpoint**: `POST /api/v1/subscriptions`
- **Example URL**: `http://localhost:3000/api/v1/subscriptions`
- **Request Body**:
    ```json
    {
      "subscription": {
        "title": "Monthly Tea",
        "price": 10.0,
        "status": 0,
        "frequency": 1,
        "customer_id": 1,
        "tea_id": 1
      }
    }
    ```

### Cancel a Subscription
- **Endpoint**: `DELETE /api/v1/subscriptions/:id`
- **Example URL**: `http://localhost:3000/api/v1/subscriptions/1`

### Show a Subscription
- **Endpoint**: `GET /api/v1/subscriptions/:id`
- **Example URL**: `http://localhost:3000/api/v1/subscriptions/1`

### List All Subscriptions for a Customer
- **Endpoint**: `GET /api/v1/customers/:customer_id/subscriptions`
- **Example URL**: `http://localhost:3000/api/v1/customers/1/subscriptions`

## Future Addition Ideas
- Consume this API for tea product information: **Spoontacular API**
- Create `CustomersController` and `TeasController` with CRUD actions
- Create user or admin for accessibility by a user or admin
- Create API keys for a user or admin of this API when a user or admin is created

## Refactor Ideas
- Refactor rescue blocks in controllers
- Refactor error messages into error serializer
