function getCurrentLocation()
    local x, y, z = gps.locate()
    return {x = x, y = y, z = z}
end

function getFacingDirection()
    local location = getCurrentLocation()
    if not location or not location.x then
        print("Unable to get current location. Ensure GPS is enabled and try again.")
        return
    end
    turtle.forward()
    local newLocation = getCurrentLocation()
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

function faceDirection(direction)
    local currentFacing = getFacingDirection()
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

function moveDistance(distance)
    for i = 1, distance do
        if not turtle.forward() then
            print("Movement blocked. Unable to move forward.")
            return false
        end
    end
    return true
end


function moveToPoint(targetX, targetY, targetZ)
    local location = getCurrentLocation()
    if not location or not location.x then
        print("Unable to get current location. Ensure GPS is enabled and try again.")
        return false
    end

    local deltaX = targetX - location.x
    local deltaY = targetY - location.y
    local deltaZ = targetZ - location.z

    -- Move in the X direction
    if deltaX > 0 then
        faceDirection("East")
        moveDistance(deltaX)
    elseif deltaX < 0 then
        faceDirection("West")
        moveDistance(-deltaX)
    end

    -- Move in the Z direction
    if deltaZ > 0 then
        faceDirection("South")
        moveDistance(deltaZ)
    elseif deltaZ < 0 then
        faceDirection("North")
        moveDistance(-deltaZ)
    end

    -- Move in the Y direction (up or down)
    if deltaY > 0 then
        for i = 1, deltaY do
            turtle.up()
        end
    elseif deltaY < 0 then
        for i = 1, -deltaY do
            turtle.down()
        end
    end

    return true
end