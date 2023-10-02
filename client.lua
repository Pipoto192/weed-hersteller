ESX = nil
_menuPool = NativeUI.CreatePool()
local mainMenu
local currentStatus = 'out'


ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = Vdist(playerCoords, Config.Destination.x,Config.Destination.y,Config.Destination.z)

        _menuPool:ProcessMenus()

        if IsControlJustReleased (0, 38) then
            if distance < 2.0 then
                
                openMenu()
            end
        end    
        Citizen.Wait(1)
    end


end)

RegisterCommand('itemgive', function(source, args, raw)


end , false)

function openMenu()
    mainMenu = NativeUI.CreateMenu(nil,'Weed crafing made by tiloth')
    _menuPool:Add(mainMenu)

    local background = Sprite.New('custommenu','weed-craft-banner', 0, 0, 512, 128)
    mainMenu:SetBannerSprite(background, true)

    local testItem = NativeUI.CreateItem('Weed Herstellen', 'Stelle das weed her')
    mainMenu:AddItem(testItem)

    testItem.Activated = function(sender, index, status)
        local PlayerId = GetPlayerServerId(PlayerId())
        local playerPed = PlayerPedId()
        TriggerServerEvent('checkitems', PlayerId)
    end

    local closeitem = NativeUI.CreateItem('Schließen', 'Schließe das menü')
    mainMenu:AddItem(closeitem)

    closeitem.Activated = function(sender , index )
        mainMenu:Visible(false)
    end


    mainMenu:Visible(true)

    _menuPool:MouseEdgeEnabled(false)
end

RegisterNetEvent('haveitems')
AddEventHandler('haveitems',function() 
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed,'WORLD_HUMAN_BUM_WASH', 0, true)
    Wait(10000)
    ClearPedTasks(playerPed)
    TriggerServerEvent('giveitem' , playerPed)
end)


function ShowNotification(text)
 SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
 DrawNotification(false, true)
end


