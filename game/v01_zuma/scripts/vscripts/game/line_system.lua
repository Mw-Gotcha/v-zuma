if LineSystem == nil then
    LineSystem = {}
end
local public = LineSystem
function public:OnLineStart(bReload)
    
end

---通过随机的卷轴生成球的队列 
---@param iScrollLength 卷轴长度
---@param iMaxLength 连续球的最大长度
---@param iMinLength 连续球的最小长度
---@param iColorNum 球的颜色种类
---@return table 一维数组 对应的数字代表颜色
function public:GenerateBallScroll(iScrollLength, iMaxLength, iMinLength, iColorNum)
    if not iScrollLength then return end
    if iMaxLength < iMinLength then return end
    iMaxLength = iMaxLength or 10
    iMinLength = iMinLength or 2
    iColorNum = iColorNum or 3
    local tScroll = {}
    print("GenerateBallScroll")
    for i = 0, iScrollLength do
        tScroll[i] = RandomInt(0, iColorNum)
    end
    DeepPrintTable(tScroll)
end

---通过队列生成球
---@param tScroll 随机卷轴表
---@param tPath 路径表 包括入口和出口
---@param fBallSpeed 球的行进速度
---@param iPlayerID 玩家编号
function public:GenerateBallByScroll(tScroll, tPath, fBallSpeed, iPlayerID)
    if not iPlayerID then iPlayerID = 0 end
    local sBallName = "zuma_ball"
    local vStartLocation = tPath[0]
    local vEndLocation = tPath[-1]
    CreateUnitByName(sBallName, )

end

function public:OnBallPop()
    
end

LineSystem:GenerateBallScroll(10,5,3,3)

return public