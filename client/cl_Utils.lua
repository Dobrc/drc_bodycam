lib.locale()

if Config.Framework == "ESX" then
    ESX = nil
    CreateThread(function()
        while ESX == nil do
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
            Wait(100)
        end
    end)
elseif Config.Framework == "qbcore" then
    QBCore = nil
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "standalone" then
    -- ADD YOU FRAMEWORK
end

RegisterNetEvent('drc_bodycam:notify')
AddEventHandler('drc_bodycam:notify', function(type, title, text)
    Notify(type, title, text)
end)

-- Your notification type settings
-- •» You can edit a type of notifications, with chaning type or triggering your own.
Notify = function(type, title, text)
    if Config.NotificationType == "ESX" then
        ESX.ShowNotification(text)
    elseif Config.NotificationType == "ox_lib" then
        if type == "info" then
            lib.notify({
                title = title,
                description = text,
                type = "inform"
            })
        elseif type == "error" then
            lib.notify({
                title = title,
                description = text,
                type = "error"
            })
        elseif type == "success" then
            lib.notify({
                title = title,
                description = text,
                type = "success"
            })
        elseif Config.NotificationType == "qbcore" then
            if type == "success" then
                QBCore.Functions.Notify(text, "success")
            elseif type == "info" then
                QBCore.Functions.Notify(text, "primary")
            elseif type == "error" then
                QBCore.Functions.Notify(text, "error")
            end
        elseif Config.NotificationType == "custom" then
            print("add your notification system! in cl_Utils.lua")
            -- ADD YOUR NOTIFICATION | TYPES ARE info, error, success
        end
    end
end

ProgressBar = function(duration, label)
    if Config.Progress == "ox" then
        lib.progressBar({
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = false
        })
    elseif Config.Progress == "qbcore" then
        QBCore.Functions.Progressbar(label, label, duration, false, true, {
        }, {}, {}, {}, function()
        end)
        Wait(duration)
    elseif Config.Progress == "progressBars" then
        exports['progressBars']:startUI(duration, label)
        Wait(duration)
    end
end
