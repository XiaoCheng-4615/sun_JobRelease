

function HandleJobOrder(xPlayer, zPlayer, zPlayerId)
    if zPlayer then
        NotifyAllPlayers('^3職業接單通知: ^0[ ' .. xPlayer.job.label .. ' ] ' .. xPlayer.name, zPlayer.name, zPlayerId)
        -- 公頻輸出 職業接單通知 [警局] 接單者名稱 被接單者名稱  被接單者ID
        local coords = zPlayer.getCoords(true)
        TriggerClientEvent('sun_JobRelease:sumbit', source, coords, xPlayer)
        NotifyzPlayer(zPlayerId, xPlayer.name)
        SendToDiscord(xPlayer, zPlayer, zPlayerId)
    else
        NotifyPlayer(source, "找不到玩家")
    end
end


function NotifyPlayer(playerId, message) --通知 接單者
    TriggerClientEvent("chatMessage", playerId, message)
    if Config.usepNotify then
        TriggerClientEvent("pNotify:SendNotification", playerId, {
            text = "<b style='color:ORANGE'>" .. message .. "",
            type = "error",
            queue = "lmao",
            timeout = '3000',
            layout = "bottomCenter"
        })
    end
end

function NotifyzPlayer(playerId, name) --通知 被接單者

    if Config.usepNotify then
        TriggerClientEvent("pNotify:SendNotification", playerId, {
            text = "你已被 <b style='color:ORANGE'>" .. name .. " <b style='color:BLUELIGHT'>接單 ID:<b style='color:YELLOW'>" .. playerId .. "",
            type = "info",
            queue = "lmao",
            timeout = '3000',
            layout = "bottomCenter"
        })
    end
end

function NotifyAllPlayers(message1, playerName, playerId) --通知 全部人
    TriggerClientEvent("chatMessage", -1, message1, { 255, 0, 0 }, '已接單 ID ' .. playerId .. ' (' .. playerName .. ')')
end

function SendToDiscord(xPlayer, zPlayer, zPlayerId)
    local message = '```' .. os.date("%Y.%m.%d - %H:%M:%S") .. '職業: ' .. xPlayer.job.label .. '\n接單人: ' .. xPlayer.name .. '(' .. source .. ')' .. xPlayer.identifier .. ' \n打單者: ' .. zPlayer.name .. '(' .. zPlayerId .. ')' .. zPlayer.identifier .. '```'
    SendToDiscordChannel('各公職接單', message)
end
