# ecommerce-db-sql


## 📚 Tables

- [`users`](#-users-table)
- [`addresses`](#-addresses-table)
- [`categories`](#-categories-table)
- [`products`](#-products-table)
- [`carts`](#-carts-table)
- [`cart_items`](#-cart_items-table)
- [`orders`](#-orders-table)
- [`order_items`](#-order_items-table)
- [`payments`](#-payments-table)
- [`reviews`](#-reviews-table)




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


### 📋 `addresses` Table

Stores billing or shipping addresses associated with a user.

| Column Name     | Data Type      | Description                                           |
|------------------|----------------|-------------------------------------------------------|
| `id`             | INT (PK, AI)   | Primary key, auto-incremented                         |
| `user_id`        | INT            | Foreign key referencing `users(id)`                  |
| `type`           | ENUM           | Address type: `billing` or `shipping` (default `shipping`) |
| `full_name`      | VARCHAR(255)   | Full name for the address                            |
| `phone`          | VARCHAR(50)    | Phone number                                         |
| `address_line1`  | VARCHAR(255)   | Main address line                                    |
| `address_line2`  | VARCHAR(255)   | Additional address details (optional)                |
| `city`           | VARCHAR(100)   | City                                                 |
| `state`          | VARCHAR(100)   | State/Province                                       |
| `postal_code`    | VARCHAR(20)    | Postal or ZIP code                                   |
| `country`        | VARCHAR(100)   | Country                                              |
| `created_at`     | TIMESTAMP      | Timestamp when the address was created               |
| `updated_at`     | TIMESTAMP      | Timestamp of the last update                         |

🔗 **Foreign Key**: `user_id` → `users(id)` (on delete: cascade)  
📌 **Indexes**: `user_id`, `type`


### 📋 `categories` Table

Stores product categories.

| Column Name   | Data Type     | Description                                 |
|---------------|---------------|---------------------------------------------|
| `id`          | INT (PK, AI)  | Primary key, auto-incremented               |
| `name`        | VARCHAR(255)  | Category name (required)                    |
| `slug`        | VARCHAR(255)  | URL-friendly unique identifier              |
| `status`      | TINYINT(1)    | Status (1 = active, 0 = inactive), default 1 |
| `created_at`  | TIMESTAMP     | Timestamp when category was created         |
| `updated_at`  | TIMESTAMP     | Timestamp when category was last updated    |

📌 **Indexes**: `status`


---

### 📋 `products` Table

Stores product information.

| Column Name   | Data Type       | Description                                        |
|---------------|------------------|----------------------------------------------------|
| `id`          | INT (PK, AI)     | Primary key, auto-incremented                      |
| `name`        | VARCHAR(255)     | Product name (required)                            |
| `slug`        | VARCHAR(255)     | Unique slug for URL and identification             |
| `category_id` | INT              | Foreign key referencing `categories(id)`           |
| `stock`       | INT              | Available stock (default 0)                        |
| `price`       | DECIMAL(28,8)    | Product price (default 0)                          |
| `status`      | TINYINT          | Status (1 = active, 0 = inactive), default 1       |
| `created_at`  | TIMESTAMP        | Timestamp when product was created                 |
| `updated_at`  | TIMESTAMP        | Timestamp when product was last updated            |

🔗 **Foreign Key**: `category_id` → `categories(id)` (on delete: cascade)  
📌 **Indexes**: `status`, `category_id`


---

### 🛒 `carts` Table

Stores cart information for each user (1:1 relationship).

| Column Name   | Data Type     | Description                                      |
|---------------|---------------|--------------------------------------------------|
| `id`          | INT (PK, AI)  | Primary key, auto-incremented                   |
| `user_id`     | INT           | Foreign key referencing `users(id)`             |
| `created_at`  | TIMESTAMP     | Timestamp when cart was created                 |
| `updated_at`  | TIMESTAMP     | Timestamp when cart was last updated            |

🔗 **Foreign Key**: `user_id` → `users(id)` (on delete: cascade)  
🔐 **Unique**: One cart per user (`UNIQUE(user_id)`)


---

### 🧾 `cart_items` Table

Stores items added to a user's cart.

| Column Name   | Data Type       | Description                                         |
|---------------|------------------|-----------------------------------------------------|
| `cart_id`     | INT              | Foreign key referencing `carts(id)`                |
| `product_id`  | INT              | Foreign key referencing `products(id)`             |
| `qty`         | INT              | Quantity of the product in the cart (default 1)    |
| `created_at`  | TIMESTAMP        | Timestamp when item was added                      |
| `updated_at`  | TIMESTAMP        | Timestamp when item was last updated               |

🔗 **Foreign Keys**:  
- `cart_id` → `carts(id)` (on delete: cascade)  
- `product_id` → `products(id)` (on delete: cascade)

🔐 **Primary Key**: (`cart_id`, `product_id`)  
📌 **Indexes**: `product_id`

---

### 📦 `orders` Table

Stores order information for each purchase.

| Column Name     | Data Type                   | Description                                        |
|------------------|-----------------------------|----------------------------------------------------|
| `id`            | INT (PK, AI)                | Primary key, auto-incremented                     |
| `order_number`  | VARCHAR(255) (UNIQUE)       | Unique order number                               |
| `user_id`       | INT                         | Foreign key referencing `users(id)`               |
| `total_amount`  | DECIMAL(28,8)               | Total amount for the order                        |
| `status`        | ENUM                        | Status of the order (`pending`, `paid`, `shipped`, `cancelled`) |
| `created_at`    | TIMESTAMP                   | When the order was created                        |
| `updated_at`    | TIMESTAMP                   | When the order was last updated                   |

🔗 **Foreign Key**: `user_id` → `users(id)` (on delete: cascade)  
📌 **Indexes**: `user_id`, `order_number`

---

### 📦 `order_items` Table

Stores items that belong to a specific order.

| Column Name   | Data Type        | Description                                       |
|----------------|------------------|---------------------------------------------------|
| `id`          | INT (PK, AI)     | Primary key, auto-incremented                    |
| `order_id`    | INT              | Foreign key referencing `orders(id)`             |
| `product_id`  | INT              | Foreign key referencing `products(id)`           |
| `qty`         | INT              | Quantity ordered                                 |
| `price`       | DECIMAL(28,8)    | Price per unit at time of order                  |
| `created_at`  | TIMESTAMP        | When the item was added to the order             |
| `updated_at`  | TIMESTAMP        | When the item was last updated                   |

🔗 **Foreign Keys**:  
- `order_id` → `orders(id)` (on delete: cascade)  
- `product_id` → `products(id)` (on delete: cascade)

📌 **Indexes**: `order_id`, `product_id`

---

### 💳 `payments` Table

Stores payment information for each order.

| Column Name   | Data Type              | Description                                      |
|----------------|------------------------|--------------------------------------------------|
| `id`          | INT (PK, AI)           | Primary key, auto-incremented                   |
| `order_id`    | INT                    | Foreign key referencing `orders(id)`            |
| `amount`      | DECIMAL(28,8)          | Amount paid                                     |
| `method`      | ENUM                   | Payment method (`card`, `paypal`, `bank_transfer`) |
| `status`      | ENUM                   | Payment status (`pending`, `completed`, `failed`) |
| `paid_at`     | TIMESTAMP (nullable)   | When the payment was made (nullable)            |

🔗 **Foreign Key**: `order_id` → `orders(id)`  
📌 **Indexes**: `order_id`, `status`, `method`


---

### 📝 `reviews` Table

Stores user-generated product reviews.

| Column Name   | Data Type        | Description                                           |
|----------------|------------------|-------------------------------------------------------|
| `id`          | INT (PK, AI)     | Primary key, auto-incremented                        |
| `user_id`     | INT              | Foreign key referencing `users(id)`                  |
| `product_id`  | INT              | Foreign key referencing `products(id)`               |
| `rating`      | TINYINT          | Rating value (1 to 5); must satisfy the check        |
| `comment`     | TEXT             | Optional review comment                              |
| `created_at`  | TIMESTAMP        | When the review was created                          |
| `updated_at`  | TIMESTAMP        | When the review was last updated                     |

🔗 **Foreign Keys**:  
- `user_id` → `users(id)` (on delete: cascade)  
- `product_id` → `products(id)` (on delete: cascade)

📌 **Indexes**: `user_id`, `product_id`








