Button = {x = 0, y = 0}

function Button:load(x, y, img)
    self.image = love.graphics.newImage(img)
end
function Button:update()
    if love.mouse.getx() > self.x 
end
function Button:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
