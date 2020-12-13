ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local hospitalTime = 0
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(newData)
    Citizen.Wait(10000)
    ESX.TriggerServerCallback('warden:GetHospitalTime', function(isInHospital, newHospitalTime)
        if isInHospital then
            hospitalTime = newHospitalTime
            WelcomeBackYouCripple()
        end
    end)
end)

disableStuff = false
RegisterNetEvent('warden:SendToHospital')
AddEventHandler('warden:SendToHospital', function(newHospitalTime)
    hospitalTime = newHospitalTime
    disableStuff = true
    SendToHospital()
end)

RegisterNetEvent('warden:UnHospitalPlayer')
AddEventHandler('warden:UnHospitalPlayer', function()
    hospitalTime = 0
    disableStuff = false
    UnHospitalPlayer()
end)

BedLocations = {
    {x = 308.96, y = -581.92, z = 43.28},   {x = 312.3, y = -583.24, z = 43.28},    -- FAR SIDE
    {x = 315.83, y = -584.37, z = 43.28},   {x = 319.05, y = -585.66, z = 43.28},   -- FAR SIDE
    {x = 321.51, y = -586.7, z = 43.28},                                            -- FAR SIDE

    {x = 322.78, y = -582.68, z = 43.28},   {x = 320.43, y = -581.42, z = 43.28},   -- CLOSE SIDE
    {x = 312.32, y = -579.33, z = 43.28},   {x = 310.44, y = -578.03, z = 43.28}    -- CLOSE SIDE
}

function SendToHospital()
    ESX.Game.Teleport(PlayerPedId(), BedLocations[math.random(1, #BedLocations)])
    CheckIfInHospital()
end

function UnHospitalPlayer()
    CheckIfInHospital()
    ESX.ShowNotification('You healed well enough. The doctors let you go.')
    SetHealth(200)
    disableStuff = false
end

function SetHealth(h)
    local n = math.floor(h)
    SetEntityHealth(GetPlayerPed(-1), n)
end

function WelcomeBackYouCripple()
    ESX.Game.Teleport(PlayerPedId(), {x = 322.82, y = -584.74, z = 43.28})
    ESX.ShowNotification('You are still serving your hospital sentence')
    disableStuff = true
    CheckIfInHospital()
end

function CheckIfInHospital()
    Citizen.CreateThread(function()
        while hospitalTime > 0 do
            hospitalTime = hospitalTime - 1
            ESX.ShowNotification('You have '..hospitalTime..' days left in the hospital')
            TriggerServerEvent('warden:UpdateHospitalTime', hospitalTime)
            disableStuff = true
            if hospitalTime == 0 then
                UnHospitalPlayer()
                disableStuff = false
                TriggerServerEvent('warden:UpdateHospitalTime', 0)
            end
            Citizen.Wait(60000)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if disableStuff then
            local getEntCoords = GetEntityCoords(GetPlayerPed(-1), true)
            local Dist = Vdist(316.17, -582.29, 43.28, getEntCoords['x'], getEntCoords['y'], getEntCoords['z'])
            if Dist > 15 then
                ESX.Game.Teleport(PlayerPedId(), BedLocations[math.random(1, #BedLocations)])
                ESX.ShowNotification('The doctor did not discharge you yet. Back to bed you go!')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if disableStuff then
            DisableControlAction(0,21,true) -- disable sprint
            DisableControlAction(0,24,true) -- disable attack
            DisableControlAction(0,25,true) -- disable aim
            DisableControlAction(0,47,true) -- disable weapon
            DisableControlAction(0,58,true) -- disable weapon
            DisableControlAction(0,263,true) -- disable melee
            DisableControlAction(0,264,true) -- disable melee
            DisableControlAction(0,257,true) -- disable melee
            DisableControlAction(0,140,true) -- disable melee
            DisableControlAction(0,141,true) -- disable melee
            DisableControlAction(0,142,true) -- disable melee
            DisableControlAction(0,143,true) -- disable melee
            DisableControlAction(0,75,true) -- disable exit vehicle
            DisableControlAction(27,75,true) -- disable exit vehicle
        end
    end
end)
