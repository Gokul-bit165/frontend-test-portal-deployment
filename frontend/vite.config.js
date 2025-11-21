import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
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
    'import.meta.env.VITE_API_URL': JSON.stringify(
      process.env.VITE_API_URL || 'http://localhost:5000/api'
    ),
    'import.meta.env.VITE_GOOGLE_CLIENT_ID': JSON.stringify(
      process.env.VITE_GOOGLE_CLIENT_ID || '563618874909-386bpe7ig2keme4o0gvc6arsp5mh2anu.apps.googleusercontent.com'
    )
  }
})
