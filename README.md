## Database Schema

This project utilizes a relational database schema with the following entities (tables):

* **Users:**
    * `id` (integer, primary key)
    * `name` (string)
    * `email` (string, unique)
    * `password_digest` (string)
    * `loyalty_tier` (integer)
    * `created_at` (datetime)
    * `updated_at` (datetime)
* **Points:**
    * `id` (integer, primary key)
    * `user_id` (integer, foreign key referencing Users.id)
    * `related_transaction_id` (integer, nullable)
    * `points` (decimal)
    * `reason` (string)
    * `is_deleted` (boolean, default: false)
    * `created_at` (datetime)
    * `updated_at` (datetime)
* **Transactions:**
    * `id` (integer, primary key)
    * `user_id` (integer, foreign key referencing Users.id)
    * `amount` (decimal)
    * `currency` (string)
    * `description` (string)
    * `created_at` (datetime)
    * `updated_at` (datetime)
* **Rewards:**
    * `id` (integer, primary key)
    * `name` (string)
    * `description` (text)
    * `points_required` (integer)
    * `created_at` (datetime)
    * `updated_at` (datetime)

**Relationships:**

* Users have a one-to-many relationship with Points and Transactions (a user can have many points and transactions).
* Points optionally have a one-to-one relationship with Transactions (a point can be associated with a transaction).

1. Create User
Create a new user in the system.

URL: /users
Method: POST
Request Body:
json
Copy code
{
    "user": {
        "name": "User",
        "email": "user@example.com",
        "password": "password123"
    }
}
Response:
json
Copy code
{
    "id": 1,
    "name": "User",
    "email": "user@example.com",
    "created_at": "2024-04-07T07:14:41.328Z",
    "updated_at": "2024-04-07T07:14:41.328Z",
    "url": "http://localhost:3000/users/1.json"
}
2. Login
Authenticate user login.

URL: /login
Method: POST
Request Body:
json
Copy code
{
    "email": "user@example.com",
    "password": "password123"
}
Response:
json
Copy code
{
    "token": "<JWT token>"
}
Replace <JWT token> with the actual JWT token received.

3. Create Transaction
Create a new transaction.

URL: /transactions
Method: POST
Request Body:
json
Copy code
{
    "transaction": {
        "amount": 800.00
    },
    "foreign_transaction": false
}
Response:
json
Copy code
{
    "id": 8,
    "user_id": 1,
    "amount": "800.0",
    "created_at": "2024-04-07T07:43:39.608Z",
    "updated_at": "2024-04-07T07:43:39.608Z",
    "url": "http://localhost:3000/transactions/8.json"
}
4. Get Points
Retrieve all points for a user.

URL: /points

Method: GET

Response:

json
Copy code
[
    {
        "id": 1,
        "user_id": 1,
        "points": "10.0",
        "created_at": "2024-04-07T07:17:13.205Z",
        "updated_at": "2024-04-07T07:17:13.205Z"
    },
    {
        "id": 2,
        "user_id": 1,
        "points": "10.0",
        "created_at": "2024-04-07T07:17:43.109Z",
        "updated_at": "2024-04-07T07:17:43.109Z"
    }
]
5. Get Points by ID
Retrieve points by ID.

URL: /points/:id

Method: GET

Response:

json
Copy code
{
    "id": 1,
    "user_id": 1,
    "points": "10.0",
    "created_at": "2024-04-07T07:17:13.205Z",
    "updated_at": "2024-04-07T07:17:13.205Z"
}
6. Create Reward
Create a new reward.

URL: /rewards
Method: POST
Request Body:
json
Copy code
{
    "reward": {
        "name": "value1",
        "points_required": 2000
    }
}
Response:
json
Copy code
{
    "id": 3,
    "name": "value1",
    "points_required": 2000,
    "created_at": "2024-04-07T07:45:06.048Z",
    "updated_at": "2024-04-07T07:45:06.048Z"
}
7. Get Rewards
Retrieve all rewards.

URL: /rewards

Method: GET

Response:

json
Copy code
[
    {
        "id": 1,
        "name": "value1",
        "points_required": 200,
        "created_at": "2024-04-07T07:20:32.518Z",
        "updated_at": "2024-04-07T07:20:32.518Z",
        "eligible": 1
    },
    {
        "id": 2,
        "name": "value1",
        "points_required": 2000,
        "created_at": "2024-04-07T07:45:02.100Z",
        "updated_at": "2024-04-07T07:45:02.100Z",
        "eligible": 0
    },
    {
        "id": 3,
        "name": "value1",
        "points_required": 2000,
        "created_at": "2024-04-07T07:45:06.048Z",
        "updated_at": "2024-04-07T07:45:06.048Z",
        "eligible": 0
    }
]
