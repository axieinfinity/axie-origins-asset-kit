import { defineConfig } from 'vite'

export default defineConfig({
  server: {
    host: true,
    port: 5178,
    strictPort: true,
  },
  define: {
    global: 'globalThis',
  },
  optimizeDeps: {
    include: ['buffer', '@axieinfinity/mixer', 'pixi.js', 'pixi-spine'],
  },
})
