movement = require("utilities.movement.basic")

local patrol        = {}

local HOME_LOCATION = { x = -376, y = 62, z = -151 } -- Replace with your home coordinates

function patrol.goToStartPoint()
    print("Returning to HOME: (" .. HOME_LOCATION.x .. ", " .. HOME_LOCATION.y .. ", " .. HOME_LOCATION.z .. ")")
    if not movement.moveToPoint(HOME_LOCATION.x, HOME_LOCATION.y, HOME_LOCATION.z) then
        print("Failed to return to home location. Aborting patrol.")
        return false
    end
    return true
end

function patrol.lookAround(pauseTime)
    local directions = { "North", "East", "South", "West" }
    for _, direction in ipairs(directions) do
        movement.faceDirection(direction)
        print("Facing " .. direction)
        inspected, metadata = turtle.inspect()
        print("\tInspected: " .. tostring(inspected))
        print("\tMetadata: " .. tostring(metadata))
        sleep(pauseTime)
    end
end

-- function to cycle around home in counter-clockwise direction
function patrol.moveAndCheck(direction, distance)
    local faced = movement.faceDirection(direction)
    if not faced then
        print("Failed to face " .. direction .. ". Aborting patrol.")
        return false
    end
    local moved = movement.moveDistance(distance)
    if not moved then
        print("Failed to move " .. direction .. ". Aborting patrol.")
        return false
    end
    return true
end

function patrol.patrolAroundHome()
    local moves = {
        { direction = "West", distance = 5,  lookAroundAfter = true },
        { direction = "East", distance = 10, lookAroundAfter = true },
        { direction = "West", distance = 5,  lookAroundAfter = false }
    }

    for i, move in ipairs(moves) do
        if not patrol.moveAndCheck(move.direction, move.distance) then
            print("Patrol failed at step " .. i .. ". Aborting patrol.")
            return
        end
        if move.lookAroundAfter then
            patrol.lookAround(1)
        end
    end
end

return patrol
