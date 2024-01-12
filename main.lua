function love.load()
    image = love.graphics.newImage('frog.jpg')
	frame = 0
end 


function love.update(dt)
	frame = frame + 1
	print(frame)
end 


function love.draw()
    love.graphics.draw(image, love.math.random(0,800),love.math.random(0,600))
end 

--The Default Game Loop
function love.run()
    if love.math then
	love.math.setRandomSeed(os.time())
    end

    if love.load then love.load(arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0
    local upper_dt = 1/60

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
	    love.event.pump()
	    for name, a,b,c,d,e,f in love.event.poll() do
	        if name == "quit" then
		    if not love.quit or not love.quit() then
		        return a
		    end
	        end
		love.handlers[name](a,b,c,d,e,f)
	    end
        end

	--Update dt, as we'll be passing it to update
	if love.timer then
	    love.timer.step()
	    dt = love.timer.getDelta()
	end 

	while dt > 0 do
		local current_dt = math.min(dt, upper_dt)
		if love.update then love.update(current_dt) end
		dt = dt - current_dt
	end

	if love.graphics and love.graphics.isActive() then
	    love.graphics.clear(love.graphics.getBackgroundColor())
	    love.graphics.origin()
            if love.draw then love.draw() end
	    love.graphics.present()
	end

	if love.timer then love.timer.sleep(0.001) end
    end
end