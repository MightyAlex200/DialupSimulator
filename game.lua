Game = {
    points = 0
}

function Game:load()

end

function Game:update(dt)
    self.points = self.points + dt
end

function Game:draw()
    love.graphics.print("Means of production: " .. math.floor(self.points + 0.5), 0, 0)
end