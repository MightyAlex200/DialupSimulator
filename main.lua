require "dinosaur"
require "obstacle"
require "game"
-- require "button"
local dinosaur
local obstacles
local button
local game
local music
gravity = 0.4

function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

function love.mousepressed(x, y, button, istouch, presses)
    dinosaur:mousepressed(x, y, button, istouch, presses)
end

function love.load()
    music = love.audio.newSource("ost.mp3", "stream")
    music:setLooping(true)
    music:play()
    game = Game
    game:load()
    dinosaur = Dinosaur
    dinosaur:load()
    obstacles = {}
    local obstacleImage = love.graphics.newImage("elonmusk.jpg")
    for i = 1, 3 do
        local ob = copy(Obstacle)
        ob:load(dinosaur:getGPos(), obstacleImage)
        ob.x = ob.x + ((i - 1) * 800)
        obstacles[i] = ob
    end
end

function love.draw()
    game:draw()
    dinosaur:draw()
    for i, v in pairs(obstacles) do
        v:draw()
    end
end

function love.update(dt)
    game:update(dt)
    dinosaur:update(dt, obstacles, game)
    for i, v in pairs(obstacles) do
        v:update(dt)
        if v.x < 0 then
            v.x = v.x + ((math.random() * 150) + 2250)
        end
    end
end