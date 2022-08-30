lib.locale()

local bodycam = false

--LOAD UNLOAD
AddEventHandler('onResourceStop', function()
    SetDisplay(false)
    SendNUIMessage({ action = "closeui" })
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
end

--NUI
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

--SHOW BODYCAM
RegisterNetEvent("rx_bodycam:show")
AddEventHandler("rx_bodycam:show", function(name_server, job_server)
    Animation()
    SetDisplay(false)
    name = name_server
    job = job_server
end)

--MOVE
RegisterCommand("bodycam", function(source, args)
    if bodycam then
        SetDisplay(not display)
    end
end, false)

--MOVING DISABLE
CreateThread(function()
    while display do
        Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

--TIME UPDATE
CreateThread(function()
    while true do
        local sleep = 2500
        if bodycam then
            sleep = 500
            local year, month, day, hour, minute, second = GetLocalTime()
            if string.len(tostring(minute)) < 2 then
                minute = '0' .. minute
            end
            if string.len(tostring(second)) < 2 then
                second = '0' .. second
            end
            if string.len(tostring(month)) < 2 then
                month = '0' .. month
            end
            if string.len(tostring(day)) < 2 then
                day = '0' .. day
            end
            SendNUIMessage({
                action = "update",
                name = name,
                job = job,

                date = year .. '-' .. month .. '-' .. day .. ' T' .. hour .. ':' .. minute .. ':' .. second .. "Z",
            })
        end
        Wait(sleep)
    end
end)

local animation = false
--Animation
function Animation()
    if not bodycam then
        text = locale("turningonbodycam")
    else
        text = locale("turningoffbodycam")
    end
    if not animation then
        animation = true
        RequestAnimDict("clothingtie")
        while (not HasAnimDictLoaded("clothingtie")) do Wait(0) end
        TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_negative_a', 8.0, -8, -1, 49, 0, 0, 0, 0)
        ProgressBar(1500, text)
        animation = false
        ClearPedTasks(cache.ped)
        if not bodycam then
            bodycam = true
            SendNUIMessage({ action = "loadui" })
            Notify("success", locale("bodycamon"), locale("bodycamondesc"))
        else
            bodycam = false
            SendNUIMessage({ action = "closeui" })
            Notify("success", locale("success"), locale("bodycamoff"))
        end
    end
end
