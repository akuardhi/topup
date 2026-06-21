# Midtrans Payment Gateway Integration Guide

## Overview

Midtrans is an Indonesian payment gateway that supports:
- ✅ QRIS (QR Code Indonesia Standard)
- ✅ GoPay
- ✅ Bank Transfer
- ✅ Credit Card (coming soon)

**Status**: ✅ **FULLY INTEGRATED** - Payment processing is now live in checkout!

---

## Step 1: Create Midtrans Account

1. Visit [https://midtrans.com](https://midtrans.com)
2. Click "Sign Up" → "Sign Up as Business"
3. Fill in your business details
4. Verify your email
5. Complete KYC process

---

## Step 2: Get API Keys

1. Login to [Midtrans Dashboard](https://dashboard.midtrans.com)
2. Go to Settings → Access Keys
3. Copy your:
   - **Server Key** (for backend)
   - **Client Key** (for frontend)

---

## Step 3: Configure Backend

Update `backend-api/.env`:

```env
MIDTRANS_SERVER_KEY=your_server_key_here
MIDTRANS_CLIENT_KEY=your_client_key_here
```

---

## Step 4: Configure Frontend

Update `frontend-store/.env.local`:

```env
NEXT_PUBLIC_API_URL=http://localhost:5000
NEXT_PUBLIC_MIDTRANS_CLIENT_KEY=your_client_key_here
```

---

## Step 5: Install Midtrans Package (Backend)

```bash
cd backend-api
npm install midtrans-client
```

---

## How It Works

### 1. **User Checkout Flow**
```
Customer selects payment method
    ↓
Frontend sends order creation request
    ↓
Backend creates order & generates Snap token
    ↓
Frontend loads Midtrans Snap payment UI
    ↓
Customer completes payment
    ↓
Backend webhook updates order status
    ↓
Customer sees payment confirmation
```

### 2. **API Endpoints**

#### Create Snap Token
```
POST /api/midtrans/create-snap-token
Headers: Authorization: Bearer {token}
Body: {
  orderId: "ORDER123",
  amount: 50000,
  email: "customer@email.com",
  name: "John Doe",
  phone: "08123456789"
}
Response: {
  snap_token: "token_string",
  snap_redirect_url: "https://..."
}
```

#### Verify Payment
```
POST /api/midtrans/verify-payment
Body: {
  orderId: "ORDER123"
}
Response: {
  transaction_status: "capture|settlement|pending|deny",
  payment_type: "qris|gopay|bank_transfer"
}
```

#### Webhook Handler
```
POST /api/midtrans/webhook
(Midtrans calls this automatically)
- Updates order status when payment received
- Marks order as "paid" when settled
- Cancels order if payment denied/expired
```

---

## Testing in Sandbox

### Sandbox Payment Credentials

**QRIS (QR Code)**
- Scan the QR code shown on screen
- Use test account on GCash/JPay app (if available)

**GoPay**
- Phone: +62 (any Indonesian number)
- OTP will auto-verify in sandbox

**Bank Transfer**
- Use test bank account details:
  - Bank: BCA Virtual Account
  - Account: Auto-generated for each transaction

### Test Card (Credit Card)
- Number: 4111 1111 1111 1111
- Exp: 12/25
- CVV: 123

---

## Production Checklist

Before going live:

- [ ] Change `MIDTRANS_ENV=sandbox` to `MIDTRANS_ENV=production`
- [ ] Update API keys to production keys
- [ ] Update frontend .env.local with production client key
- [ ] Test with real payment methods
- [ ] Set up email notifications for order confirmation
- [ ] Configure webhook URL in Midtrans dashboard
- [ ] Test order status updates via webhook
- [ ] Enable 3D Secure for credit cards
- [ ] Set up payment success/error pages
- [ ] Configure order expiration for unpaid orders

---

## Webhook Setup (Dashboard)

1. Go to Midtrans Dashboard → Settings → Webhooks
2. Set Notification URL to:
   ```
   https://your-api-domain.com/api/midtrans/webhook
   ```
3. Enable notifications for:
   - Payment Success
   - Payment Pending
   - Payment Failed
   - Payment Expired

---

## Error Handling

The checkout page handles these scenarios:

- **Payment Success**: Order marked as "paid", customer redirected to account page
- **Payment Pending**: User informed payment is being processed
- **Payment Failed**: Error message shown, order remains "pending"
- **Payment Cancelled**: User can retry payment

---

## Debugging

Check browser console (F12) for payment-related logs:

```javascript
// View payment status
fetch('http://localhost:5000/api/midtrans/verify-payment', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ orderId: 'ORDER123' })
})
.then(r => r.json())
.then(console.log)
```

---

## Revenue Tracking

All payments are tracked in:
- **Orders table**: `order_number`, `price`, `status`, `payment_method`
- **Transactions table**: `transaction_id`, `gateway_response`, `transaction_status`
- **Admin Dashboard**: Revenue charts updated in real-time

---

## Support

For Midtrans API documentation:
https://docs.midtrans.com

For integration support:
- Dashboard: https://dashboard.midtrans.com
- Email: support@midtrans.com
- Docs: https://docs.midtrans.com
      token: transaction.token,
      redirect_url: transaction.redirect_url
    })
  } catch (error) {
    console.error('Transaction error:', error)
    res.status(500).json({ error: 'Failed to create transaction' })
  }
})

// Handle payment callback/webhook
router.post('/callback', async (req, res) => {
  try {
    const result = req.body

    // Verify signature
    const orderId = result.order_id
    const transactionStatus = result.transaction_status

    console.log(`Transaction status: ${transactionStatus}`)

    // Update order status based on payment status
    if (transactionStatus === 'capture' || transactionStatus === 'settlement') {
      // Payment successful
      await pool.query('UPDATE orders SET status = ? WHERE id = ?', 
        ['paid', orderId.split('-')[0]])
    } else if (transactionStatus === 'pending') {
      // Payment pending
      await pool.query('UPDATE orders SET status = ? WHERE id = ?', 
        ['pending', orderId.split('-')[0]])
    } else if (transactionStatus === 'deny' || transactionStatus === 'expire' || transactionStatus === 'cancel') {
      // Payment failed
      await pool.query('UPDATE orders SET status = ? WHERE id = ?', 
        ['cancelled', orderId.split('-')[0]])
    }

    res.json({ status: 'ok' })
  } catch (error) {
    console.error('Webhook error:', error)
    res.status(500).json({ error: 'Webhook failed' })
  }
})

module.exports = router
```

---

## Step 5: Update Server

Add to `backend-api/src/server.js`:

```javascript
const transactionRoutes = require('./routes/transactions')

app.use('/api/transactions', transactionRoutes)
```

---

## Step 6: Update Checkout Frontend

Update `frontend-store/app/checkout/[id]/page.tsx`:

```typescript
import { useEffect, useState } from 'react'

export default function Checkout() {
  const [snapToken, setSnapToken] = useState('')
  const [loading, setLoading] = useState(false)

  const handlePayment = async () => {
    setLoading(true)
    try {
      const response = await fetch('http://localhost:5000/api/transactions/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          order_id: order.id,
          amount: order.price,
          customer_name: user.name,
          customer_email: user.email
        })
      })

      const data = await response.json()
      setSnapToken(data.token)

      // Show Midtrans Snap popup
      if (window.snap) {
        window.snap.pay(data.token, {
          onSuccess: (result) => {
            // Handle success
            alert('✅ Pembayaran berhasil!')
            router.push('/')
          },
          onPending: (result) => {
            // Handle pending
            alert('⏳ Pembayaran menunggu verifikasi')
          },
          onError: (result) => {
            // Handle error
            alert('❌ Pembayaran gagal')
          }
        })
      }
    } catch (error) {
      alert('Error: ' + error.message)
    } finally {
      setLoading(false)
    }
  }

  // Add Midtrans script
  useEffect(() => {
    const script = document.createElement('script')
    script.src = 'https://app.midtrans.com/snap/snap.js'
    script.setAttribute('data-client-key', process.env.NEXT_PUBLIC_MIDTRANS_CLIENT_KEY)
    document.head.appendChild(script)
  }, [])

  return (
    // ... rest of component
  )
}
```

---

## Step 7: Configure Environment

Update `.env.local` in frontend-store:

```env
NEXT_PUBLIC_MIDTRANS_CLIENT_KEY=your_client_key_here
```

---

## Step 8: Setup Midtrans Webhook

1. Go to Midtrans Dashboard → Settings → Notifications
2. Set Webhook URL to:
   ```
   http://yourdomain.com/api/transactions/callback
   ```
3. For testing locally, use [ngrok](https://ngrok.com):
   ```bash
   ngrok http 5000
   # Use the provided URL
   ```

---

## Testing

### Test in Sandbox Mode

1. Make an order
2. Click "Bayar Sekarang"
3. Complete payment with test cards:
   - **Card Number**: 5211 1111 1111 1115
   - **Expiry**: Any future date
   - **CVV**: Any 3 digits

### Payment Status Flows

```
Credit Card → Capture → Settlement (instant)
QRIS        → Settlement (after customer scans)
GoPay       → Settlement (after customer confirms)
Bank        → Settlement (next business day)
```

---

## Production Setup

When going to production:

1. **Update .env:**
   ```env
   MIDTRANS_ENV=production
   NODE_ENV=production
   ```

2. **Update API Keys:**
   - Get production keys from Midtrans Dashboard
   - Update `MIDTRANS_SERVER_KEY` and `MIDTRANS_CLIENT_KEY`

3. **Update Webhooks:**
   - Point to production domain
   - Test thoroughly

4. **Payment Methods:**
   - All payment methods work in production
   - Settlements happen within 1-3 business days

---

## Troubleshooting

### "Snap token not created"

**Solution:**
```bash
# Check your credentials
echo $MIDTRANS_SERVER_KEY
echo $MIDTRANS_CLIENT_KEY

# Verify they match dashboard
# Make sure environment matches (sandbox/production)
```

### "Invalid merchant"

**Solution:**
- Check API keys are correct
- Ensure MIDTRANS_ENV matches key environment (sandbox keys won't work in production)
- Check server key isn't rotated

### Webhook not triggering

**Solution:**
1. Verify webhook URL in dashboard
2. Check server is publicly accessible
3. Use ngrok for testing locally
4. Check server logs for errors

### Payment popup not showing

**Solution:**
```javascript
// Make sure Snap library is loaded
if (typeof snap !== 'undefined') {
  snap.pay(token)
} else {
  console.log('Snap library not loaded')
}
```

---

## Transaction Handling Flow

```
Customer initiates payment
        ↓
Backend creates transaction with Midtrans API
        ↓
Midtrans returns token
        ↓
Frontend shows payment popup (Snap)
        ↓
Customer completes payment
        ↓
Midtrans processes payment
        ↓
Midtrans sends webhook to backend
        ↓
Backend updates order status
        ↓
Frontend shows success/error
```

---

## Settlement Schedule

| Payment Method | Settlement Time |
|---|---|
| QRIS | Instant (D+0) |
| GoPay | Instant (D+0) |
| DANA | Instant (D+0) |
| Debit Card | 1-3 days (D+1-3) |
| Credit Card | 7-30 days |
| Bank Transfer | 1-5 business days |

---

## Documentation References

- [Midtrans Official Docs](https://docs.midtrans.com)
- [Snap Integration Guide](https://docs.midtrans.com/en/snap/snap-introduction)
- [API Reference](https://docs.midtrans.com/en/api-reference)

---

## Security Checklist

- [ ] Server Key never exposed to frontend
- [ ] Client Key used only in frontend
- [ ] Webhook endpoint validates signatures
- [ ] HTTPS enabled in production
- [ ] Rate limiting on webhook endpoint
- [ ] Error messages don't expose sensitive data
- [ ] Payment status verified before fulfilling order

---

## Support

For Midtrans support:
- 📧 Email: support@midtrans.com
- 💬 WhatsApp: +62-851-60000-800
- 📚 Documentation: docs.midtrans.com

---

**Ready to accept payments!** 🎉
