import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig(({ mode }) => {
  // Force production values when building
  const apiUrl = process.env.VITE_API_URL || 
    (mode === 'production' ? 'https://test-portal-backend-22zx.onrender.com/api' : 'http://localhost:5000/api')
  
  const googleClientId = process.env.VITE_GOOGLE_CLIENT_ID || 
    '563618874909-386bpe7ig2keme4o0gvc6arsp5mh2anu.apps.googleusercontent.com'

  console.log('Building with API URL:', apiUrl)
  console.log('Building with Google Client ID:', googleClientId)

  return {
    plugins: [react()],
    server: {
      port: 5173,
      proxy: {
        '/api': {
          target: 'http://localhost:5000',
          changeOrigin: true
        }
      }
    },
    define: {
      'import.meta.env.VITE_API_URL': JSON.stringify(apiUrl),
      'import.meta.env.VITE_GOOGLE_CLIENT_ID': JSON.stringify(googleClientId)
    }
  }
})
