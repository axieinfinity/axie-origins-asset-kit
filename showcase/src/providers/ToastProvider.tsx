import { useToast } from '@axieinfinity/dango'
import { createContext, useContext, type ReactNode } from 'react'

type Notice = ReturnType<typeof useToast>['notice']

const ToastContext = createContext<Notice | null>(null)

export function ToastProvider({ children }: { children: ReactNode }) {
  const { notice, contextHolder } = useToast({ maxCount: 3, closable: true })
  return (
    <ToastContext.Provider value={notice}>
      {contextHolder}
      {children}
    </ToastContext.Provider>
  )
}

export function useAppToast() {
  const notice = useContext(ToastContext)
  if (!notice) throw new Error('useAppToast must be used inside ToastProvider')
  return notice
}
