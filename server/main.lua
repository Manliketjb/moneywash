-- Code
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("moneywash:server:checkInv", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local markedbills = Player.Functions.GetItemByName('markedbills')
    local amt = Player.Functions.GetItemByName('markedbills').amount
    local worth = markedbills.info.worth
    if Player.Functions.GetItemByName('markedbills') ~= nil then
        if amt <= 1 then
            Player.Functions.RemoveItem('markedbills', amt)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "remove")
            TriggerClientEvent('moneywash:client:startTimer', src, amt, worth)
            TriggerClientEvent('QBCore:Notify', src, amt .. ' Inky Pack Set To Wash At $' .. worth, 'primary')
        elseif amt > 1 then
            Player.Functions.RemoveItem('markedbills', amt)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "remove")
            TriggerClientEvent('moneywash:client:startTimer', src, amt, worth)
            TriggerClientEvent('QBCore:Notify', src, amt .. ' Inky Packs Set To Wash At $' .. worth .. ' Each.', 'primary')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Have No Inky Packs...', 'error')
    end
end)


RegisterNetEvent("moneywash:server:giveMoney", function(amt, worth)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local chance = math.random(1, 100)
    if chance > 15 and chance <= 25 then 
        Player.Functions.AddMoney('cash', worth * amt - math.random(500, 1500))
        TriggerClientEvent('QBCore:Notify', src, 'Damn... Some Notes Got Stuck In The Washer!', 'error')
    elseif chance > 25 and chance <= 50 then 
        Player.Functions.AddMoney('cash', worth * amt - math.random(250, 1000))
        TriggerClientEvent('QBCore:Notify', src, 'Really??? Washer Ate Some Of My Bills.', 'error')
    elseif chance > 50 and chance <= 95 then 
        Player.Functions.AddMoney('cash', worth * amt)
        TriggerClientEvent('QBCore:Notify', src, 'Looks Like It Is All There...', 'primary')
    elseif chance > 95 and chance <= 100 then 
        Player.Functions.AddMoney('cash', worth * amt)
        Player.Functions.AddItem('cryptostick', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptostick'], "add")
        TriggerClientEvent('QBCore:Notify', src, 'Looks Like It Is All There And A Little Extra...', 'primary')
    end
end)
