import { createRoot } from 'react-dom/client'
import '@axieinfinity/dango/dist/bundle.css'
import './style.css'
import { App } from './App'
import { ToastProvider } from './providers/ToastProvider'

createRoot(document.getElementById('root')!).render(
  <ToastProvider>
    <App />
  </ToastProvider>,
)
