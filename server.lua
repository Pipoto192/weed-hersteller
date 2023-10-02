ESX = nil
ESX = exports["es_extended"]:getSharedObject()

    RegisterServerEvent('checkitems')
    AddEventHandler('checkitems', function(PlayerId)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getInventoryItem('water').count > 0 then
            TriggerClientEvent('haveitems', PlayerId)
        else
            xPlayer.showNotification('du hast nicht genügen items dafür', flash, saveToBrief, hudColorIndex)
        end
    end)
    RegisterServerEvent('giveitem')
    AddEventHandler('giveitem', function()
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if xPlayer.getInventoryItem('water').count > 0 then 
            xPlayer.removeInventoryItem('water', 1)
            xPlayer.addInventoryItem('bandage', 1)
        else
            xPlayer.showNotification('du hast nicht genügen items dafür', flash, saveToBrief, hudColorIndex)
        end
        
    end)

