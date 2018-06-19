local robot = require("robot")
local shell = require("shell")
local args, options = shell.parse(...)

local function main(width, depth)
    turn_right = true
    new_layer = true
    repeat
        layer_height = width
        repeat
            if new_layer == true then
                new_layer = false
                io.write("Starting new layer\n")
            elseif turn_right == true then
                robot.turnRight()
                robot.swing()
                robot.forward()
                robot.turnRight()
                turn_right = false
                io.write("Turning right\n")
            else
                robot.turnLeft()
                robot.swing()
                robot.forward()
                robot.turnLeft()
                turn_right = true
                io.write("Turning left\n")
            end
            -- Dig out one row --
            layer_width = width - 1
            repeat
                robot.swing()
                robot.forward()
                layer_width = layer_width - 1
            until( layer_width == 0 )

            layer_height = layer_height - 1
        until( layer_height == 0 )

        -- Dig down and turn around --
        robot.swingDown()
        robot.down()
        robot.turnAround()
        new_layer = true
        depth = depth - 1
        io.write("Going down\n")
    until( depth == 0 )
end

local width = tonumber(args[1]) or 9
local depth = tonumber(args[2]) or 9

main(width, depth)