import { AxieIcon } from '@axieinfinity/dango-icons'

type Props = {
  size?: number
}

export function AxieMark({ size = 28 }: Props) {
  return <AxieIcon size={size} aria-hidden />
}
