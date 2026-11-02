local patrol        = {}

local HOME_LOCATION = { x = 0, y = 0, z = 0 } -- Replace with your home coordinates

function patrol.goToStartPoint()
    moveToPoint(HOME_LOCATION.x, HOME_LOCATION.y, HOME_LOCATION.z)
end

function patrol.lookAround(pauseTime)
    local directions = { "North", "East", "South", "West" }
    for _, direction in ipairs(directions) do
        faceDirection(direction)
        print("Facing " .. direction)
        inspected, metadata = turtle.inspect()
        print("\tInspected: " .. tostring(inspected))
        print("\tMetadata: " .. tostring(metadata))
        sleep(pauseTime)
    end
end

-- function to cycle around home in counter-clockwise direction
function patrol.moveAndCheck(direction, distance)
    local faced = faceDirection(direction)
    if not faced then
        print("Failed to face " .. direction .. ". Aborting patrol.")
        return false
    end
    local moved = moveDistance(distance)
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
        if not moveAndCheck(move.direction, move.distance) then
            print("Patrol failed at step " .. i .. ". Aborting patrol.")
            return
        end
        if move.lookAroundAfter then
            lookAround(1)
        end
    end
end

return patrol
