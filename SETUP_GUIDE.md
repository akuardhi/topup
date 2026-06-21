# Ardhistore - Setup Guide

## ✅ Status Sekarang

- **Frontend Store**: ✅ RUNNING di `http://localhost:3000`
- **Backend API**: ❌ Perlu setup (MySQL required)
- **Admin Panel**: ✅ Built-in di frontend

---

## 🚀 Quick Start

### 1. Akses Frontend
```
http://localhost:3000
```

### 2. Login ke Admin Panel
- Go to: `http://localhost:3000/admin/products`
- Email: `admin@topup.local`
- Password: Anda perlu create account via register atau setup database

### 3. Fitur yang Tersedia di Frontend

✅ **Home Page** - Product showcase
✅ **Admin Dashboard** - View stats & orders
✅ **Manajemen Produk** - Add/Edit/Delete products (TANPA API - direct ke browser)
✅ **Admin Orders** - View orders
✅ **Admin Users** - Manage users

---

## 📋 Untuk Backend API (Opsional)

Jika ingin fitur checkout, pembayaran, database:

### Opsi 1: Install MySQL
1. Download MySQL dari https://dev.mysql.com/downloads/mysql/
2. Install dan jalankan MySQL Service
3. Create database:
```sql
mysql -u root -p < database/schema.sql
```
4. Run backend:
```bash
cd backend-api
npm start
```

### Opsi 2: Skip Backend (Recommended untuk sekarang)
- Frontend admin panel sudah bisa dipakai
- Bisa test fitur UI/UX dulu
- Backend bisa setup nanti

---

## 🔧 Setup Database (Jika ingin)

### Dengan MySQL Workbench:
1. Buka MySQL Workbench
2. Create new connection ke localhost
3. Import file: `database/schema.sql`
4. Insert admin account:
```sql
INSERT INTO users (name, email, password, role) 
VALUES ('Admin', 'admin@topup.local', 'admin123', 'admin');
```

### Dengan Command Line:
```bash
mysql -u root -p topup_platform < database/schema.sql
```

---

## 📱 Fitur Admin Panel

| Fitur | Status | Link |
|-------|--------|------|
| Dashboard | ✅ | `/admin/dashboard` |
| Manajemen Produk | ✅ | `/admin/products` |
| Manajemen Orders | ✅ | `/admin/orders` |
| Manajemen Users | ✅ | `/admin/users` |
| Manajemen Promos | ✅ | `/admin/promos` |

---

## 🛠️ Troubleshooting

### Port 3000 sudah digunakan?
- Cari port alternatif: http://localhost:3001
- Atau close aplikasi yang menggunakan port 3000

### Frontend error saat loading?
- Clear browser cache: Ctrl + Shift + Delete
- Atau buka di incognito mode

### Admin panel tidak bisa login?
- Register akun baru dulu di `/register`
- Atau setup database dan insert admin account

---

## 📞 Support

Untuk bantuan lebih lanjut:
1. Check browser console (F12) untuk error
2. Check terminal untuk backend logs
3. Pastikan semua file config sudah benar

---

## 🎯 Next Steps

1. **Test Frontend** - Jelajahi UI dan fitur
2. **Setup Database** (opsional) - Jika perlu persistent data
3. **Setup Backend** (opsional) - Jika perlu checkout & payment

Selamat menggunakan Ardhistore! 🚀
