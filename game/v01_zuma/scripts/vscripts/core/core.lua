require("lib/utils")
require("game_settings")
require("lib/enum")
require("core/event")

function Initialize(bReload)
	_G.Activated = true
	_G.iLoad = (_G.iLoad or 0) + 1
    require("game/line_system")
    GameSettings:init(bReload)
	CheckPerformance()
end

---性能相关监测
function CheckPerformance()
	if IsInToolsMode() then
		_G._CreateModifierThinker = _G._CreateModifierThinker or _G.CreateModifierThinker
		_G.CreateModifierThinker = function(hUnit, hAblt, sModifier, ...)
			local hThinker = _G._CreateModifierThinker(hUnit, hAblt, sModifier, ...)
			hThinker.sModifierName = sModifier
			local hBuff = hThinker:FindModifierByName(sModifier)
			local tDebugInfo = debug.getinfo(2)
			hThinker.tDebugInfo = tDebugInfo
			return hThinker
		end

		GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("collectgarbage"), function()
			local m = collectgarbage('count')
			print(string.format("[Lua Memory]  %.3f KB  %.3f MB", m, m / 124))
			print(string.format("[Hashtable Count]  %d", HashtableCount()))
			local tThinkers = Entities:FindAllByName("npc_dota_thinker")
			print(string.format("[Thinker Count]  %d", #tThinkers))
			for i = #tThinkers, 1, -1 do
				local hThinker = tThinkers[i]
				local tModifiers = hThinker:FindAllModifiers()
				if hThinker.tDebugInfo then
					-- print("[Thinker Info]", hThinker.sModifierName, hThinker.tDebugInfo.currentline, hThinker.tDebugInfo.source)
				end
			end
			return 30
		end, 0)
	else
		GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("collectgarbage"), function()
			local m = collectgarbage('count')
			print(string.format("[Lua Memory]  %.3f KB  %.3f MB", m, m / 1024))
			print(string.format("[Hashtable Count]  %d", HashtableCount()))
			local tThinkers = Entities:FindAllByName("npc_dota_thinker")
			print(string.format("[Thinker Count]  %d", #tThinkers))
			for i = #tThinkers, 1, -1 do
				local hThinker = tThinkers[i]
				local tModifiers = hThinker:FindAllModifiers()
				if #tModifiers == 0 then
					UTIL_Remove(hThinker)
					table.remove(tThinkers, i)
				end
			end
			return 60
		end, 0)
	end
end