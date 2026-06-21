#!/bin/bash

# TopUp Platform - Quick Setup Script
# This script automates the initial setup process

echo "╔═══════════════════════════════════════════╗"
echo "║  🚀 TopUp Platform Setup Script           ║"
echo "║  Version: 1.0.0                           ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check prerequisites
echo -e "${BLUE}[1/8]${NC} Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗ Node.js not found${NC}"
    echo "Please install Node.js v16+ from https://nodejs.org"
    exit 1
fi
NODE_VERSION=$(node -v)
echo -e "${GREEN}✓ Node.js ${NODE_VERSION}${NC}"

# Check npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}✗ npm not found${NC}"
    exit 1
fi
NPM_VERSION=$(npm -v)
echo -e "${GREEN}✓ npm ${NPM_VERSION}${NC}"

# Check MySQL
if ! command -v mysql &> /dev/null; then
    echo -e "${RED}✗ MySQL not found${NC}"
    echo "Please install MySQL from https://www.mysql.com"
    exit 1
fi
MYSQL_VERSION=$(mysql --version)
echo -e "${GREEN}✓ ${MYSQL_VERSION}${NC}"
echo ""

# Database setup
echo -e "${BLUE}[2/8]${NC} Setting up database..."

read -p "Enter MySQL root password: " -s MYSQL_PASSWORD
echo ""

# Create database
mysql -u root -p"$MYSQL_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS topup_platform;"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Database created${NC}"
else
    echo -e "${RED}✗ Failed to create database${NC}"
    exit 1
fi

# Import schema
mysql -u root -p"$MYSQL_PASSWORD" topup_platform < database/schema.sql
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Schema imported${NC}"
else
    echo -e "${RED}✗ Failed to import schema${NC}"
    exit 1
fi
echo ""

# Backend setup
echo -e "${BLUE}[3/8]${NC} Setting up Backend API..."

cd backend-api

# Check if .env exists
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env
    
    # Update database password in .env (basic replacement)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s|DB_PASSWORD=|DB_PASSWORD=$MYSQL_PASSWORD|g" .env
    else
        sed -i "s|DB_PASSWORD=|DB_PASSWORD=$MYSQL_PASSWORD|g" .env
    fi
    
    echo -e "${GREEN}✓ .env file created${NC}"
    echo "⚠️  Please edit .env and update other settings if needed"
else
    echo -e "${YELLOW}✓ .env already exists${NC}"
fi

# Install dependencies
echo "Installing dependencies..."
npm install --silent
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Backend dependencies installed${NC}"
else
    echo -e "${RED}✗ Failed to install backend dependencies${NC}"
    exit 1
fi
echo ""

# Frontend setup
echo -e "${BLUE}[4/8]${NC} Setting up Frontend Store..."

cd ../frontend-store

# Create .env.local
if [ ! -f .env.local ]; then
    echo "NEXT_PUBLIC_API_URL=http://localhost:5000" > .env.local
    echo -e "${GREEN}✓ .env.local created${NC}"
else
    echo -e "${YELLOW}✓ .env.local already exists${NC}"
fi

# Install dependencies
echo "Installing dependencies..."
npm install --silent
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Frontend dependencies installed${NC}"
else
    echo -e "${RED}✗ Failed to install frontend dependencies${NC}"
    exit 1
fi
echo ""

# Summary
echo -e "${BLUE}[5/8]${NC} Setup Complete! ✓"
echo ""
echo -e "${GREEN}═══════════════════════════════════════════${NC}"
echo -e "${GREEN}  🎉 Installation Successful!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════${NC}"
echo ""
echo "Next steps:"
echo ""
echo "1. Start Backend (Terminal 1):"
echo -e "   ${YELLOW}cd backend-api && npm run dev${NC}"
echo ""
echo "2. Start Frontend (Terminal 2):"
echo -e "   ${YELLOW}cd frontend-store && npm run dev${NC}"
echo ""
echo "3. Open in Browser:"
echo -e "   ${YELLOW}http://localhost:3000${NC}"
echo ""
echo "Demo Account:"
echo -e "   Email: ${YELLOW}admin@topup.local${NC}"
echo ""
echo "Documentation:"
echo -e "   Setup Guide: ${YELLOW}SETUP.md${NC}"
echo -e "   Full Docs:   ${YELLOW}README.md${NC}"
echo -e "   Deployment:  ${YELLOW}DEPLOYMENT.md${NC}"
echo ""
echo "Need help? Check the documentation files above!"
echo ""
