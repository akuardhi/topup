# TopUp Platform - Complete Installation & Deployment Guide

## 📋 System Requirements

- **Node.js**: v16 or higher
- **MySQL**: v5.7 or higher
- **Git**: for version control
- **RAM**: 2GB minimum
- **Storage**: 5GB minimum

---

## 🚀 Quick Start (5 minutes)

### 1. Database Setup

```bash
# Access MySQL
mysql -u root -p

# Run the schema
source /path/to/database/schema.sql
```

### 2. Backend Setup

```bash
cd backend-api

# Copy environment
cp .env.example .env

# Edit .env with your settings
nano .env

# Install dependencies
npm install

# Start development server
npm run dev
```

Server will run on `http://localhost:5000`

### 3. Frontend Store Setup

```bash
cd frontend-store

# Install dependencies
npm install

# Start development
npm run dev
```

Store will run on `http://localhost:3000`

---

## 📦 Complete Installation Guide

### Step 1: Clone Repository

```bash
git clone <repository-url>
cd topup-platform
```

### Step 2: Database Configuration

#### Option A: Using MySQL CLI

```bash
# Connect to MySQL
mysql -u root -p

# Create database
CREATE DATABASE topup_platform;
USE topup_platform;

# Import schema
source database/schema.sql;

# Verify tables
SHOW TABLES;
```

#### Option B: Using MySQL Workbench

1. Open MySQL Workbench
2. Create new connection to localhost
3. Execute SQL script from `database/schema.sql`

### Step 3: Backend Configuration

```bash
cd backend-api

# Copy example environment file
cp .env.example .env

# Edit configuration
nano .env
```

**Required .env Configuration:**

```env
# Database
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=topup_platform

# Server
PORT=5000
NODE_ENV=development

# JWT Secret (change this in production!)
JWT_SECRET=your_super_secret_jwt_key_change_in_production

# Midtrans (get from https://dashboard.midtrans.com)
MIDTRANS_SERVER_KEY=your_server_key
MIDTRANS_CLIENT_KEY=your_client_key
MIDTRANS_ENV=sandbox

# Frontend URLs
FRONTEND_URL=http://localhost:3000
ADMIN_URL=http://localhost:3001
```

**Install Dependencies:**

```bash
npm install

# For development with auto-reload
npm install -g nodemon
```

**Start Backend:**

```bash
# Development
npm run dev

# Production
npm start
```

Expected output:
```
╔═══════════════════════════════════════════╗
║  🚀 TOPUP PLATFORM API SERVER             ║
║  PORT: 5000                               ║
║  Environment: development                 ║
║  Database: localhost:topup_platform       ║
╚═══════════════════════════════════════════╝
```

### Step 4: Frontend Store Setup

```bash
cd frontend-store

# Install dependencies
npm install

# Create environment file
cp .env.example .env.local

# Edit configuration
nano .env.local
```

**Configure .env.local:**

```env
NEXT_PUBLIC_API_URL=http://localhost:5000
```

**Start Development Server:**

```bash
npm run dev
```

Access at: `http://localhost:3000`

---

## 🛠️ API Endpoints Overview

### Authentication
```
POST   /api/auth/register      - Register new user
POST   /api/auth/login         - User login
GET    /api/auth/me            - Get current user
```

### Products
```
GET    /api/products           - Get all products
GET    /api/products/:id       - Get product detail
POST   /api/products           - Create product (admin)
PUT    /api/products/:id       - Update product (admin)
DELETE /api/products/:id       - Delete product (admin)
```

### Orders
```
GET    /api/orders             - Get user orders
GET    /api/orders/:id         - Get order detail
POST   /api/orders             - Create order
PUT    /api/orders/:id         - Update order (admin)
GET    /api/orders/admin/all   - Get all orders (admin)
```

### Payments
```
GET    /api/payments           - Get payment methods
POST   /api/payments           - Create payment method (admin)
PUT    /api/payments/:id       - Update payment method (admin)
DELETE /api/payments/:id       - Delete payment method (admin)
```

### Statistics (Admin)
```
GET    /api/stats/dashboard    - Dashboard statistics
GET    /api/stats/revenue      - Revenue statistics
GET    /api/stats/orders       - Order statistics
GET    /api/stats/products     - Product statistics
```

### Users (Admin)
```
GET    /api/users              - Get all users
GET    /api/users/:id          - Get user detail with stats
PUT    /api/users/:id          - Update user
DELETE /api/users/:id          - Delete user
```

### Promo Codes
```
GET    /api/promo              - Get active promo codes
POST   /api/promo/validate     - Validate promo code
POST   /api/promo              - Create promo (admin)
GET    /api/promo/admin/all    - Get all promos (admin)
PUT    /api/promo/:id          - Update promo (admin)
DELETE /api/promo/:id          - Delete promo (admin)
```

---

## 🔐 Authentication

### Login & Get Token

```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@topup.local",
    "password": "password"
  }'
```

### Use Token in Requests

```bash
curl -X GET http://localhost:5000/api/orders \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

**Demo Admin Account:**
- Email: `admin@topup.local`
- Password: (default from schema)

---

## 📱 Frontend Features

### Homepage
- Product catalog with categories
- Search and filter
- Product cards with ratings
- Direct purchase links

### Product Detail
- Full product information
- Dynamic form fields based on product type
- Stock availability
- Add to checkout

### Checkout
- Order summary
- Payment method selection
- User data collection
- Order confirmation

### User Account
- Profile information
- Order history
- Order status tracking
- Logout

### Admin Dashboard (Separate)
- Dashboard with statistics
- Orders management
- Products management
- Users management
- Payment methods
- Promo codes
- Statistics & charts

---

## 🐳 Docker Deployment

### Create Dockerfile (Backend)

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
```

### Create docker-compose.yml

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: topup_platform
    ports:
      - "3306:3306"
    volumes:
      - ./database/schema.sql:/docker-entrypoint-initdb.d/schema.sql

  api:
    build: ./backend-api
    ports:
      - "5000:5000"
    environment:
      DB_HOST: mysql
      DB_USER: root
      DB_PASSWORD: root
      DB_NAME: topup_platform
      JWT_SECRET: your_secret_key
    depends_on:
      - mysql
    command: npm start

  frontend:
    build: ./frontend-store
    ports:
      - "3000:3000"
    environment:
      NEXT_PUBLIC_API_URL: http://localhost:5000
```

### Run with Docker

```bash
# Build and start
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

---

## 🚀 VPS Deployment (Ubuntu/Debian)

### 1. Install Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### 2. Install MySQL

```bash
sudo apt-get install -y mysql-server
sudo mysql_secure_installation
```

### 3. Clone Application

```bash
cd /var/www
git clone <repository-url> topup-platform
cd topup-platform
```

### 4. Setup Database

```bash
mysql -u root -p < database/schema.sql
```

### 5. Install PM2 (Process Manager)

```bash
sudo npm install -g pm2
```

### 6. Setup Backend

```bash
cd backend-api
npm install

# Create ecosystem.config.js
cat > ecosystem.config.js << 'EOF'
module.exports = {
  apps: [{
    name: 'topup-api',
    script: './src/server.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production',
      PORT: 5000
    }
  }]
};
EOF

# Start with PM2
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

### 7. Setup Frontend

```bash
cd ../frontend-store
npm install
npm run build

# Start with PM2
pm2 start "npm run start" --name "topup-frontend"
pm2 save
```

### 8. Setup Nginx Reverse Proxy

```bash
sudo apt-get install -y nginx

# Create nginx config
sudo nano /etc/nginx/sites-available/topup-platform
```

**Nginx Configuration:**

```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    # Frontend
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # API
    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

**Enable and Start:**

```bash
sudo ln -s /etc/nginx/sites-available/topup-platform /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### 9. Setup SSL (Let's Encrypt)

```bash
sudo apt-get install -y certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```

---

## 🔐 Security Checklist

- [ ] Change JWT_SECRET in production
- [ ] Set strong database password
- [ ] Enable HTTPS/SSL
- [ ] Configure CORS properly
- [ ] Setup rate limiting
- [ ] Enable input validation
- [ ] Regular backups of database
- [ ] Monitor logs regularly
- [ ] Use environment variables
- [ ] Restrict API access

---

## 📊 Database Backup

### Backup

```bash
mysqldump -u root -p topup_platform > backup_$(date +%Y%m%d).sql
```

### Restore

```bash
mysql -u root -p topup_platform < backup_20240316.sql
```

---

## 🐛 Troubleshooting

### MySQL Connection Error

```bash
# Check MySQL is running
sudo service mysql status

# Restart MySQL
sudo service mysql restart

# Verify credentials
mysql -u root -p
```

### Port Already in Use

```bash
# Find process using port
lsof -i :5000
lsof -i :3000

# Kill process
kill -9 <PID>
```

### API Not Responding

```bash
# Check logs
npm run dev  # to see errors directly

# Check database connection
mysql -u root -p -h localhost -e "SELECT 1"
```

### CORS Issues

Update `backend-api/src/server.js`:

```javascript
app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true
}))
```

---

## 📈 Performance Optimization

1. **Database Indexing**: Already configured in schema
2. **Image Optimization**: Use Next.js Image component
3. **API Caching**: Implement Redis for frequent queries
4. **CDN**: Use CDN for static assets
5. **Database Pooling**: Already configured in pool.js
6. **Compression**: Enable gzip in nginx

---

## 📞 Support & Documentation

- **API Documentation**: http://localhost:5000/health
- **GitHub Issues**: Report bugs and issues
- **Email Support**: support@topup-platform.com

---

## 📝 License

This project is proprietary and confidential.

---

**Last Updated**: March 16, 2024
