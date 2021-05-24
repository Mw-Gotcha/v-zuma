--游戏事件
if nil == ET_GAME then
	---@class ET_GAME 游戏事件
	ET_GAME = {
		GAME_READY = enumid(0), --游戏准备阶段（玩家位于出生岛）
		MODS_LOADOVER = enumid(), --游戏模块加载完成
		GAME_BALANCE = enumid(), --游戏结算
		GAME_END = enumid(100), --游戏结束
	}
	enum_unique(ET_GAME)
end

--战斗流程事件
if nil == ET_BATTLE then
	---@class ET_BATTLE 战斗流程事件
	ET_BATTLE = {
		ON_PREPARATION = enumid(0), --备战
		ON_PREPARATION_END = enumid(), --备战阶段 结束
		ON_BATTLEING = enumid(), --战斗
		ON_BATTLEING_END = enumid(), --战斗阶段 结束
		ON_BOSS_BOMB = enumid(), --BOSS爆炸
		ON_BATTLEING_ENDWAIT_START = enumid(), --战斗结束等待阶段 开始
		ON_BATTLEING_ENDWAIT_END = enumid(), --战斗结束等待阶段 结束
	}
	enum_unique(ET_BATTLE)
end

--玩家事件
if nil == ET_PLAYER then
	---@class ET_PLAYER 玩家事件
	ET_PLAYER = {
		-- ALL_LOADED_FINISHED = enumid(0), --全玩家加载完成
		ON_LOADED_FINISHED = enumid(1), --玩家加载完成
		ON_DAMAGE = enumid(), --玩家受到伤害
		ON_DEATH = enumid(), --玩家死亡
		ENEMY_COUNT_CHANGE = enumid(), --玩家怪物数量更新
		ROUND_RESULT = enumid(), --玩家当前回合胜负结果通知
		LEVEL_CHANGED = enumid(), --玩家升级人口改变
		CONNECT_STATE_CHANGE = enumid(), -- 连接状态改变
		ON_PLAYER_HERO_SPAWNED = enumid(), --玩家信使英雄生成

	}
	enum_unique(ET_PLAYER)
end

--怪物事件
if nil == ET_ENEMY then
	---@class ET_ENEMY 怪物事件
	ET_ENEMY = {
		ON_SPAWNED = enumid(0), --怪物出生
		ON_DEATH = enumid(), --进攻怪物死亡
	}
	enum_unique(ET_ENEMY)
end