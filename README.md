# Pettopia Project – Weekly Progress & Feature Summary

## Project: Pettopia Online Pet Store  
Repository: assignment-two-dtabs17  
Student: David Adebanwo
K-Number: K00278226
Module: Enterprise Application Development / IT Industrial Practice

---

## Overview

Pettopia is an online pet store for small domestic pets, built with:

- **Backend**: Spring Boot (embedded Tomcat), Maven, MySQL/MariaDB
- **Frontend**: React + Axios + Bootstrap (dark theme, responsive)
- **Auth**: JWT-based authentication for customers and admin users
- **Architecture**: MVC on backend, REST API, responsive SPA frontend

Core database tables used: `products`, `categories`, `customers`, `orders`, `order_items`, `order_status`, `discount_codes`, `reviews`, `admin_users`, plus additional tables for wishlist, reward transactions, and password reset tokens.

---

## Week 1 – Project Setup & Product Search

### Backend

- Cloned Spring Boot starter project and configured **MySQL/MariaDB** connection.
- Verified Maven build and application startup.
- Created:
  - `ProductController`, `ProductService`, `ProductRepository`.
- Implemented **product search** endpoint:
  - Filter by **category**, **min price**, **max price**, **keyword** (description).
  - Null-safe optional filters in service layer.
  - Returned product data with thumbnail URL.
- Tested search API via Postman.

### Frontend

- Created React app (`pettopia-frontend`).
- Configured **Axios** base URL and integrated with backend.
- Installed and wired **Bootstrap** for styling.
- Implemented **ProductSearch** component:
  - Inputs for category, min price, max price, and keyword.
  - Calls backend on search.
  - Displays results in **tabular form** with **thumbnail**, name, price, and truncated description.
- Confirmed CORS works using `WebMvcConfigurer` and CORS config in Spring Boot.

---

## Week 2 – Product Detail, Images, Stock Alerts, Cart Basics

### Product Drill-Down

- Implemented **product detail endpoint** returning:
  - Core product fields (name, price, description, stock, date added).
  - Category info for breadcrumbs.
  - Any discount details (when present).
  - Reviews and reviewer info.
- Added **product detail React page** (`ProductDetail`):
  - Clicking the product thumbnail in search navigates to the product detail view.
  - Shows:
    - Header with product name, price, category, availability.
    - **Breadcrumb navigation**: e.g. `Home > Dogs > Toys > ProductName`.
    - Description, date added.
    - **Image gallery** (uses `image_gallery` / thumbnail).
    - Reviews list and average rating (if reviews exist).

### Stock Handling

- On the product detail page:
  - If `stock_quantity < 10` ? shows **“Low stock”** alert.
  - If `stock_quantity == 0` ? **“Out of stock / unavailable”** message and **disables Add to Cart**.
- Backend enforces stock check so out-of-stock items cannot be added even via direct API calls.

### Cart – Initial Implementation

- Implemented basic cart model with:
  - `Cart`, `CartItem` entities.
  - `CartRepository`, `CartItemRepository`.
- API endpoints to:
  - Add item to cart.
  - Get cart by authenticated customer.
- Created initial `Cart` React component to display cart contents for logged-in users.

---

## Week 3 – Full Cart / Orders, Wishlist, Back Office

### Cart & Order Finalisation

- Completed full **cart lifecycle**:
  - **Update quantity** (with max = stock).
  - **Remove** single item.
  - **Clear cart**.
- Implemented **order finalisation** in `OrderService.finalizeCart`:
  - Resolves customer from JWT.
  - Fetches customer cart.
  - Validates cart is not empty.
  - Creates `Order` and associated `OrderItem` records.
  - Calculates `total` from line items.
  - Decrements `product.stock_quantity` for each purchased item.
  - Assigns default `OrderStatus` (e.g. Pending).
  - Clears cart after successful order.
- `OrderController`:
  - `POST /api/orders/finalize`
  - `GET /api/orders/my-orders` – list of all customer orders.

### Orders Frontend

- `Cart.jsx`:
  - Displays items in tabular form (product name, price, quantity, row total).
  - Supports **update quantity**, **remove**, **clear cart**.
  - **Finalize Order** button calls `/orders/finalize`.
  - Shows alert with order ID on success.
- `Orders.jsx`:
  - Fetches customer’s previous orders using `/orders/my-orders`.
  - Displays order date, total, status, and items.

### Wishlist – Unique Feature (Part 1)

- Implemented **wishlist** for authenticated customers:
  - Entity and repository to store wishlist items (customer + product).
  - Endpoints to:
    - Add product to wishlist.
    - Remove product from wishlist.
    - List wishlist items for current customer.
- React:
  - On the product detail page, a **heart icon** beside the product name toggles the wishlist state: clicking the heart adds the product to the wishlist, and clicking again removes it (filled heart = in wishlist, outline heart = not in wishlist).
  - `Wishlist.jsx` component displays the user’s wishlist with product name, price, and a remove action.

### Back-office (Admin)

- Admin authentication:
  - Separate admin login endpoint (`/api/admin/login`).
  - Uses JWT with roles (`ADMIN`, `MANAGER`).
- Secured routes:
  - `/api/admin/**` protected by role-based access (Spring Security).
- Admin product management:
  - Admin can **list**, **create**, **edit**, and **update** products.
  - Validation via Spring (`@Valid`, constraint annotations) for product data.
  - Supports **image upload / replace** (thumbnail + additional images).
- Product archiving:
  - Products can be **archived** (e.g. `active` flag).
  - Archived products:
    - Are hidden from normal catalogue search.
    - Keep existing reviews and order history.
    - Can be **reactivated** later if needed.
    - Cannot be added to cart once archived.
  - Behaviour defined for:
    - Existing carts containing an item that becomes archived:
      - At checkout, archived / unavailable items are rejected or removed with an error message.

---

## Week 4 – Unique Features, Security & Password Scheme

### Unique Feature – Points-Based Rewards System (Loyalty)

**Core idea:** points-based loyalty system where customers earn points from orders and can redeem them as discounts.

#### Backend

- Entities:
  - `RewardTransaction`:
    - Fields: `id`, `customer`, `points`, `transactionType (EARN/REDEEM)`, `source`, `reason`, `createdAt`.
  - Added `rewardPoints` field to `Customer`.
- Repository:
  - `RewardTransactionRepository` with `findByCustomerOrderByCreatedAtDesc(customer)`.
- DTOs:
  - `RewardSummaryDTO` – `totalPoints`, `transactions`.
- `CustomerService`:
  - `earnPoints(customerId, points, source)`:
    - Increments `customer.rewardPoints`.
    - Inserts `RewardTransaction` of type `EARN`.
  - `getRewardHistory(email)`:
    - Looks up customer by email.
    - Fetches all reward transactions sorted by `createdAt DESC`.
    - Computes `totalPoints` as the sum of all transaction points.
  - `redeemPoints(email, points, reason)`:
    - Validates sufficient points (using transaction sum).
    - Creates `RewardTransaction` with negative `points` and type `REDEEM`.
    - Returns updated `RewardSummaryDTO`.
- `CustomerController`:
  - `GET /api/customers/rewards` – current total points + history.
  - `POST /api/customers/rewards/redeem` – redeem points (via JSON body) when used directly.
- `OrderService.finalizeCart`:
  - Calculates **order total** from cart.
  - Applies **points discount** based on a redemption request (points used are treated as €1 per point).
  - Enforces:
    - Points used ? current available points.
    - Points used ? order total.
  - Sets `orderTotalAfterDiscount` and persists order.
  - Awards new points based on **conversion**:
    - `1 point per €50 spent` (using `BigDecimal` and `RoundingMode.DOWN`).
  - Calls `customerService.earnPoints(...)` to record earned points.

#### Frontend

- `RewardsDashboard.jsx`:
  - Fetches `/customers/rewards`.
  - Shows **current total points** and full **transactions table**.
  - Allows manual redemption (simulation) via `/customers/rewards/redeem`.
- `Cart.jsx`:
  - Displays **cart total**.
  - Fetches current reward points when cart loads.
  - Allows user to enter **points to use** before clicking **Finalize Order**.
  - Automatically recalculates **visible total** on the frontend:
    - `finalTotal = originalTotal – pointsUsed`.
  - Shows hint: **“You’ll earn X points from this order”** based on the same €50-per-point rule.
  - Calls `finalizeCart` with the chosen points; backend confirms and enforces rules.

Result: Points system is fully integrated into checkout and visible to the user.

### Unique Feature – Wishlist (Recap)

- Authenticated users:
  - Add products to wishlist using the **heart button** on the product detail page (and remove them using the same toggle).
  - View and manage wishlist items on a dedicated wishlist page.
- Wishlist items reuse existing `products` data and the authenticated customer context.
- This supports “save for later” behaviour and encourages users to return to products they are interested in.

---

## Password Management & Security Scheme

### Storage & Hashing

- All **customer** and **admin** passwords are stored as **BCrypt hashes**.
- `BCryptPasswordEncoder` is used for hashing and verification.
- BCrypt uses a unique salt per password, so identical plain-text passwords produce different hashes.

### Password Policy

- Enforced on **registration** and **password reset**:
  - Minimum length (e.g. 8 characters).
  - Optional additional checks (uppercase, lowercase, digit, special char) if configured.
- Existing accounts with older/weaker passwords:
  - Still allowed to log in.
  - Any **new** password (registration / reset) must comply with the current policy.

### Brute Force Protection

- `Customer` entity stores:
  - `failedLoginAttempts`
  - `accountLockedUntil`
- `loginCustomer` logic:
  - On each failed login, increments `failedLoginAttempts`.
  - After too many failed attempts (e.g. 5), locks the account for a time window.
  - On successful login, resets `failedLoginAttempts` and clears lock.
- This limits brute force attempts and provides clear feedback when the account is temporarily locked.

### Forgot / Reset Password Flow

- `POST /api/customers/forgot-password`:
  - Accepts email.
  - Generates a `PasswordResetToken`:
    - `token` (UUID)
    - `customer`
    - `expiresAt` (e.g. now + 1 hour)
    - `used = false`
  - Saves token to DB.
  - In real deployment, an email would be sent. For this project, token and reset link are logged and/or returned to frontend for testing.
- `POST /api/customers/reset-password`:
  - Accepts token and new password.
  - Validates:
    - Token exists.
    - Not expired.
    - Not used.
    - New password satisfies policy.
  - Hashes new password with BCrypt and updates the customer.
  - Marks token as `used`.

Frontend:

- **ForgotPassword** page:
  - Simple form for email.
  - Calls `/forgot-password` and shows confirmation + reset link for dev/testing.
- **ResetPassword** page:
  - Reads `token` from `/reset-password?token=...`.
  - Lets user set new password; sends to `/reset-password`.

### Password Hints & Expiry

- **Password hints**:
  - Not implemented on purpose (to avoid leaking hints that help attackers).
- **Periodic mandatory changes**:
  - No forced “change every X months” rule.
  - Users can reset manually via forgot/reset flow.
  - Reason: modern guidance prefers strong, stable passwords + reset on suspicion rather than arbitrary forced rotations.

### Transport Security (HTTPS)

- For local dev, app runs on HTTP.
- For a real deployment, Pettopia is expected to be hosted behind HTTPS (TLS) so passwords are **never transmitted in plain text** over the network.
- This is a deployment concern (reverse proxy / server config), not controller code.

---

## Weekly Demo & Git Usage

- Work has been committed incrementally to GitHub with feature-focused branches:
  - `feature/product-search`
  - `feature/product-detail`
  - `feature/cart-orders`
  - `feature/wishlist`
  - `feature/cart-orders`
  - `feature/wishlist`
  - `feature/rewards`
  - `feature/password-management`
- In some cases, I worked on multiple features within the same branch, especially when previous features had bugs that were causing the app to crash. I fixed the new features, then later resolved the original issues that were affecting the earlier feature. This was done to avoid pushing broken code to the main branch.
- Each week:
  - New features implemented.
  - Tested locally.
  - Committed and pushed to the assignment repository.
- This MD file is updated to reflect weekly progress and major changes.

---

## Final Steps

- Final UI polish and responsiveness checks.
- Additional validation and friendly error messages across the frontend.
- Small UX tweaks.
- Final test on a clean machine / environment to make sure everything runs as expects.
