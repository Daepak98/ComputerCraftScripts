local basic = {}

function basic.getCurrentLocation()
    local x, y, z = gps.locate()
    return { x = x, y = y, z = z }
end

function basic.getFacingDirection()
    local location = basic.getCurrentLocation()
    if not location or not location.x then
        print("Unable to get current location. Ensure GPS is enabled and try again.")
        return
    end

    local success, newLocation = false, nil

    -- Attempt 1: Move forward
    if turtle.forward() then
        newLocation = basic.getCurrentLocation()
        success = true
    else
        -- Attempt 1 failed, spin 180 degrees and try again
        print("Initial move forward failed. Spinning around and retrying...")
        turtle.turnRight()
        turtle.turnRight()
        if turtle.forward() then
            newLocation = basic.getCurrentLocation()
            success = true
        else
            print("Second move forward failed after spinning. Cannot determine facing direction.")
            return
        end
    end

    turtle.back()

    if newLocation.x > location.x then
        return "East"
    elseif newLocation.x < location.x then
        return "West"
    elseif newLocation.z > location.z then
        return "South"
    else
        return "North"
    end
end

function basic.faceDirection(direction)
    local currentFacing = basic.getFacingDirection()
    if not currentFacing then
        print("Unable to determine facing direction.")
        return
    end

    local turns = {
        North = { East = 1, South = 2, West = 3 },
        East = { South = 1, West = 2, North = 3 },
        South = { West = 1, North = 2, East = 3 },
        West = { North = 1, East = 2, South = 3 }
    }

    local turnCount = turns[currentFacing][direction]
    if turnCount then
        for i = 1, turnCount do
            turtle.turnRight()
        end
        return true
    else
        print("Invalid direction provided.")
    end
end

function basic.moveDistance(distance)
    for i = 1, distance do
        if not turtle.forward() then
            print("Movement blocked. Unable to move forward.")
            return false
        end
    end
    return true
end

function basic.moveToPoint(targetX, targetY, targetZ)
    local location = basic.getCurrentLocation()
    if not location or not location.x then
        print("Unable to get current location. Ensure GPS is enabled and try again.")
        return false
    else
        print("Current Location: (" .. location.x .. ", " .. location.y .. ", " .. location.z .. ")")
        print("Target Location: (" .. targetX .. ", " .. targetY .. ", " .. targetZ .. ")")
    end

    local deltaX = targetX - location.x
    local deltaY = targetY - location.y
    local deltaZ = targetZ - location.z

    -- Move in the X direction
    if deltaX < 0 then
        print("Moving East")
        basic.faceDirection("East")
        if not basic.moveDistance(deltaX) then
            print("Failed to move East. Aborting movement.")
            return false
        end
    elseif deltaX > 0 then
        print("Moving West")
        basic.faceDirection("West")
        if not basic.moveDistance(-deltaX) then
            print("Failed to move West. Aborting movement.")
            return false
        end
    end

    -- Move in the Z direction
    if deltaZ < 0 then
        print("Moving South")
        basic.faceDirection("South")
        if not basic.moveDistance(deltaZ) then
            print("Failed to move South. Aborting movement.")
            return false
        end
    elseif deltaZ > 0 then
        print("Moving North")
        basic.faceDirection("North")
        if not basic.moveDistance(-deltaZ) then
            print("Failed to move North. Aborting movement.")
            return false
        end
    end

    -- Move in the Y direction (up or down)
    if deltaY > 0 then
        print("Moving Up")
        for i = 1, deltaY do
            if not turtle.up() then
                print("Movement blocked. Unable to move up.")
                return false
            end
        end
    elseif deltaY < 0 then
        print("Moving Down")
        for i = 1, -deltaY do
            if not turtle.down() then
                print("Movement blocked. Unable to move down.")
                return false
            end
        end
    end

    return true
end

return basic