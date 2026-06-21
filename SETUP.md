# 🚀 TopUp Platform - Complete Setup Guide

## ⏱️ Estimated Setup Time: 15-20 minutes

---

## 📋 Prerequisites Checklist

Before you start, ensure you have:

- [ ] **Node.js v16+** - Download from [nodejs.org](https://nodejs.org)
- [ ] **MySQL 5.7+** - Download from [mysql.com](https://www.mysql.com/downloads)
- [ ] **Git** - Download from [git-scm.com](https://git-scm.com)
- [ ] **Code Editor** - VS Code, WebStorm, or similar
- [ ] **Command Line Experience** - Basic terminal commands

---

## 🔧 Step-by-Step Setup

### Step 1: Verify Node.js and MySQL Installation (2 minutes)

```bash
# Check Node.js
node --version
npm --version

# Expected output: v16.0.0 or higher

# Check MySQL
mysql --version

# Expected output: mysql Ver 8.0.x or similar
```

### Step 2: Database Setup (3 minutes)

#### Option A: Using MySQL Command Line

```bash
# Open MySQL CLI
mysql -u root -p

# When prompted, enter your MySQL root password

# Create the database and import schema
mysql> CREATE DATABASE topup_platform;
mysql> USE topup_platform;
mysql> SOURCE C:\path\to\database\schema.sql;

# Verify
mysql> SHOW TABLES;
mysql> EXIT;
```

**Expected Tables (10 total):**
```
admin_logs
orders
payments
promo_codes
products
reviews
transactions
users
```

#### Option B: Using MySQL Workbench

1. Open MySQL Workbench
2. Connect to localhost (default root/paswordless)
3. File → Open SQL Script → Select `database/schema.sql`
4. Execute (Ctrl+Shift+Enter)
5. Verify tables in left sidebar

### Step 3: Backend API Setup (5 minutes)

```bash
# Navigate to backend directory
cd backend-api

# Copy environment template
cp .env.example .env

# Edit configuration with your settings
nano .env
# OR on Windows: notepad .env
```

**Edit .env with these values:**

```env
# Database Connection
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password  # ← Change this!
DB_NAME=topup_platform

# Server
PORT=5000
NODE_ENV=development

# Security (Change in production!)
JWT_SECRET=your_super_secret_key_change_this_in_production

# Payment Gateway (Optional for now)
MIDTRANS_SERVER_KEY=your_midtrans_server_key
MIDTRANS_CLIENT_KEY=your_midtrans_client_key
MIDTRANS_ENV=sandbox

# URLs
FRONTEND_URL=http://localhost:3000
ADMIN_URL=http://localhost:3001
```

**Install and Run:**

```bash
# Install dependencies (takes 2-3 minutes)
npm install

# Start development server
npm run dev

# Expected output:
# ╔═══════════════════════════════════════════╗
# ║  🚀 TOPUP PLATFORM API SERVER             ║
# ║  PORT: 5000                               ║
# ║  Environment: development                 ║
# ║  Database: localhost:topup_platform       ║
# ╚═══════════════════════════════════════════╝
```

✅ **Backend is ready at:** `http://localhost:5000`

### Step 4: Frontend Store Setup (5 minutes)

```bash
# Open NEW terminal/tab
cd frontend-store

# Install dependencies (takes 2-3 minutes)
npm install

# Create environment file
cp .env.example .env.local
# OR create manually: nano .env.local

# Add this content:
# NEXT_PUBLIC_API_URL=http://localhost:5000
```

**Start Development Server:**

```bash
npm run dev

# Expected output:
# ▲ Next.js 14.0.0
# - Local: http://localhost:3000
# - Environments: .env.local
```

✅ **Frontend is ready at:** `http://localhost:3000`

---

## ✨ Verify Installation

### 1. Check Backend Health

```bash
# In your browser or terminal:
curl http://localhost:5000/health

# Expected response:
{
  "status": "OK",
  "timestamp": "2024-03-16T10:30:00Z",
  "environment": "development",
  "endpoints": [...]
}
```

### 2. Visit Frontend

Open browser and go to:
```
http://localhost:3000
```

You should see:
- ✅ TopUp Platform homepage
- ✅ Product cards with categories
- ✅ Professional styling with Tailwind CSS
- ✅ Navigation buttons

### 3. Test Authentication

```bash
# Register a new account
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "password123",
    "phone": "08123456789"
  }'

# Expected response:
{
  "message": "Registrasi berhasil",
  "user": {
    "id": 2,
    "name": "Test User",
    "email": "test@example.com"
  }
}
```

### 4. Test Product Listing

```bash
curl http://localhost:5000/api/products

# Expected: Array of products from database
```

---

## 🎮 Quick Test Walkthrough (5 minutes)

1. **Homepage** (http://localhost:3000)
   - See product catalog
   - Click on a product

2. **Product Detail** (http://localhost:3000/products/1)
   - View product details
   - Fill in user data
   - Click "Checkout Sekarang"

3. **Checkout** (http://localhost:3000/checkout/1)
   - Review order
   - Select payment method
   - Note: Payment is simulated (no actual charge)

4. **Register Account** (http://localhost:3000/register)
   - Create new account
   - Fill in all fields
   - Submit

5. **Login** (http://localhost:3000/login)
   - Login with created account
   - View order history
   - Access account settings

---

## 📱 Admin Access (Optional)

### Login to Admin (Not yet implemented, but ready)

Admin endpoints are available at:
```
GET /api/stats/dashboard    - Dashboard statistics
GET /api/orders/admin/all   - All orders
GET /api/users              - All users
GET /api/products           - Product management
GET /api/payments           - Payment methods
GET /api/promo              - Promo codes
```

Admin demo account:
```
Email: admin@topup.local
Password: (hashed in database - use register to create admin account)
```

---

## 🐛 Troubleshooting

### Issue: "Cannot find module" error

**Solution:**
```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Issue: "Port 5000 already in use"

**Solution:**
```bash
# Find process using port 5000
lsof -i :5000

# Kill process (replace PID with actual process ID)
kill -9 <PID>

# Windows:
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

### Issue: "Cannot connect to database"

**Solution:**
```bash
# Check MySQL is running
sudo service mysql status

# Windows: Services → MySQL80

# Restart MySQL
sudo service mysql restart

# Test connection
mysql -u root -p -h localhost -e "SELECT 1;"
```

### Issue: "JWT_SECRET not defined"

**Solution:**
```bash
# Make sure .env file exists
ls -la backend-api/.env

# Ensure all required variables are set
cat backend-api/.env | grep JWT_SECRET

# If missing, edit .env and add:
JWT_SECRET=your_secret_here
```

### Issue: Frontend shows "API connection error"

**Solution:**
```bash
# Check backend is running
curl http://localhost:5000/health

# Update NEXT_PUBLIC_API_URL in frontend-store/.env.local
NEXT_PUBLIC_API_URL=http://localhost:5000

# Restart frontend
npm run dev
```

---

## 📚 File Structure Quick Reference

```
topup-platform/
├── backend-api/
│   ├── src/
│   │   ├── server.js           ← Main server
│   │   ├── routes/             ← API endpoints
│   │   ├── middleware/         ← Auth & validation
│   │   └── database/           ← Database connection
│   ├── .env                    ← Configuration (CREATE THIS!)
│   ├── .env.example            ← Template
│   └── package.json
│
├── frontend-store/
│   ├── app/
│   │   ├── page.tsx            ← Homepage
│   │   ├── login/page.tsx       ← Login
│   │   ├── register/page.tsx    ← Register
│   │   ├── products/[id]/       ← Product detail & checkout
│   │   └── account/page.tsx     ← User account
│   ├── .env.local              ← Configuration (CREATE THIS!)
│   └── package.json
│
├── database/
│   └── schema.sql              ← Database structure
│
├── README.md                   ← Project overview
└── DEPLOYMENT.md               ← Deployment guide
```

---

## 🔑 Default Demo Account

After running the schema:

```
Email: admin@topup.local
Role: admin
```

You can use this account for admin API testing.

---

## ✅ Installation Checklist

- [ ] Node.js and npm installed
- [ ] MySQL installed and running
- [ ] Database created from schema.sql
- [ ] Backend `.env` configured
- [ ] Backend dependencies installed (`npm install`)
- [ ] Backend server running (`npm run dev`)
- [ ] Frontend dependencies installed (`npm install`)
- [ ] Frontend `.env.local` configured
- [ ] Frontend server running (`npm run dev`)
- [ ] Browser shows homepage at `http://localhost:3000`
- [ ] API responds to `/health` endpoint
- [ ] Can register new user
- [ ] Can view products

---

## 🚀 Next Steps

1. **Explore the API**
   - Try different endpoints
   - Create test data
   - Test authentication

2. **Customize Settings**
   - Add your company name in homepage
   - Update product listings
   - Configure payment gateway

3. **Deploy to Production**
   - See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed instructions
   - Options: Docker, VPS, Cloud platforms

4. **Implement Payment Gateway**
   - Sign up for Midtrans
   - Add server/client keys to `.env`
   - Implement webhook handlers

5. **Build Admin Dashboard**
   - Use [admin-dashboard/](./admin-dashboard/) directory
   - Install dependencies: `cd admin-dashboard && npm install`
   - Customize per your needs

---

## 📞 Getting Help

If you encounter issues:

1. **Check Logs**
   - Backend: Check terminal where you ran `npm run dev`
   - Frontend: Check browser console (F12 → Console tab)
   - Database: Check MySQL log file

2. **Common Commands**
   ```bash
   # Check MySQL is accessible
   mysql -u root -p

   # Test backend
   curl http://localhost:5000/health

   # Clear cache and reinstall
   rm -rf node_modules
   npm install
   ```

3. **Enable Debug Mode**
   ```bash
   DEBUG=* npm run dev    # Enable all debug logs
   ```

---

## 📊 Database Quick Commands

```bash
# Connect to database
mysql -u root -p topup_platform

# View all tables
SHOW TABLES;

# Check users
SELECT * FROM users;

# Check products
SELECT * FROM products;

# Check orders
SELECT * FROM orders;

# Count records
SELECT COUNT(*) FROM orders;

# View structure
DESCRIBE products;

# Exit
EXIT;
```

---

## 🎯 Success Indicators

After following this guide, you should have:

✅ Running MySQL database with all tables
✅ Working backend API on port 5000
✅ Working frontend store on port 3000
✅ Ability to register and login
✅ Product catalog visible
✅ Can create orders (checkout flow works)

---

## 📈 Performance Notes

- Initial page load: ~2-3 seconds
- API response time: <500ms (should be instant for your machine)
- Database queries: <100ms

If slower, check:
- MySQL is actually running
- Background processes consuming resources
- Network latency

---

## 🔐 Security Reminder

⚠️ **IMPORTANT**: The `.env` file contains sensitive information:
- **NEVER** commit `.env` to git
- **CHANGE** JWT_SECRET before production
- **USE** strong database passwords
- **KEEP** API keys secret

---

## 🎉 Congratulations!

You now have a **fully functional digital topup platform**!

Continue with:
1. [README.md](./README.md) - Full project documentation
2. [DEPLOYMENT.md](./DEPLOYMENT.md) - Production deployment
3. Customize to your needs
4. Add payment integration
5. Deploy to production

---

**Happy Coding! 🚀**

*Last Updated: March 16, 2024*
