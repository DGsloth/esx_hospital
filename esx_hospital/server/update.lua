PerformHttpRequest('https://raw.githubusercontent.com/DGsloth/esx_hospital/main/version.txt', function(err, serverVersion, headers)
    local version = '1.0'
    if string.find(serverVersion, version) == nil then
        print('^4ADDON: ^3', GetCurrentResourceName(), ' ^7[^1OUTDATED^7]')
    else
        print('^4ADDON: ^3', GetCurrentResourceName(), ' ^7[^2UPDATED^7]')
    end
end)