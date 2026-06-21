# 🌐 Ardhistore Web Platform - Setup Summary

**Jenis Aplikasi**: Web-based (tidak APK)  
**Database UI**: phpMyAdmin (web-based)  
**Stack**: Next.js Frontend + Express Backend + MySQL Database

---

## 📊 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    USER BROWSER                              │
└──────────────┬──────────────────────────────────────┬────────┘
               │                                      │
        ┌──────▼─────────┐                 ┌─────────▼────┐
        │  Web Store UI  │                 │  phpMyAdmin  │
        │ (Port 3000)    │                 │ (Port 80)    │
        └──────┬─────────┘                 └──────┬───────┘
               │                                   │
        ┌──────▼────────────────────────────────┐ │
        │   Express Backend API (Port 5001)     │ │
        │  - Authentication                     │ │
        │  - Product Management                 │ │
        │  - Order Processing                   │ │
        └──────┬──────────────────────┬────────┘ │
               │                      │          │
        ┌──────▼──────────────────────▼────────┐ │
        │      MySQL Database (Port 3306)      │◄┘
        │   - topup_platform (database)        │
        │   - All tables (users, products...)  │
        └──────────────────────────────────────┘
```

---

## 🎯 COMPLETE WORKFLOW

### Phase 1: Frontend Setup ✅ (DONE)
```
✓ Next.js frontend installed
✓ Admin panel ready at /admin/*
✓ Demo login enabled (no DB needed)
✓ Frontend running on http://localhost:3000
```

### Phase 2: Database Setup (NEXT)
```
1. Install XAMPP → Get MySQL + phpMyAdmin
2. Start Apache + MySQL via XAMPP Control Panel
3. Create database via phpMyAdmin UI
4. Import schema.sql via phpMyAdmin UI
5. Add admin user via phpMyAdmin UI
```

### Phase 3: Backend Setup
```
1. npm install at backend-api
2. npm start to run API server
3. Connect to MySQL automatically
```

### Phase 4: Full System Testing
```
1. User registers/login via web
2. Admin adds products via web
3. Database updated automatically
4. Products appear on store
```

---

## 🚀 STEP-BY-STEP SETUP

### ✅ Step 1: Verify Frontend is Running

```powershell
# Already done from last session
# But if not running:
cd "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\frontend-store"
npm run dev
```

✅ Should see:
```
✓ Ready in X.Xs
- Local: http://localhost:3000
```

---

### ⏳ Step 2: Install MySQL + phpMyAdmin (Choose One)

**Option A: XAMPP (RECOMMENDED - All-in-one)**
1. Download: https://www.apachefriends.org/
2. Run installer
3. Install to: `C:\xampp`
4. Select: Apache, MySQL, PHP, phpMyAdmin
5. Finish

**Option B: MySQL Standalone**
1. Download: https://dev.mysql.com/downloads/mysql/
2. Install with MySQL Workbench
3. Install phpMyAdmin separately

**Option C: WAMP or MAMP**
- Windows WAMP: https://www.wampserver.com/
- macOS MAMP: https://www.mamp.info/

---

### ⏳ Step 3: Start MySQL & Apache

If using XAMPP:
1. Open: `C:\xampp\xampp-control-panel.exe`
2. Click **Start** next to:
   - ✅ Apache
   - ✅ MySQL
3. Wait for both to show green "Running"

Expected output:
```
Apache: Running on port 80
MySQL:  Running on port 3306
```

---

### ⏳ Step 4: Access phpMyAdmin

Open browser:
```
http://localhost/phpmyadmin
```

Login with:
```
Username: root
Password: (empty - just press Enter)
```

✅ You should see phpMyAdmin dashboard

---

### ⏳ Step 5: Create Database via phpMyAdmin

1. In phpMyAdmin, go to **"Databases"** tab
2. Under "Create new database", type: `topup_platform`
3. Select Collation: `utf8mb4_general_ci`
4. Click **"Create"**

✅ Database created successfully!

---

### ⏳ Step 6: Import Schema

1. Click database **`topup_platform`** (left sidebar)
2. Click **"Import"** tab
3. Click **"Choose File"**
4. Navigate to: `C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\database\schema.sql`
5. Click **"Import"**

Wait for:
```
✅ Import successful (XX queries executed)
```

✅ All tables created! Check left sidebar:
- users
- products
- categories
- orders
- order_items
- payments
- etc.

---

### ⏳ Step 7: Create Admin User

In phpMyAdmin:

1. Go to database **topup_platform**
2. Click table **users**
3. Click **"Insert"** tab
4. Fill form:
   ```
   id: (leave blank - auto)
   name: Admin
   email: admin@topup.local
   password: admin123
   role: admin
   phone: 081234567890
   address: Jakarta
   created_at: (leave blank)
   updated_at: (leave blank)
   ```
5. Click **"Go"** / **"Insert"**

✅ Admin user created!

Add regular user too:
1. Click **"Insert"** again
2. Fill:
   ```
   name: User
   email: user@topup.local
   password: user123
   role: customer
   phone: 081234567891
   address: Bandung
   ```
3. Click **"Go"**

✅ Now you have both admin and user accounts!

---

### ⏳ Step 8: Verify .env Configuration

Check: `backend-api/.env`

Should look like:
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=topup_platform
JWT_SECRET=mySuperSecretKey123456789
PORT=5001
FRONTEND_URL=http://localhost:3000
NODE_ENV=development
```

If anything missing, update it manually.

---

### ⏳ Step 9: Start Backend API

Open **new terminal**:

```powershell
cd "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\backend-api"
npm install
npm start
```

Wait for:
```
✅ ARDHISTORE API SERVER
✅ Server is running on port 5001
✅ Database connected successfully
```

✅ Backend is ready!

---

### ✅ Step 10: Test Complete System

Open browser and test:

**1. Web Store (Home)**
```
http://localhost:3000
```
✅ Should see products (from database)

**2. Admin Login**
```
http://localhost:3000/login
Email: admin@topup.local
Password: admin123
```
✅ Should redirect to /admin/dashboard

**3. Add New Product**
```
Go to: http://localhost:3000/admin/products
Click: "Tambah Produk"
Fill: Name, Category, Price, Stock
Click: "Simpan"
```
✅ Product should appear in list

**4. Check Database**
```
http://localhost/phpmyadmin
Click: database > products table
```
✅ New product should appear in table!

---

## 📱 ALL INTERFACES AVAILABLE

| Interface | URL | What For |
|-----------|-----|----------|
| 🏪 Web Store | http://localhost:3000 | User shopping |
| 📦 Products | http://localhost:3000/admin/products | Manage products |
| 📊 Dashboard | http://localhost:3000/admin/dashboard | Stats & analytics |
| 👥 Users | http://localhost:3000/admin/users | Manage users |
| 📋 Orders | http://localhost:3000/admin/orders | View orders |
| 🎁 Promos | http://localhost:3000/admin/promos | Manage promos |
| 🗄️ Database | http://localhost/phpmyadmin | Manage MySQL data |
| 🔌 API | http://localhost:5001/api/* | Backend endpoints |

---

## 🎯 TEST CHECKLIST

After complete setup, verify:

- [ ] Frontend accessible at http://localhost:3000
- [ ] phpMyAdmin accessible at http://localhost/phpmyadmin
- [ ] Can login with admin@topup.local / admin123
- [ ] Can add product via admin panel
- [ ] Product appears in database (phpMyAdmin)
- [ ] Product appears on store home page
- [ ] Can edit product
- [ ] Can delete product
- [ ] Backend API running on port 5001
- [ ] All 3 components working together

---

## 🛠️ TROUBLESHOOTING

### "Cannot connect to MySQL"
```
✓ Check: MySQL is running in XAMPP Control Panel
✓ Check: Port 3306 not blocked
✓ Check: .env has correct credentials
✓ Restart XAMPP and try again
```

### "phpMyAdmin shows error"
```
✓ Check: Apache is running in XAMPP
✓ Check: URL is http://localhost/phpmyadmin (not https)
✓ Clear browser cache: Ctrl+Shift+Delete
✓ Try incognito window
```

### "Products not showing in store"
```
✓ Check: Backend is running (port 5001)
✓ Check: Database has products (phpMyAdmin)
✓ Check: Browser console (F12) for errors
✓ Refresh page (Ctrl+F5)
```

### "Can't login"
```
✓ Check: User exists in database (phpMyAdmin > users table)
✓ Check: Email and password exact match
✓ Check: Browser console for error messages
✓ Try demo: admin@topup.local / admin123
```

---

## 📚 RELATED DOCUMENTS

- `QUICK_START.md` - 5-minute quick reference
- `MYSQL_PHPMYADMIN_SETUP.md` - Detailed database setup
- `WINDOWS_SETUP.md` - Windows-specific guide
- `SETUP_GUIDE.md` - Original comprehensive guide
- `DEPLOYMENT.md` - Production deployment

---

## ✨ SUMMARY

**Ardhistore = Web Platform**
```
Frontend   → Next.js web app (port 3000)
Backend    → Express API (port 5001)
Database   → MySQL (port 3306)
Database UI→ phpMyAdmin (port 80)
```

**Everything runs on localhost (your computer)**
- No internet needed for development
- Easy to manage via web interfaces
- No APK/mobile app needed
- Pure web-based solution

---

## 🎉 READY TO START?

1. ✅ Frontend already running
2. ⏳ Install XAMPP
3. ⏳ Setup database & phpMyAdmin
4. ⏳ Start backend API
5. ✅ Test everything!

**Need help? Check the guide files in the root directory!**
