# ecommerce-db-sql

### 📋 `users` Table

Stores basic user information including credentials, role, and status.

| Column Name | Data Type      | Description                       |
|-------------|----------------|-----------------------------------|
| `id`        | INT (PK, AI)   | Primary key, auto-incremented     |
| `name`      | VARCHAR(255)   | Full name of the user             |
| `email`     | VARCHAR(255)   | Unique email address              |
| `password`  | VARCHAR(255)   | Hashed password                   |
| `role`      | ENUM           | Role of the user: `user` or `admin` (default `user`) |
| `status`    | TINYINT(1)     | Account status: 1 = active, 0 = inactive |
| `created_at`| TIMESTAMP      | Timestamp when user was created   |
| `updated_at`| TIMESTAMP      | Timestamp of last update          |

