# 🗄️ MySQL + phpMyAdmin Setup untuk Ardhistore

**Tujuan**: Setup database dengan interface web yang mudah digunakan

---

## 📋 Prerequisites

- MySQL Server (belum ada → install dulu)
- phpMyAdmin (included di paket XAMPP/WAMP/MAMP)
- atau bisa install terpisah

---

## ✅ CARA PALING MUDAH: Pakai XAMPP

### Step 1: Download & Install XAMPP

1. Go to: https://www.apachefriends.org/
2. Download **XAMPP for Windows**
3. Install di `C:\xampp` (recommended)
4. Pilih komponen:
   - ✅ Apache
   - ✅ MySQL
   - ✅ PHP
   - ✅ phpMyAdmin

### Step 2: Start XAMPP

1. Buka **XAMPP Control Panel**
2. Klik **Start** untuk:
   - ✅ Apache (port 80)
   - ✅ MySQL (port 3306)

Output akan seperti:
```
Apache: Running on port 80
MySQL:  Running on port 3306
```

### Step 3: Akses phpMyAdmin

Buka browser:
```
http://localhost/phpmyadmin
```

Login dengan:
- **Username**: root
- **Password**: (kosong - enter)

✅ Selamat! phpMyAdmin sudah bisa diakses

---

## 🗂️ Setup Database via phpMyAdmin

### Langkah 1: Create Database

1. Di phpMyAdmin, klik tab **"Databases"**
2. Di bagian "Create new database", ketik: `topup_platform`
3. Pilih Collation: **utf8mb4_general_ci**
4. Klik **"Create"**

### Langkah 2: Import Schema

1. Klik database **topup_platform**
2. Klik tab **"Import"**
3. Klik **"Choose File"**, pilih: `database/schema.sql`
4. Klik **"Import"**

✅ Tabel sudah dibuat!

### Langkah 3: Verify Tables

Di phpMyAdmin, klik database **topup_platform**:
- ✅ users
- ✅ products
- ✅ categories
- ✅ orders
- ✅ order_items
- ✅ payments
- ✅ transactions
- ✅ promos

Semua tabel harus terlihat di sidebar

---

## 👤 Create Admin Account

1. Di phpMyAdmin, klik table **"users"**
2. Klik tab **"Insert"**
3. Isi form:
   ```
   id: 1 (auto)
   name: Admin
   email: admin@topup.local
   password: admin123 (akan di-hash nanti)
   role: admin
   phone: 081234567890 (opsional)
   address: Jakarta (opsional)
   created_at: (auto)
   updated_at: (auto)
   ```
4. Klik **"Go"**

### Atau via SQL Query:

1. Di phpMyAdmin, klik tab **"SQL"**
2. Copy & paste:
   ```sql
   INSERT INTO users (name, email, password, role, phone, address) 
   VALUES ('Admin', 'admin@topup.local', 'admin123', 'admin', '081234567890', 'Jakarta');
   
   INSERT INTO users (name, email, password, role, phone, address) 
   VALUES ('User', 'user@topup.local', 'user123', 'customer', '081234567891', 'Bandung');
   ```
3. Klik **"Go"**

---

## 📋 Insert Sample Data (Opsional)

Untuk testing, bisa insert sample products:

```sql
-- Insert Categories
INSERT INTO categories (name, description, icon) VALUES 
('Gaming', 'Top up game online', '🎮'),
('Streaming', 'Top up streaming services', '📺'),
('Design', 'Design tools & software', '🎨'),
('Entertainment', 'Entertainment & music', '🎵');

-- Insert Sample Products
INSERT INTO products (name, category_id, price, stock, image_url, description) VALUES 
('Mobile Legends 50K', 1, 50000, 100, 'https://via.placeholder.com/150', 'Top up ML 50000 diamond'),
('PUBG UC 60K', 1, 60000, 100, 'https://via.placeholder.com/150', 'Top up PUBG 60000 UC'),
('Spotify Premium 1 Bulan', 2, 49000, 50, 'https://via.placeholder.com/150', 'Spotify Premium 1 bulan'),
('Adobe Creative Cloud', 3, 250000, 20, 'https://via.placeholder.com/150', 'Adobe CC subscription');

-- Insert Promo
INSERT INTO promos (code, description, discount_type, discount_value, usage_limit) VALUES 
('WELCOME10', 'Welcome discount 10%', 'percentage', 10, 100),
('NEWUSER50K', 'New user discount 50k', 'fixed', 50000, 50);
```

Jalankan di phpMyAdmin **SQL tab**

---

## 🚀 Start Backend API

Sekarang MySQL sudah siap. Jalankan backend:

### Terminal 1: Start MySQL & Apache (dari XAMPP)
```
✅ Sudah running dari XAMPP Control Panel
```

### Terminal 2: Start Backend API
```powershell
cd "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\backend-api"
npm install
npm start
```

Expected output:
```
ARDHISTORE API SERVER
Server is running on port 5001
Database connected successfully
```

### Terminal 3: Start Frontend Store
```powershell
cd "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\frontend-store"
npm run dev
```

Expected output:
```
✓ Ready in X.Xs
- Local: http://localhost:3000
```

---

## 🎯 Akses Semua Interface

| Interface | URL | Kegunaan |
|-----------|-----|----------|
| 🏪 Web Store | http://localhost:3000 | User interface |
| 🔐 Admin Login | http://localhost:3000/login | Admin authentication |
| 📦 Product Mgmt | http://localhost:3000/admin/products | Manage products |
| 📊 Dashboard | http://localhost:3000/admin/dashboard | Admin dashboard |
| 🗄️ Database | http://localhost/phpmyadmin | Manage database |
| 🔌 API | http://localhost:5001 | Backend API |

---

## 💡 Workflow Diagram

```
Browser (Port 80)
    ↓
Apache (XAMPP)
    ├─→ http://localhost/phpmyadmin (Database UI)
    └─→ PHP files (jika ada)

Browser (Port 3000)
    ↓
Next.js Frontend
    ├─→ UI untuk user
    ├─→ Admin panel
    └─→ API calls

Express Backend (Port 5001)
    ↓
MySQL (Port 3306)
    ↓
Database (topup_platform)
```

---

## ✅ CHECKLIST SETUP

- [ ] XAMPP installed
- [ ] Apache started (via XAMPP)
- [ ] MySQL started (via XAMPP)
- [ ] phpMyAdmin accessible at http://localhost/phpmyadmin
- [ ] Database `topup_platform` created
- [ ] Schema imported (tables created)
- [ ] Admin user inserted (admin@topup.local)
- [ ] Sample data inserted (opsional)
- [ ] Backend npm install completed
- [ ] Backend running on port 5001
- [ ] Frontend running on port 3000
- [ ] Can login with admin@topup.local / admin123

---

## 🔧 Troubleshooting

### Port 3306 already in use?
```powershell
netstat -ano | findstr :3306
taskkill /PID [PID] /F
```

### MySQL won't start?
1. Check: Services → MySQL80 (running?)
2. Restart XAMPP Control Panel
3. Restart computer jika perlu

### phpMyAdmin shows error?
1. Check MySQL status di XAMPP
2. Refresh browser (Ctrl + F5)
3. Clear browser cache

### Database not imported?
1. Check `database/schema.sql` exists
2. Verify collation: utf8mb4_general_ci
3. Check error messages di phpMyAdmin

### Backend can't connect to MySQL?
1. Verify MySQL is running
2. Check .env: DB_HOST=localhost, DB_USER=root
3. Check DB_PASSWORD (kosong jika default)
4. Check port 3306 not blocked

---

## 📱 Testing Workflow

1. **Setup**: XAMPP → Database → Backend → Frontend
2. **Login**: http://localhost:3000/login
   - Email: admin@topup.local
   - Password: admin123
3. **Add Product**: /admin/products → "Tambah Produk"
4. **Check Database**: http://localhost/phpmyadmin
   - products table akan bertambah
5. **View on Frontend**: http://localhost:3000 → products muncul

---

## 🎉 Selesai!

Ardhistore sudah siap dengan:
✅ Web Store
✅ Admin Panel
✅ MySQL Database
✅ phpMyAdmin UI
✅ Full backend API

Semua bisa diakses via browser tanpa perlu command line!
