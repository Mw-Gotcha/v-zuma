if GameSettings == nil then
	GameSettings = {}
end
local public = GameSettings

LIMIT_PATHING_SEARCH_DEPTH = 100

function public:Initialize(bReload)
    GameSettings:GameSetting(bReload)
    GameSettings:init(bReload)
    print("Initialize")
end

function public:GameSetting(bReload)
    if bReload == true then
        return
    end
end

function public:init(bReload)
    local GameMode = GameRules:GetGameModeEntity()
	LimitPathingSearchDepth(LIMIT_PATHING_SEARCH_DEPTH)
	GameRules:SetHeroRespawnEnabled(false)
	GameRules:SetSameHeroSelectionEnabled(true)
	GameRules:SetHeroSelectionTime(10)
	GameRules:SetHeroSelectPenaltyTime(10)
	GameRules:SetStrategyTime(0.5)
	GameRules:SetShowcaseTime(0)
	GameRules:SetPreGameTime(0)
	GameRules:SetPostGameTime(0)
	GameRules:SetTreeRegrowTime(10)
	GameRules:SetGoldPerTick(0)
	GameRules:SetGoldTickTime(0)
	GameRules:SetUseBaseGoldBountyOnHeroes(false)
	GameRules:SetFirstBloodActive(false)
	GameRules:SetHideKillMessageHeaders(true)
	GameRules:SetUseUniversalShopMode(false)
	GameRules:SetStartingGold(0)
	GameMode:SetSelectionGoldPenaltyEnabled(false)
	-- GameMode:SetUseCustomHeroLevels(true)
	GameMode:SetCustomGameForceHero("npc_dota_hero_phoenix")
	GameMode:SetWeatherEffectsDisabled(true)
	GameMode:SetAlwaysShowPlayerNames(false)
	GameMode:SetRecommendedItemsDisabled(true)
	GameMode:SetGoldSoundDisabled(true)
	GameMode:SetFogOfWarDisabled(false)
	GameMode:SetUnseenFogOfWarEnabled(false)
	GameMode:SetLoseGoldOnDeath(false)
	GameMode:SetCustomBuybackCooldownEnabled(true)
	GameMode:SetCustomBuybackCostEnabled(true)
	GameMode:SetStashPurchasingDisabled(true)
	GameMode:SetStickyItemDisabled(true)
	GameMode:SetDaynightCycleDisabled(false)
	GameMode:SetAnnouncerDisabled(true)
	GameMode:SetKillingSpreeAnnouncerDisabled(true)
	GameMode:SetPauseEnabled(true)
	-- GameMode:SetCameraZRange(0, 500)
	if IsInToolsMode() then
		GameRules:SetCustomGameSetupAutoLaunchDelay(0)
		GameRules:LockCustomGameSetupTeamAssignment(true)
		GameRules:EnableCustomGameSetupAutoLaunch(true)
		GameRules:SetStartingGold(0)
	else
		GameRules:SetCustomGameSetupAutoLaunchDelay(0)
		GameRules:LockCustomGameSetupTeamAssignment(true)
		GameRules:EnableCustomGameSetupAutoLaunch(true)
		GameMode:SetBuybackEnabled(false)
	end
end