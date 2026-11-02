term.clear()

fuel = require("utilities.movement.fuel")
patrol = require("patrol")

local refuelFrequency = 20 -- Refuel every 20 moves

fuel.checkFuelAndRefuel()

patrol.goToStartPoint()

local i = 1
while true do
    patrol.patrolAroundHome()
    if i % refuelFrequency == 0 then
        fuel.checkFuelAndRefuel()
    end
    i = i + 1
end
