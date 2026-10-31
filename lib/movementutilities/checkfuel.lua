function checkFuelAndRefuel()
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel == "unlimited" then
        print("Fuel level is unlimited.")
        return true
    elseif fuelLevel < 100 then
        print("Fuel level is low: " .. fuelLevel)
        print("Attempting to refuel...")
        for slot = 1, 16 do
            turtle.select(slot)
            if turtle.refuel(1) then
                print("Refueled from slot " .. slot)
                return true
            end
        end
        print("No fuel available to refuel.")
        return false
    else
        print("Fuel level is sufficient: " .. fuelLevel)
        return true
    end
end
