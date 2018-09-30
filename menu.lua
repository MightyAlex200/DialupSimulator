Button = {x = 0, y = 0}

function Button:load()

end
function Button:update()

end
function Button:draw()
    love.graphics.draw(self.image, self.x, self.y)
end
