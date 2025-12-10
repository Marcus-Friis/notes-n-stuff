local sound = {}
sound._popSource = love.audio.newSource("sounds/pop.mp3", "static")

function sound.ballHit()
	love.audio.play(sound._popSource)
end

return sound
