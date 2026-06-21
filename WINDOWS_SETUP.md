# Ardhistore - Windows Setup Instructions

## 📋 Pre-requisites
- Node.js & npm (sudah terinstall)
- MySQL (opsional, untuk database)
- Browser modern (Chrome, Firefox, Edge)

---

## 🚀 QUICK START (5 Menit)

### Step 1: Jalankan Frontend
```powershell
cd "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\frontend-store"
npm run dev
```
✅ Frontend akan jalan di: `http://localhost:3000`

### Step 2: Akses Web
Buka browser dan pergi ke:
- **Home**: http://localhost:3000
- **Admin Panel**: http://localhost:3000/admin/products
- **Login**: http://localhost:3000/login

### Step 3: Create Admin Account
1. Go to: http://localhost:3000/register
2. Daftar dengan email: `admin@topup.local`
3. Password: sesuka Anda
4. Login dan akses admin panel

---

## ✨ Fitur yang Sudah Bisa Digunakan

✅ **Home Page** - Lihat produk
✅ **Admin Dashboard** - Statistik
✅ **Manajemen Produk**:
   - ➕ Tambah produk baru
   - ✏️ Edit produk
   - 🗑️ Hapus produk
   - 🔍 Cari produk
✅ **User Management** - Kelola user
✅ **Orders Tracking** - Lihat pesanan

---

## 🎯 Test Admin Panel

1. **Login**: http://localhost:3000/admin/products
2. **Tambah Produk**:
   - Klik "Tambah Produk"
   - Isi data:
     - Nama: `Game Top Up A`
     - Kategori: `Gaming`
     - Harga: `50000`
     - Stok: `100`
   - Klik "Simpan"
3. ✅ Produk berhasil ditambahkan!

---

## 📡 Backend API Setup (Opsional)

Untuk fitur pembayaran & checkout:

### Option 1: Skip Backend
- Frontend admin panel sudah fully functional
- Bisa test fitur dulu, backend setup nanti

### Option 2: Setup Backend dengan Mock Data

Buka terminal baru:
```powershell
cd "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\backend-api"
npm start
```

**Note**: Backend akan fail kalau MySQL tidak ada. Tapi frontend admin panel tetap jalan!

### Option 3: Setup MySQL

1. **Install MySQL**: https://dev.mysql.com/downloads/mysql/
2. **Create Database**:
   ```
   mysql -u root -p
   CREATE DATABASE topup_platform;
   USE topup_platform;
   SOURCE C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\database\schema.sql;
   ```
3. **Start Backend**:
   ```powershell
   cd backend-api
   npm start
   ```
4. **Insert Admin Account**:
   ```sql
   INSERT INTO users (name, email, password, role) 
   VALUES ('Admin', 'admin@topup.local', 'securepassword123', 'admin');
   ```

---

## 🔗 URLs

| Halaman | URL | Status |
|---------|-----|--------|
| Home | http://localhost:3000 | ✅ |
| Login | http://localhost:3000/login | ✅ |
| Register | http://localhost:3000/register | ✅ |
| Admin Dashboard | http://localhost:3000/admin/dashboard | ✅ |
| Products | http://localhost:3000/admin/products | ✅ |
| Orders | http://localhost:3000/admin/orders | ✅ |
| Users | http://localhost:3000/admin/users | ✅ |
| Account | http://localhost:3000/account | ✅ |
| Checkout | http://localhost:3000/checkout/[id] | ⚠️ Needs Backend |

---

## 🛠️ Troubleshooting

### Port 3000 sudah dipakai?
```powershell
netstat -ano | findstr :3000
taskkill /PID [PID] /F
```

### Clear cache
- Press: `Ctrl + Shift + Delete` di browser
- Atau gunakan incognito mode

### Reset aplikasi
```powershell
# Clear Next.js cache
rm -r "C:\Users\Hype GLK\OneDrive\Desktop\topup-platform\frontend-store\.next"

# Clear npm cache
npm cache clean --force

# Reinstall
npm install
npm run dev
```

---

## 📚 Project Structure

```
topup-platform/
├── frontend-store/          ← Next.js App (Port 3000) ✅
│   ├── app/
│   │   ├── admin/          ← Admin Panel
│   │   ├── login/          ← Login Page
│   │   └── register/       ← Register Page
│   └── public/
├── backend-api/            ← Express API (Port 5001)
│   ├── src/
│   │   ├── routes/
│   │   ├── middleware/
│   │   └── database/
│   └── .env
└── database/               ← Database Schema
    └── schema.sql
```

---

## 🚀 Deployment

Untuk production:
1. Build frontend: `npm run build`
2. Start production: `npm start`
3. Setup MySQL di production server
4. Update .env dengan production URLs

---

## 📞 Support

Jika ada masalah:
1. Check browser console: `F12`
2. Check terminal output
3. Read error message carefully
4. Check logs di AppData: `C:\Users\Hype GLK\AppData\Local\npm-cache\_logs\`

---

## ✅ Checklist

- [ ] Frontend running di port 3000
- [ ] Bisa akses home page
- [ ] Bisa register akun baru
- [ ] Bisa login
- [ ] Bisa akses admin dashboard
- [ ] Bisa tambah produk di admin panel
- [ ] Bisa edit produk
- [ ] Bisa hapus produk

Selamat menggunakan Ardhistore Platform! 🎉
