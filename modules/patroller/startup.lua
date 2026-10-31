term.clear()

local refuelFrequency = 20 -- Refuel every 20 moves

checkFuelAndRefuel()

goToStartPoint()

local i = 1
while true do
    patrolAroundHome()
    if i % refuelFrequency == 0 then
        checkFuelAndRefuel()
    end
    i = i + 1
end
