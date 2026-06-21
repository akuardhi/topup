# 🎮 TopUp Platform - Production Ready Digital Topup & E-commerce System

A complete, scalable, and secure digital topup platform similar to **Codashop** with integrated payment system, admin dashboard, and modern UI.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Node](https://img.shields.io/badge/node-v16+-green.svg)
![License](https://img.shields.io/badge/license-Proprietary-red.svg)

---

## 🌟 Features

### 👥 Customer Features
- ✅ Beautiful product catalog with categories and search
- ✅ Detailed product pages with dynamic form fields
- ✅ Secure checkout with multiple payment options
- ✅ User authentication (register/login)
- ✅ Order tracking and history
- ✅ Promo code support
- ✅ Real-time stock availability

### 💳 Payment Features
- ✅ QRIS (QR Code Indonesia Standard)
- ✅ GoPay Integration
- ✅ DANA Wallet
- ✅ Bank Transfer
- ✅ Automatic payment verification
- ✅ Invoice generation
- ✅ Payment history

### 🛡️ Admin Dashboard
- ✅ Professional admin panel
- ✅ Real-time statistics & charts
- ✅ Orders management
- ✅ Products CRUD operations
- ✅ User management
- ✅ Payment methods management
- ✅ Promo codes management
- ✅ Revenue analytics
- ✅ Activity logs

### 🔒 Security
- ✅ JWT authentication
- ✅ bcrypt password hashing
- ✅ Input validation (Joi)
- ✅ Rate limiting
- ✅ CORS protection
- ✅ Helmet.js security headers
- ✅ Environment variables

---

## 📦 Tech Stack

### Frontend Store
- **Framework**: Next.js 14+ with App Router
- **Styling**: TailwindCSS
- **Animation**: Framer Motion
- **HTTP Client**: Axios
- **Icons**: Heroicons
- **State Management**: React Hooks
- **TypeScript**: Type safety

### Admin Dashboard
- **Framework**: React 18+
- **Styling**: TailwindCSS
- **Charts**: Chart.js / Recharts
- **Tables**: React Table
- **Icons**: Heroicons

### Backend API
- **Runtime**: Node.js 16+
- **Framework**: Express.js
- **Database**: MySQL 5.7+
- **Authentication**: JWT + bcryptjs
- **Validation**: Joi
- **File Upload**: Multer
- **Rate Limiting**: express-rate-limit
- **Security**: Helmet.js
- **Task Scheduler**: node-cron

### Database
- **Type**: MySQL
- **Query Builder**: mysql2/promise
- **Connection Pooling**: Built-in
- **Backup-friendly**: .sql schema included

---

## 📂 Project Structure

```
topup-platform/
├── frontend-store/          # Customer-facing store
│   ├── app/
│   │   ├── page.tsx                  # Homepage with products
│   │   ├── layout.tsx                # Root layout
│   │   ├── login/page.tsx            # Login page
│   │   ├── register/page.tsx         # Registration page
│   │   ├── account/page.tsx          # User profile & orders
│   │   ├── products/
│   │   │   └── [id]/page.tsx         # Product detail & checkout
│   │   └── checkout/
│   │       └── [id]/page.tsx         # Checkout page
│   ├── package.json
│   ├── tsconfig.json
│   ├── next.config.ts
│   └── tailwind.config.js
│
├── admin-dashboard/         # Admin dashboard (React)
│   ├── src/
│   │   ├── pages/
│   │   │   ├── Dashboard.jsx         # Dashboard with stats
│   │   │   ├── Orders.jsx            # Orders management
│   │   │   ├── Products.jsx          # Products management
│   │   │   ├── Users.jsx             # Users management
│   │   │   ├── Payments.jsx          # Payment methods
│   │   │   ├── Promos.jsx            # Promo codes
│   │   │   └── Statistics.jsx        # Analytics
│   │   ├── components/
│   │   │   ├── Sidebar.jsx
│   │   │   ├── Tables/
│   │   │   └── Charts/
│   │   ├── App.jsx
│   │   └── main.jsx
│   └── package.json
│
├── backend-api/             # Express.js API server
│   ├── src/
│   │   ├── server.js                 # Main server file
│   │   ├── database/
│   │   │   ├── pool.js               # MySQL connection pool
│   │   │   └── connection.js         # Connection config
│   │   ├── middleware/
│   │   │   ├── auth.js               # JWT authentication
│   │   │   └── validation.js         # Input validation
│   │   ├── routes/
│   │   │   ├── auth.js               # Authentication routes
│   │   │   ├── products.js           # Products routes
│   │   │   ├── orders.js             # Orders routes
│   │   │   ├── payments.js           # Payments routes
│   │   │   ├── users.js              # Users routes (admin)
│   │   │   ├── stats.js              # Statistics routes
│   │   │   └── promos.js             # Promo codes routes
│   │   └── utils/
│   │       └── helpers.js            # Utility functions
│   ├── package.json
│   ├── .env.example
│   └── .gitignore
│
├── database/
│   └── schema.sql                    # Complete database schema
│
├── uploads/                          # File storage
├── config/                           # Configuration files
├── scripts/                          # Database scripts
├── DEPLOYMENT.md                     # Deployment guide
└── README.md                         # This file
```

---

## 🚀 Quick Start

### Prerequisites
- Node.js v16 or higher
- MySQL 5.7 or higher
- Git

### Installation (5 minutes)

```bash
# 1. Clone repository
git clone <repository-url>
cd topup-platform

# 2. Setup database
mysql -u root -p < database/schema.sql

# 3. Setup Backend
cd backend-api
cp .env.example .env
nano .env  # Edit with your settings
npm install
npm run dev

# 4. Setup Frontend (new terminal)
cd frontend-store
npm install
npm run dev

# Visit http://localhost:3000
```

---

## 🔑 Demo Credentials

**Admin Account**
```
Email: admin@topup.local
Password: (Check schema.sql for hashed password)
```

**Customer Test**
- Register a new account at http://localhost:3000/register
- Login and start shopping

---

## 📚 API Documentation

### Base URL
```
http://localhost:5000/api
```

### Authentication
All protected endpoints require JWT token in header:
```
Authorization: Bearer YOUR_JWT_TOKEN
```

### Key Endpoints

#### Auth
- `POST /auth/register` - Register new user
- `POST /auth/login` - User login
- `GET /auth/me` - Get current user

#### Products
- `GET /products` - List all products
- `GET /products/:id` - Get product details
- `POST /products` - Create product (admin)
- `PUT /products/:id` - Update product (admin)
- `DELETE /products/:id` - Delete product (admin)

#### Orders
- `GET /orders` - Get user orders
- `POST /orders` - Create order
- `GET /orders/:id` - Get order details
- `PUT /orders/:id` - Update order (admin)

#### Payments
- `GET /payments` - List payment methods
- `POST /payments` - Create payment method (admin)

#### Promo Codes
- `GET /promo` - Get active promo codes
- `POST /promo/validate` - Validate promo code
- `POST /promo` - Create promo (admin)

#### Statistics
- `GET /stats/dashboard` - Dashboard stats (admin)
- `GET /stats/revenue` - Revenue analytics (admin)
- `GET /stats/orders` - Order statistics (admin)

See [DEPLOYMENT.md](./DEPLOYMENT.md) for complete API documentation.

---

## 🔐 Environment Variables

### Backend (.env)
```env
# Database
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=topup_platform

# Server
PORT=5000
NODE_ENV=development

# JWT
JWT_SECRET=your_secret_key_here
JWT_EXPIRE=7d

# Midtrans Payment Gateway
MIDTRANS_SERVER_KEY=your_key
MIDTRANS_CLIENT_KEY=your_key
MIDTRANS_ENV=sandbox

# URLs
FRONTEND_URL=http://localhost:3000
ADMIN_URL=http://localhost:3001
```

### Frontend (.env.local)
```env
NEXT_PUBLIC_API_URL=http://localhost:5000
```

---

## 💾 Database Schema

The system includes 10+ tables:
- `users` - User accounts
- `products` - Digital products catalog
- `orders` - Customer orders
- `transactions` - Payment transactions
- `payments` - Payment methods
- `promo_codes` - Discount codes
- `admin_logs` - Activity logs
- `reviews` - Product reviews

See [database/schema.sql](./database/schema.sql) for full schema.

---

## 🛠️ Development Commands

### Backend
```bash
cd backend-api

# Development with auto-reload
npm run dev

# Production
npm start

# Database migration
npm run migrate
```

### Frontend
```bash
cd frontend-store

# Development server
npm run dev

# Build for production
npm run build

# Start production server
npm run start
```

### Admin Dashboard
```bash
cd admin-dashboard

# Start development
npm run dev

# Build
npm run build
```

---

## 📱 Device Support

- ✅ Desktop (1920px and above)
- ✅ Tablet (768px - 1024px)
- ✅ Mobile (320px - 767px)

All pages are fully responsive with Tailwind CSS breakpoints.

---

## 🎨 UI/UX Highlights

- **Modern Design**: Gradient backgrounds, smooth transitions
- **Professional Layout**: Clean admin dashboard similar to Stripe
- **Accessibility**: WCAG 2.1 compliant
- **Performance**: Optimized images, lazy loading
- **Mobile First**: Responsive design priority
- **Dark Mode Ready**: (Can be implemented easily)

---

## 🚀 Deployment Options

### Docker
```bash
docker-compose up -d
```

### VPS (Ubuntu/Debian)
See [DEPLOYMENT.md](./DEPLOYMENT.md) for complete VPS setup guide.

### Cloud Platforms
- AWS EC2
- DigitalOcean
- Heroku
- Vercel (Frontend only)

---

## 🔄 Integrations

### Payment Gateway
- **Midtrans** (QRIS, GoPay, DANA, Bank Transfer)
- Webhook support for payment confirmation
- Automatic invoice generation

### External Services
- Email notifications (optional)
- SMS notifications (optional)
- Third-party API integration

---

## 📊 Analytics & Monitoring

- Real-time revenue tracking
- Order statistics
- Product performance
- User analytics
- Admin activity logs

---

## 🐛 Known Issues & Roadmap

### Current Status
✅ Core functionality complete
✅ Database schema finalized
✅ API endpoints ready
✅ Frontend pages built
⏳ Email notifications (planned)
⏳ SMS notifications (planned)
⏳ Advanced analytics (planned)

---

## 🤝 Contributing

Contributions are welcome! Please follow:
1. Create feature branch
2. Make changes
3. Test thoroughly
4. Submit pull request

---

## 📄 License

This project is proprietary and confidential. All rights reserved.

---

## 📞 Support

For issues, feature requests, or questions:
- 📧 Email: support@topup-platform.com
- 💬 Discord: [Join Server](#)
- 📱 WhatsApp: [Message](#)

---

## 🙏 Acknowledgments

Built with modern tech stack and best practices in mind.

---

**Made with ❤️ by TopUp Platform Team**

*Last Updated: March 16, 2024*
