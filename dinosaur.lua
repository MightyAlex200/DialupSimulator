Dinosaur = {
    x = 50,
    y = 0,
    yvel = 0,
    groundPos = 0.7,
    jumpHeight = -18,
    touching = nil,
    jumpSound = nil
}

function Dinosaur:getGPos()
    return (self.groundPos * love.graphics.getHeight()) - self.image:getHeight()
end

function Dinosaur:load()
    self.jumpSound = love.audio.newSource("jump.wav", "static")
    self.image = love.graphics.newImage("karlmarx.jpg")
end

function Dinosaur:onGround()
    return self.y == self:getGPos()
end

function Dinosaur:jump()
    self.yvel = self.jumpHeight
    self.jumpSound:play()
end

function Dinosaur:mousepressed(x, y, button, istouch, presses)
    if self:onGround() then
        self:jump()
    end
end

function Dinosaur:update(dt, obstacles, game)
    self.yvel = self.yvel + gravity

    -- Jumping
    if self:onGround() and love.keyboard.isDown("up") then
        self:jump()
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