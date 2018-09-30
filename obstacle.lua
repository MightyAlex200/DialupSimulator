Obstacle = {
    x = 0,
    y = 0,
    xvel = -5
}

function Obstacle:load(y, img)
    self.y = y
    self.image = img
    self.x = love.graphics.getWidth()
end

function Obstacle:update(dt)
    self.x = self.x + self.xvel
end

function Obstacle:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
