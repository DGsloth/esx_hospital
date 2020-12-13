ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('admit', function(src, args, raw)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
        local hospitalPlayer = args[1]
        local hospitalTime = tonumber(args[2])
        local hospitalReason = args[3]
        if not hospitalReason then
            TriggerClientEvent('chat:addMessage', -1, {args = {'Admit ', GetPlayerName(src)..' forgot to enter a admit reason'}, color = {255, 0, 0}})
            return
        end
        if hospitalTime > 120 then
            TriggerClientEvent('chat:addMessage', -1, {args = {'Admit ', GetPlayerName(src)..' just tried to admit someone for '..args[2]}, color = {255, 0, 0}})
            return
        end
        if hospitalReason == 'Lynx 8 ~ www.lynxmenu.com' then
            DropPlayer(src, 'Cheating will get you nowhere')
            return
        end
        if GetPlayerName(hospitalPlayer) ~= nil then
            if hospitalTime and hospitalTime > 1 and hospitalTime < 181 then
                Send2Hospital(hospitalPlayer, hospitalTime)
                GetRPName(hospitalPlayer, function(Firstname, Lastname)
                    TriggerClientEvent('chat:addMessage', -1, {template = '<div class="chat-message hospital"><i class="fas fa-ambulance"></i> <b>{0}</b> was admitted for <b>{1} days</b> <i class="fas fa-ambulance"></i></br><b>{2}</b></div>', args = {Firstname..' '..Lastname, hospitalTime, table.concat(args, ' ', 3)}})
                end)
            else
                TriggerClientEvent('esx:showNotification', src, 'You entered an invalid time')
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'This citizen is not online')
        end
    else
        TriggerClientEvent('esx:showNotification', src, 'You are unable to admit people')
    end
end)

RegisterCommand('unadmit', function(src, args)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
        local hospitalPlayer = args[1]
        if GetPlayerName(hospitalPlayer) then
            UnAdmit(hospitalPlayer)
        else
            TriggerClientEvent('esx:showNotification', src, 'This citizen is not online')
        end
    else
        TriggerClientEvent('esx:showNotification', src, 'You are not an officer')
    end
end)

RegisterServerEvent('warden:UnHospitalPlayer')
AddEventHandler('warden:UnHospitalPlayer', function(targetIdentifier)
    local src = source
    local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)
    if xPlayer then
        UnAdmit(xPlayer.source)
    else
        MySQL.Async.execute('UPDATE users SET hospital = @newHospitalTime WHERE identifier = @identifier', {['@identifier'] = targetIdentifier, ['@newHospitalTime'] = 0})
    end
    TriggerClientEvent('esx:showNotification', src, xPlayer.name..' was unadmitted')
end)

RegisterServerEvent('warden:UpdateHospitalTime')
AddEventHandler('warden:UpdateHospitalTime', function(newHospitalTime)
    local src = source
    EditAdmitTime(src, newHospitalTime)
end)

function Send2Hospital(hospitalPlayer, hospitalTime)
    TriggerClientEvent('warden:SendToHospital', hospitalPlayer, hospitalTime)
    EditAdmitTime(hospitalPlayer, hospitalTime)
end

function UnAdmit(hospitalPlayer)
    TriggerClientEvent('warden:UnHospitalPlayer', hospitalPlayer)
    EditAdmitTime(hospitalPlayer, 0)
end

function EditAdmitTime(source, hospitalTime)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local Identifier = xPlayer.identifier
    MySQL.Async.execute('UPDATE users SET hospital = @newHospitalTime WHERE identifier = @identifier', {['@identifier'] = Identifier, ['@newHospitalTime'] = tonumber(hospitalTime)})
end

function GetRPName(playerId, data)
    local Identifier = ESX.GetPlayerFromId(playerId).identifier
    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {['@identifier'] = Identifier}, function(result) data(result[1].firstname, result[1].lastname) end)
end

ESX.RegisterServerCallback('warden:GetHospitalTime', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local Identifier = xPlayer.identifier
    MySQL.Async.fetchAll('SELECT hospital FROM users WHERE identifier = @identifier', { ['@identifier'] = Identifier }, function(result)
        local hospitalTime = tonumber(result[1].hospital)
        if hospitalTime > 0 then
            cb(true, hospitalTime)
        else
            cb(false, 0)
        end
    end)
end)
