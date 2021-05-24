if nil == PlayerData then
	---@class PlayerData
	PlayerData = {
	}
	PlayerData = class({}, PlayerData)
end
---@type PlayerData
local public = PlayerData

UI_INTERVAL = 0.5

function public:init(bReload)
	if not bReload then
		self.playerDatas = {}
		self.tConnectState = {}
		self.tPlayerHeroes = {}

	end
	-- 修改器类型

end

-- 游戏开始初始化玩家信息
function public:InitPlayerInfo(iPlayerID)
	GameTimer('PlayerData_ConnectionState' .. iPlayerID, 0, function()
		if self.tConnectState[iPlayerID] ~= PlayerResource:GetConnectionState(iPlayerID) then
			---@class EventData_CONNECT_STATE_CHANGE
			local tEvent = {
				PlayerID = iPlayerID,
				last_state = self.tConnectState[iPlayerID],
				state = PlayerResource:GetConnectionState(iPlayerID)
			}
			EventManager:fireEvent(ET_PLAYER.CONNECT_STATE_CHANGE, tEvent)
			self.tConnectState[iPlayerID] = PlayerResource:GetConnectionState(iPlayerID)


			if tEvent.state == DOTA_CONNECTION_STATE_ABANDONED then
				-- 放弃
				if PlayerData:IsAlive(iPlayerID) then
					PlayerData:ModifyHealth(iPlayerID, -PlayerData:GetHealth(iPlayerID))
				end
			elseif tEvent.state == DOTA_CONNECTION_STATE_DISCONNECTED then
				-- 断线
			end

			if tEvent.last_state == DOTA_CONNECTION_STATE_DISCONNECTED
			and tEvent.state == DOTA_CONNECTION_STATE_CONNECTED then
				-- 重新连接
				-- -run GameRules:SendCustomMessage(tostring(PlayerResource:GetTeam(0)), 0,0)
				-- -run GameRules:SendCustomMessage(tostring(PlayerResource:GetPlayer(0):GetTeam()), 0,0)
				-- -run GameRules:SendCustomMessage(tostring(PlayerResource:GetPlayerCountForTeam(2)), 0,0)
				-- -run GameRules:SendCustomMessage(tostring(PlayerData:GetHero(0):GetTeamNumber()), 0,0)
				-- -run ChangePlayerTeam(0,6)
				-- -run PlayerResource:SetCustomTeamAssignment(0, 6)
				-- -run GameRules:SetCustomGameTeamMaxPlayers(2, 1)
			end
		end

		local hHero = PlayerData:GetHero(iPlayerID)
		if IsValid(hHero) then
			local typeHeroTeam = hHero:GetTeamNumber()
			local hPlayer = PlayerResource:GetPlayer(iPlayerID)
			if IsValid(hPlayer) then
				local typePlayerTeam = hPlayer:GetTeam()
				if typeHeroTeam ~= typePlayerTeam then
					ChangePlayerTeam(iPlayerID, typeHeroTeam)
				end
			end
		end

		return 0.5
	end)
end

---玩家是否死亡
function public:IsPlayerDeath(iPlayerID)
	return self.playerDatas[iPlayerID] and 0 >= self.playerDatas[iPlayerID].health
end
function public:IsAlive(iPlayerID)
	return not public:IsPlayerDeath(iPlayerID)
end

---设置玩家英雄
function public:SetHero(iPlayerID, hHero)
	self.tPlayerHeroes[iPlayerID] = hHero
end
---获取玩家信使
function public:GetHero(iPlayerID)
	return self.tPlayerHeroes[iPlayerID] or PlayerResource:GetSelectedHeroEntity(iPlayerID)
end
---获取玩家英雄
function public:GetCourier(iPlayerID)
	return self.tPlayerHeroes[iPlayerID] or PlayerResource:GetSelectedHeroEntity(iPlayerID)
end
---获取玩家血量
function public:GetHealth(iPlayerID)
	return self.playerDatas[iPlayerID].health
end