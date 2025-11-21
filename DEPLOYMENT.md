# 🚀 Free Web Hosting Deployment Guide

Deploy your full-stack Test Portal application on free hosting platforms. Choose one of the recommended options below.

---

## 📊 **Free Hosting Comparison**

| Platform | Backend | Frontend | Storage | Bandwidth | Cold Start |
|----------|---------|----------|---------|-----------|------------|
| **Render** | ✅ Free | ✅ Free | 1GB | 100GB/mo | ~50s |
| **Railway** | ✅ $5 credit | - | 1GB | - | Instant |
| **Netlify** | ❌ | ✅ Free | - | 100GB/mo | Instant |
| **Vercel** | ❌ | ✅ Free | - | 100GB/mo | Instant |

### **Recommended Setup:**
- **Backend**: Render.com (free Docker hosting)
- **Frontend**: Netlify or Render.com

---

## 🎯 **Option 1: Render.com (Easiest - All-in-One)**

### **Pros:**
- ✅ Both frontend and backend on one platform
- ✅ Docker support (your app is ready!)
- ✅ Free SSL certificates
- ✅ 1GB persistent storage

### **Cons:**
- ⚠️ Sleeps after 15 minutes of inactivity (wakes in ~50s)
- ⚠️ 512MB RAM limit

### **Deployment Steps:**

#### **1. Prepare Your Repository**
```bash
cd frontend-test-portal
git init
git add .
git commit -m "Initial commit for deployment"
```

Push to GitHub:
```bash
# Create a new repository on GitHub first
git remote add origin https://github.com/YOUR_USERNAME/test-portal.git
git push -u origin main
```

#### **2. Deploy Backend on Render**

1. Go to [render.com](https://render.com) and sign up (free)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure:
   - **Name**: `test-portal-backend`
   - **Environment**: `Docker`
   - **Dockerfile Path**: `Dockerfile.backend`
   - **Region**: Choose closest to your users
   - **Instance Type**: `Free`

5. **Add Environment Variables** (click "Advanced"):
   ```
   NODE_ENV=production
   PORT=5000
   USE_JSON=true
   JWT_SECRET=<click "Generate" for secure random value>
   ALLOWED_ORIGINS=https://test-portal-frontend.onrender.com
   GOOGLE_CLIENT_ID=563618874909-386bpe7ig2keme4o0gvc6arsp5mh2anu.apps.googleusercontent.com
   ```

6. **Add Persistent Disk**:
   - Name: `backend-data`
   - Mount Path: `/app/data`
   - Size: 1GB

7. Click **"Create Web Service"**
8. Wait 5-10 minutes for first build
9. **Copy your backend URL**: `https://test-portal-backend.onrender.com`

#### **3. Deploy Frontend on Render**

1. Click **"New +"** → **"Web Service"** again
2. Same repository
3. Configure:
   - **Name**: `test-portal-frontend`
   - **Environment**: `Docker`
   - **Dockerfile Path**: `Dockerfile.frontend`
   - **Region**: Same as backend
   - **Instance Type**: `Free`

4. **Add Environment Variables**:
   ```
   VITE_API_URL=https://test-portal-backend.onrender.com/api
   VITE_GOOGLE_CLIENT_ID=563618874909-386bpe7ig2keme4o0gvc6arsp5mh2anu.apps.googleusercontent.com
   ```

5. Click **"Create Web Service"**

#### **4. Update Backend CORS**

Go back to backend service → Environment → Edit:
```
ALLOWED_ORIGINS=https://test-portal-frontend.onrender.com,http://localhost
```

**🎉 Done!** Access your app at: `https://test-portal-frontend.onrender.com`

---

## 🚂 **Option 2: Railway.app**

### **Pros:**
- ✅ $5 free credit (≈500 hours)
- ✅ No cold starts
- ✅ Faster than Render
- ✅ Better developer experience

### **Cons:**
- ⚠️ Runs out after ~$5 credit used
- ⚠️ Requires credit card verification

### **Deployment Steps:**

#### **1. Deploy Backend**

1. Go to [railway.app](https://railway.app) and sign up
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Connect your repository
4. Railway auto-detects `railway.json`
5. **Add Environment Variables**:
   ```
   NODE_ENV=production
   PORT=5000
   USE_JSON=true
   JWT_SECRET=<generate random string>
   ALLOWED_ORIGINS=https://your-frontend-url.netlify.app
   GOOGLE_CLIENT_ID=563618874909-386bpe7ig2keme4o0gvc6arsp5mh2anu.apps.googleusercontent.com
   ```
6. Click **"Deploy"**
7. **Generate Domain**: Settings → Generate Domain
8. Copy your URL: `https://test-portal-backend.up.railway.app`

#### **2. Deploy Frontend on Netlify**

1. Go to [netlify.com](https://netlify.com) and sign up
2. Click **"Add new site"** → **"Import an existing project"**
3. Connect GitHub → Select repository
4. Configure:
   - **Base directory**: `frontend`
   - **Build command**: `npm run build`
   - **Publish directory**: `frontend/dist`
5. **Add Environment Variables**:
   ```
   VITE_API_URL=https://test-portal-backend.up.railway.app/api
   VITE_GOOGLE_CLIENT_ID=563618874909-386bpe7ig2keme4o0gvc6arsp5mh2anu.apps.googleusercontent.com
   ```
6. Click **"Deploy"**

#### **3. Update netlify.toml**

Edit `netlify.toml` and replace:
```toml
to = "https://test-portal-backend.up.railway.app/api/:splat"
```

Push changes:
```bash
git add netlify.toml
git commit -m "Update backend URL"
git push
```

**🎉 Done!** Access at: `https://your-site.netlify.app`

---

## 🔧 **Option 3: Vercel (Frontend Only)**

Similar to Netlify but with different configuration.

1. Go to [vercel.com](https://vercel.com)
2. Import GitHub repository
3. Configure:
   - **Root Directory**: `frontend`
   - **Framework**: Vite
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
4. Add environment variables (same as Netlify)
5. Deploy backend on Render/Railway

---

## 📝 **Post-Deployment Checklist**

### **Backend Health Check:**
```bash
curl https://your-backend-url.onrender.com/health
# Should return: {"status":"ok"}
```

### **Test API:**
```bash
curl https://your-backend-url.onrender.com/api/courses
# Should return JSON data
```

### **Update CORS Origins:**
Make sure backend `ALLOWED_ORIGINS` includes:
- Your frontend URL
- `http://localhost` (for local development)

### **Test Frontend:**
1. Open frontend URL in browser
2. Check browser console for errors
3. Try logging in as admin
4. Verify API calls work

---

## 🐛 **Troubleshooting**

### **Issue: "CORS Error"**
**Solution:** Update backend `ALLOWED_ORIGINS` to include frontend URL

### **Issue: "API calls fail"**
**Solution:** 
1. Check backend is running: visit `/health` endpoint
2. Verify `VITE_API_URL` in frontend env vars
3. Check browser Network tab for actual error

### **Issue: "Service sleeps after 15 minutes"**
**Solution:** 
- Free tier limitation on Render
- Upgrade to Starter ($7/mo) for always-on
- Or use Railway (no cold starts)

### **Issue: "Build fails - out of memory"**
**Solution:**
- Render free tier: 512MB RAM
- Simplify dependencies or upgrade plan

### **Issue: "Assets/images not loading"**
**Solution:**
1. Check nginx.conf proxies to correct backend URL
2. Verify backend `/assets` routes work
3. Check browser Network tab for 404s

---

## 💰 **Cost Breakdown**

### **100% Free Option:**
- **Render Backend**: Free (with cold starts)
- **Netlify Frontend**: Free (100GB bandwidth)
- **Total**: $0/month ✅

### **Better Performance ($7/month):**
- **Render Backend**: Starter $7/mo (always-on, 512MB RAM)
- **Netlify Frontend**: Free
- **Total**: $7/month

### **Best Performance ($20/month):**
- **Render Backend**: Standard $25/mo (2GB RAM)
- **Railway Backend**: $5/mo
- **Vercel Frontend**: Free
- **Total**: ~$25/month

---

## 🎓 **Next Steps**

1. **Custom Domain**: Add your own domain (free on Netlify/Vercel)
2. **Database**: Upgrade from JSON to free TiDB Cloud or PlanetScale
3. **Monitoring**: Add Sentry for error tracking
4. **Analytics**: Add Google Analytics
5. **CDN**: Already included on Netlify/Vercel!

---

## 📞 **Support**

- **Render Docs**: https://render.com/docs
- **Railway Docs**: https://docs.railway.app
- **Netlify Docs**: https://docs.netlify.com

---

**🚀 Ready to deploy? Start with Option 1 (Render) - it's the easiest!**
