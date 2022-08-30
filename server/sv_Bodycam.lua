if Config.Framework == "ESX" then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    RegisterUsable = ESX.RegisterUsableItem
elseif Config.Framework == "qbcore" then
    QBCore = exports['qb-core']:GetCoreObject()
    RegisterUsable = QBCore.Functions.CreateUseableItem
end

RegisterUsable('bodycam', function(source)
    job = nil
    found = false
    local src = source
    if Config.Framework == "ESX" then
        xPlayer = ESX.GetPlayerFromId(src)
    elseif Config.Framework == "qbcore" then
        xPlayer = QBCore.Functions.GetPlayer(src)
    end
    for k, v in pairs(Config.PoliceJobs) do
        if Config.Framework == "ESX" then
            if xPlayer.job.name == k then
                if v.Shortcut then
                    job = v.Shortcut
                else
                    job = xPlayer.job.name
                end
                firstname = xPlayer.get('firstName')
                lastname = xPlayer.get('lastName')
                table = Config.PoliceJobs[k].Grades
                for _, v in pairs(table) do
                    if xPlayer.job.grade == v.GradeNumber then
                        grade = v.Shortcut
                        found = true
                    end
                end
                if not found then
                    grade = xPlayer.job.grade_label
                end
            end
        elseif Config.Framework == "qbcore" then
            if xPlayer.PlayerData.job.name == k then
                if v.Shortcut then
                    job = v.Shortcut
                else
                    job = xPlayer.PlayerData.job.name
                end
                firstname = xPlayer.PlayerData.charinfo.firstname
                lastname = xPlayer.PlayerData.charinfo.lastname
                table = Config.PoliceJobs[k].Grades
                for _, v in pairs(table) do
                    if xPlayer.PlayerData.job.grade.level == v.GradeNumber then
                        grade = v.Shortcut
                        found = true
                    end
                end
                if not found then
                    grade = QBCore.Shared.Jobs[xPlayer.PlayerData.job.name].label
                end

            end
        end
    end
    if xPlayer then
        if job then
            TriggerClientEvent('rx_bodycam:show', src, firstname .. ' ' .. lastname, job .. ' RANK: ' .. grade)
        else
            TriggerClientEvent("drc_bodycam:notify", source, "error", locale("error"), locale("invalidjob"))
        end
    end
end)
