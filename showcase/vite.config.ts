import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import fs from 'node:fs'
import path from 'node:path'

const kit = path.resolve(__dirname, '../Assets/OriginsKit')

const MIME: Record<string, string> = {
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.wav': 'audio/wav',
  '.mp3': 'audio/mpeg',
  '.json': 'application/json',
  '.atlas': 'text/plain',
  '.skel': 'application/octet-stream',
  '.bytes': 'application/octet-stream',
  '.txt': 'text/plain',
}

export default defineConfig({
  plugins: [
    react(),
    {
      name: 'kit-static',
      configureServer(server) {
        server.middlewares.use('/kit', (req, res, next) => {
          const rel = decodeURIComponent((req.url || '').split('?')[0]).replace(/^\/+/, '')
          const file = path.resolve(kit, rel)
          if (!file.startsWith(kit) || !fs.existsSync(file) || fs.statSync(file).isDirectory()) {
            next()
            return
          }
          res.setHeader('Content-Type', MIME[path.extname(file).toLowerCase()] || 'application/octet-stream')
          fs.createReadStream(file).pipe(res)
        })
      },
    },
  ],
  server: {
    host: true,
    port: 5177,
    strictPort: true,
    fs: { allow: [path.resolve(__dirname, '..')] },
  },
  define: { global: 'globalThis' },
})
