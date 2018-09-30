Dinosaur = {
    x = 50,
    y = 0,
    yvel = 0,
    groundPos = 0.7,
    jumpHeight = -18,
    touching = nil
}

function Dinosaur:getGPos()
    return (self.groundPos * love.graphics.getHeight()) - self.image:getHeight()
end

function Dinosaur:load()
    self.image = love.graphics.newImage("karlmarx.jpg")
end

function Dinosaur:onGround()
    return self.y == self:getGPos()
end

function Dinosaur:update(dt, obstacles, game)
    self.yvel = self.yvel + gravity

    -- Jumping
    if self:onGround() and love.keyboard.isDown("up") then
        self.yvel = self.jumpHeight
    end

    -- Collision
    local touched = false

    for i, v in pairs(obstacles) do
        if (v.x + v.image:getWidth()) > self.x
            and (self.x + self.image:getWidth()) > v.x
            and (v.y + v.image:getHeight()) > self.y
            and (self.y + self.image:getHeight()) > v.y then
            -- Collided
            touched = true
            if v ~= self.touching then
                game.points = game.points - 10
                self.touching = v
            end
        end
    end

    if not touched then
        self.touching = nil
    end
    
    -- Apply velocities
    local sum = self.y + self.yvel
    local gpos = self:getGPos()
    if sum > gpos then
        self.yvel = 0
        self.y = gpos
    else
        self.y = sum
    end
end

function Dinosaur:draw()
    love.graphics.draw(self.image, self.x, self.y)
end