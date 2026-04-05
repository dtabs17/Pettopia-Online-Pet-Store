# Pettopia Online Pet Store

Pettopia is a full-stack e-commerce web application for small domestic pets. It was built as a portfolio and academic project using a React frontend, a Spring Boot REST API, and a MariaDB database.

The application supports both customer-facing shopping workflows and an admin back office. Customers can register, log in, search products, manage a cart, place orders, save products to a wishlist, and track loyalty points. Admin users can log in separately and manage products, categories, and discount codes through protected routes.

## Overview

The project is split into two main parts:

- **Frontend:** a React single-page application using React Router, Axios, and Bootstrap
- **Backend:** a Spring Boot REST API with Spring Security and JWT-based authentication
- **Database:** MariaDB for product, customer, order, wishlist, discount, reward, and password reset data

Uploaded product images are stored locally and served through `/images/...` URLs.

## Core Features

### Customer Features
- Customer registration and login
- Product search by category, price range, and keyword
- Product detail pages with image gallery, reviews, category hierarchy, stock status, and active discounts
- Cart management with add, update, remove, and clear actions
- Order finalisation and order history
- Wishlist support for authenticated customers
- Loyalty points system with earn and redeem functionality
- Change password, forgot password, and reset password flows

### Admin Features
- Separate admin login flow
- Role-based admin access for `ADMIN` and `MANAGER`
- Product creation, update, view, archive, and delete actions
- Category retrieval for product management
- Discount code creation, update, toggle, and delete actions
- Thumbnail and gallery image upload support for products

### Security Features
- Stateless JWT authentication using Bearer tokens
- Spring Security route protection
- BCrypt password hashing
- Failed login tracking with temporary account lockout
- Single-use password reset tokens with expiry
- Backend stock validation during cart and checkout operations
- Archive logic that prevents unavailable products from being used in customer flows

## Tech Stack

### Frontend
- React
- React Router
- Axios
- Bootstrap

### Backend
- Spring Boot
- Spring Security
- Maven
- REST API architecture

### Database
- MariaDB

### Authentication and Security
- JWT
- BCrypt password hashing

### Tooling
- Git
- GitHub
- Postman

## Architecture Overview

Pettopia follows a split frontend/backend architecture:

- The **React frontend** handles product browsing, authentication screens, cart and wishlist pages, rewards, orders, and admin UI flows.
- The **Spring Boot backend** exposes REST endpoints for customers, products, cart, orders, wishlist, rewards, password reset, admin authentication, product management, and discount code management.
- The **MariaDB database** stores application data including customers, products, categories, orders, order items, reviews, wishlist entries, reward transactions, discount codes, and password reset tokens.

The frontend communicates with the backend through `/api` endpoints, and product images are served separately through `/images`.

## Main Functional Areas

### Product Catalogue
Customers can search products using optional filters for:
- category
- minimum price
- maximum price
- keyword

Product detail pages include:
- product name and description
- main thumbnail and gallery images
- price and discount price
- category hierarchy
- stock status
- active discounts
- reviews and average rating

### Cart and Checkout
Authenticated customers can:
- add products to cart
- update item quantities
- remove items
- clear the cart
- finalise the cart into an order

The backend validates stock before checkout and updates product stock after order completion.

### Orders
Authenticated customers can view their previous orders, including:
- order ID
- order date
- total
- payment method
- items in the order

### Wishlist
Authenticated customers can:
- add products to a wishlist
- remove products from a wishlist
- check whether a product is already saved
- view their wishlist page

### Rewards System
Pettopia includes a points-based loyalty system:
- customers earn **1 point per €50 spent**
- points can be redeemed at checkout
- reward history is stored and returned through the API

### Admin Back Office
Admin users can:
- log in through a separate admin flow
- manage products
- upload product images
- archive or restore products
- retrieve categories for product assignment
- manage discount codes

Products linked to historic orders are archived instead of being hard-deleted.

## API Overview

This is a high-level overview of the main backend routes.

### Public Routes
- `POST /api/customers/register`
- `POST /api/customers/login`
- `POST /api/customers/forgot-password`
- `POST /api/customers/reset-password`
- `POST /api/admin/login`
- `GET /api/products/search`
- `/images/**`

### Authenticated Customer Routes
- `POST /api/customers/logout`
- `POST /api/customers/change-password`
- `GET /api/customers/rewards`
- `POST /api/customers/rewards/redeem`

### Cart Routes
- `GET /api/cart`
- `POST /api/cart/add`
- `PUT /api/cart/update`
- `DELETE /api/cart/remove/{productId}`
- `DELETE /api/cart/clear`

### Order Routes
- `POST /api/orders/finalize`
- `GET /api/orders/my-orders`

### Wishlist Routes
- `GET /api/wishlist`
- `GET /api/wishlist/check`
- `POST /api/wishlist/add`
- `DELETE /api/wishlist/remove`

### Product Routes
- `GET /api/products/{id}`

### Admin Product Routes
- `GET /api/admin/products`
- `GET /api/admin/products/{id}`
- `POST /api/admin/products`
- `PUT /api/admin/products/{id}`
- `PATCH /api/admin/products/{id}/archive`
- `DELETE /api/admin/products/{id}`

### Admin Category Routes
- `GET /api/admin/categories`

### Admin Discount Code Routes
- `GET /api/admin/discount-codes`
- `GET /api/admin/discount-codes/{id}`
- `POST /api/admin/discount-codes`
- `PUT /api/admin/discount-codes/{id}`
- `PATCH /api/admin/discount-codes/{id}/toggle`
- `DELETE /api/admin/discount-codes/{id}`

## Frontend Routes

The React frontend includes routes for:
- `/`
- `/products`
- `/product/:id`
- `/register`
- `/login`
- `/cart`
- `/orders`
- `/wishlist`
- `/rewards`
- `/forgot-password`
- `/reset-password`
- `/admin/login`
- `/admin/products`
- `/admin/products/new`
- `/admin/products/:id/edit`

## Local Development Setup


### Prerequisites
Install the following before running the project:

- Java JDK
- Maven
- Node.js and npm
- MariaDB

## 1. Clone the repository

```bash
git clone https://github.com/dtabs17/Pettopia-Online-Pet-Store.git
cd Pettopia-Online-Pet-Store
```

## 2. Create the database

Create a MariaDB database for the project, for example:

```sql
CREATE DATABASE pettopia;
```

After creating the database, set up the schema and seed data required by the application. If your repository includes SQL export files, import them into the new database before starting the backend.

## 3. Configure the backend

Create or update your Spring Boot configuration with the required database, JWT, and upload settings.

Example `application.properties` values:

```properties
spring.datasource.url=jdbc:mariadb://localhost:3306/pettopia
spring.datasource.username=YOUR_DB_USERNAME
spring.datasource.password=YOUR_DB_PASSWORD

jwt.secret=replace_this_with_a_long_random_secret
jwt.expiration-ms=86400000

app.upload.dir=${user.home}/pettopia-images
```

### Important local configuration notes
- The backend CORS configuration currently allows requests from `http://localhost:5173`
- Uploaded product images are stored locally under the configured upload directory
- The frontend service files currently point to `http://localhost:8080/api` and `http://localhost:8080/api/admin`

If you change the backend port, host, or frontend port, update the relevant frontend service files and backend CORS configuration.

## 4. Run the backend

From the backend project directory:

```bash
mvn spring-boot:run
```

By default, Spring Boot runs on port `8080` unless changed in configuration.

## 5. Run the frontend

From the frontend project directory:

```bash
npm install
npm run dev
```

The frontend is expected to run on:

```text
http://localhost:5173
```

## Authentication Notes

Pettopia uses stateless JWT authentication.

- Customer login returns a JWT token and customer email
- Admin login returns a JWT token, admin email, and role
- Protected routes require an `Authorization: Bearer <token>` header
- In the frontend, the token is stored in `localStorage` and attached through an Axios interceptor

### Public backend routes
These routes are currently permitted without authentication:

- `POST /api/customers/register`
- `POST /api/customers/login`
- `POST /api/customers/forgot-password`
- `POST /api/customers/reset-password`
- `POST /api/admin/login`
- `GET /api/products/search`
- `/images/**`

All other routes require authentication under the current Spring Security configuration.

## Password Reset Notes

The forgot-password flow is development-oriented in the current project:

- the backend generates a reset token
- the token is stored in the database
- the response includes the reset token and a reset URL for testing
- the frontend displays the reset link directly

This avoids needing a real email delivery service during local development.

## Password Policy

The current password policy requires:

- minimum length of 10 characters
- maximum length of 64 characters

Additional account protection includes:

- failed login attempt tracking
- temporary account lockout after repeated failed logins
- single-use password reset tokens with expiry

## Rewards System Notes

Pettopia includes a points-based rewards system with the following current behaviour:

- customers earn **1 point per €50 spent**
- points can be redeemed at checkout
- points are stored as reward transactions
- the rewards dashboard shows total points and transaction history
- checkout applies a points discount before saving the final order total

## Product Archive and Deletion Rules

The project includes archive logic for products.

- archived products are marked unavailable for customer flows
- archived products cannot be added to cart
- archived products already in a cart are removed when the cart is loaded
- archiving also updates product activity/discontinued flags
- if a product has existing order history, it is archived instead of hard-deleted

This helps preserve historical order data while preventing unavailable products from continuing through customer workflows.

## Image Upload Notes

Admin product management supports:

- one thumbnail image
- multiple gallery images

Uploaded files are:

- saved to a local upload directory
- given generated filenames
- returned as `/images/...` URLs
- displayed in both customer and admin views

## Project Status

This repository reflects a working academic and portfolio project. It implements the main customer and admin workflows end to end, but it should not be treated as production-ready commerce software without further hardening, automated testing, deployment configuration, and operational safeguards.

## Author

David Adebanwo