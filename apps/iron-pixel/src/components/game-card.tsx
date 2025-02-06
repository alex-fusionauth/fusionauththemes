interface GameCardProps {
  title: string
  description: string
  imageUrl: string
}

export function GameCard({ title, description, imageUrl }: GameCardProps) {
  return (
    <div className="group relative overflow-hidden rounded-lg">
      <img
        src={imageUrl || "/placeholder.svg"}
        alt={title}
        className="w-full aspect-video object-cover transition-transform group-hover:scale-105"
      />
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent flex flex-col justify-end p-6">
        <h3 className="text-xl font-bold mb-2">{title}</h3>
        <p className="text-gray-300">{description}</p>
      </div>
    </div>
  )
}

