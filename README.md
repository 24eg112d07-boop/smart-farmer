# Smart Farmer Marketplace and Rental System

A complete full-stack web application designed for agricultural commerce, heavy farm equipment leasing, and integrated farm accounting.

> **Academic Project Notice**: This project is developed for academic purposes with clean architecture, real Spring Boot REST APIs, and live MySQL database connectivity. Online payment workflows are simulated with cash-on-delivery and test checkout for transparent demonstration.

---

## 1. System Architecture

```text
smart-farmer-marketplace/
├── backend/
│   ├── src/main/java/com/smartfarmer/
│   │   ├── config/             # Security, CORS, and sample data initializer
│   │   ├── controller/         # REST API endpoints
│   │   ├── dto/                # Request and Response transfer objects
│   │   ├── entity/             # JPA entities (User, Product, Order, Equipment, etc.)
│   │   ├── exception/          # Custom exceptions and @RestControllerAdvice handler
│   │   ├── repository/         # Spring Data JPA repositories
│   │   ├── security/           # JWT token provider, filter, and UserPrincipal
│   │   └── service/            # Core business logic and database transaction services
│   ├── src/main/resources/
│   │   ├── application.properties
│   │   └── application.properties.example
│   ├── src/test/java/com/smartfarmer/ # Automated unit and business logic tests
│   ├── pom.xml
│   └── mvn.cmd
├── frontend/
│   ├── src/
│   │   ├── assets/             # Static graphics
│   │   ├── components/         # Reusable UI widgets (Navbar, Sidebar, StatCard, Modal, Alert, etc.)
│   │   ├── context/            # React AuthContext (JWT) and CartContext (localStorage)
│   │   ├── layouts/            # MainLayout, DashboardLayout, and ProtectedRoute
│   │   ├── pages/              # 19 pages (Marketplace, Equipment, Orders, Finances, Admin, etc.)
│   │   └── services/           # Axios API client with automatic JWT bearer header
│   ├── index.html
│   ├── package.json
│   ├── vite.config.js
│   └── tailwind.config / index.css
├── run-backend.bat             # One-click backend runner
├── run-frontend.bat            # One-click frontend runner
└── README.md
```

---

## 2. Technology Stack

### Backend
- **Language**: Java (JDK 21 / 25 compatible)
- **Framework**: Spring Boot 3.2.4
- **ORM & Data**: Spring Data JPA / Hibernate
- **Security**: Spring Security 6 with BCrypt password hashing & JJWT (0.12.6)
- **Validation**: Jakarta Validation API (`@Valid`, `@NotNull`, `@Min`, `@DecimalMin`)
- **Build Tool**: Apache Maven 3.9+
- **Testing**: JUnit 5, Mockito

### Frontend
- **Framework**: React 19 / Vite
- **Routing**: React Router DOM (v7)
- **HTTP Client**: Axios
- **Styling**: Tailwind CSS
- **Icons**: React Icons (FontAwesome)

### Database
- **Engine**: MySQL Server 8.0+
- **Database Name**: `smart_farmer_db`
- **Port**: 3306

---

## 3. User Roles & Capabilities

| Role | Permissions & Capabilities |
| :--- | :--- |
| **`FARMER`** | Browse agricultural marketplace, add supplies to cart, checkout with real stock validation, view order history, cancel orders (auto stock restoration), browse machinery, request equipment rentals with auto-calculated duration pricing, view personal bookings, maintain farm income/expense financial ledger, update profile. |
| **`EQUIPMENT_OWNER`** | Publish machinery rental listings (tractors, harvesters, tillers, sprayers), edit/delete own listings, receive and review incoming rental requests, approve/reject requests with automatic overlap conflict protection, complete leases, view rental revenue. |
| **`ADMIN`** | System-wide administrator. View overall platform analytics, manage and activate/deactivate users, audit all marketplace product orders, inspect all equipment leases. **(Strictly protected on backend; public registration as admin is prohibited)**. |

---

## 4. Test Credentials (Pre-Seeded)

| Role | Email | Password | Pre-loaded Data |
| :--- | :--- | :--- | :--- |
| **Farmer** | `farmer@smartfarmer.com` | `Farmer@123` | Seed financial records, basmati seeds product |
| **Equipment Owner** | `owner@smartfarmer.com` | `Owner@123` | 4 machinery listings, 5 agricultural supplies |
| **Administrator** | `admin@smartfarmer.com` | `Admin@12345` | System-wide administrative permissions |

*(You can also register a brand new Farmer or Equipment Owner through the registration page `/register`).*

---

## 5. Database Setup (MySQL)

1. Ensure MySQL Server 8.0 is running on port 3306.
2. Open MySQL CLI or MySQL Workbench:
   ```sql
   CREATE DATABASE IF NOT EXISTS smart_farmer_db;
   ```
3. Update `backend/src/main/resources/application.properties` with your database credentials (or set environment variables `DB_USERNAME` and `DB_PASSWORD`):
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/smart_farmer_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
   spring.datasource.username=root
   spring.datasource.password=123456
   ```

---

## 6. How to Run the Application

### Method A: One-Click Launch (Windows)
1. Double-click `run-backend.bat` to launch the Spring Boot backend on `http://localhost:8080`.
2. Double-click `run-frontend.bat` to launch Vite React on `http://localhost:5173`.
3. Open your browser and navigate to `http://localhost:5173`.

### Method B: Terminal Commands

#### 1. Start Spring Boot Backend:
```bash
cd backend
# Run pre-built JAR:
java -jar target/smart-farmer-backend-1.0.0.jar

# Or rebuild and run using Maven:
.\mvn.cmd spring-boot:run
```
The backend initializes the database tables, seeds sample accounts, and begins listening on `http://localhost:8080`.

#### 2. Start React Frontend:
```bash
cd frontend
npm install
npm run dev
```
Open `http://localhost:5173` in your web browser.

---

## 7. Running Backend Automated Tests

To execute the automated unit and integration tests:
```bash
cd backend
.\mvn.cmd test
```
**Results**:
- `AuthServiceTest`: Registration, duplicate email rejection, admin creation prevention, password hashing.
- `OrderServiceTest`: Stock decrement on order, insufficient stock rejection, stock restoration on order cancellation.
- `RentalBookingServiceTest`: Date validation (past dates, end < start), overlapping booking conflict prevention, price calculations.
- `FinancialRecordServiceTest`: Net balance calculations, system-generated record protection.

**Test Status**: `14 tests executed, 0 failures, 0 errors (BUILD SUCCESS)`.

---

## 8. REST API Reference

### Authentication
- `POST /api/auth/register` - Create new FARMER or EQUIPMENT_OWNER account
- `POST /api/auth/login` - Authenticate and return JWT token
- `GET  /api/auth/me` - Retrieve current user profile

### User Profile
- `GET  /api/users/profile` - Get logged-in user profile
- `PUT  /api/users/profile` - Update name, phone, address

### Products Marketplace
- `GET    /api/products` - Browse products with optional `category` and `search` query
- `GET    /api/products/{id}` - Product details
- `GET    /api/products/my` - Products listed by seller
- `POST   /api/products` - Create product listing
- `PUT    /api/products/{id}` - Update product
- `DELETE /api/products/{id}` - Remove product

### Orders
- `POST  /api/orders` - Place order (validates stock, deducts quantity, logs financial expense)
- `GET   /api/orders/my` - Logged-in farmer's order history
- `GET   /api/orders/{id}` - Order details
- `PATCH /api/orders/{id}/cancel` - Cancel order (restores product stock, logs refund)

### Equipment Rentals
- `GET    /api/equipment` - Browse machinery with `category` and `search` filters
- `GET    /api/equipment/{id}` - Machinery details
- `GET    /api/equipment/my` - Equipment owned by current user
- `POST   /api/equipment` - Add machinery to rental fleet
- `PUT    /api/equipment/{id}` - Update machinery listing
- `DELETE /api/equipment/{id}` - Remove machinery listing

### Rental Bookings
- `POST  /api/rentals` - Request rental booking (checks conflict, validates dates, calculates cost)
- `GET   /api/rentals/my` - Farmer's booking history
- `GET   /api/rentals/received` - Equipment owner's incoming rental requests
- `PATCH /api/rentals/{id}/approve` - Approve booking (verifies overlap, creates owner income & renter expense)
- `PATCH /api/rentals/{id}/reject` - Reject booking
- `PATCH /api/rentals/{id}/cancel` - Cancel booking (logs refund)
- `PATCH /api/rentals/{id}/complete` - Mark rental completed

### Financial Ledger
- `GET    /api/finance/records` - List user financial records
- `POST   /api/finance/records` - Manually record income or expense
- `DELETE /api/finance/records/{id}` - Delete manual record
- `GET    /api/finance/summary` - Aggregate total income, total expense, net balance, and 6-month trends

### Administration (`ROLE_ADMIN`)
- `GET   /api/admin/dashboard` - Platform-wide statistics
- `GET   /api/admin/users` - All users directory
- `PATCH /api/admin/users/{id}/status` - Activate or deactivate user
- `GET   /api/admin/orders` - Platform order audit
- `GET   /api/admin/rentals` - Platform machinery lease audit

---

## 9. Key Business Rules & Verification

1. **Inventory Stock Protection**:
   Stock is validated inside a database transaction before placing orders. Placing an order with insufficient stock returns `409 Conflict`. Cancelling an order restores the items back into inventory.
2. **Machinery Overlap Prevention**:
   Rentals for the same machine cannot overlap if another approved/active booking exists (`startDate <= existingEnd AND endDate >= existingStart`). Attempts to book overlapping dates are rejected with `409 Conflict`.
3. **Double-Entry Financial Tracking**:
   Buying agricultural supplies automatically generates an expense record for the farmer and an income record for the seller. Approving a machine lease generates an expense record for the renter and an income record for the machinery owner. System records are distinguished from manual records and locked against accidental alteration.
4. **Backend Role Security**:
   Endpoints under `/api/admin/**` enforce `hasRole('ADMIN')` on the Spring Boot backend. Client-side navigation guards reflect user roles.
