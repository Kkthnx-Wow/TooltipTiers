local _, Module = ...

local _G = _G

local GetLocale = _G.GetLocale
local GetAchievementInfo = _G.GetAchievementInfo
local HEIRLOOM_BLUE_COLOR = _G.HEIRLOOM_BLUE_COLOR
local UNCOMMON_GREEN_COLOR = _G.UNCOMMON_GREEN_COLOR
local RARE_BLUE_COLOR = _G.RARE_BLUE_COLOR
local ITEM_EPIC_COLOR = _G.ITEM_EPIC_COLOR
local ITEM_LEGENDARY_COLOR = _G.ITEM_LEGENDARY_COLOR
local ITEM_POOR_COLOR = _G.ITEM_POOR_COLOR
local WHITE_FONT_COLOR = _G.WHITE_FONT_COLOR

local ilvlRangeColorValue
Module:RegisterOptionCallback("ilvlRangeColor", function(value)
	ilvlRangeColorValue = value
end)

-- Constants and Crest Definitions
local CRESTS = {
	[0] = { minLevel = 558, maxLevel = 580, shortName = "Valorstones", color = HEIRLOOM_BLUE_COLOR },
	[1] = { minLevel = 584, maxLevel = 593, shortName = "Weathered", color = UNCOMMON_GREEN_COLOR, achieve = 40107 },
	[2] = { minLevel = 597, maxLevel = 606, shortName = "Carved", color = RARE_BLUE_COLOR, achieve = 40115 },
	[3] = { minLevel = 610, maxLevel = 619, shortName = "Runed", color = ITEM_EPIC_COLOR, achieve = 40118 },
	[4] = { minLevel = 623, maxLevel = 629, shortName = "Gilded", color = ITEM_LEGENDARY_COLOR },
}

local UPGRADE_BONUSES = {
	{ id = 10289, level = 1, max = 8, name = "Explorer", ilvl = 558, crest = CRESTS[0] },
	{ id = 10288, level = 2, max = 8, name = "Explorer", ilvl = 561, crest = CRESTS[0] },
	{ id = 10287, level = 3, max = 8, name = "Explorer", ilvl = 564, crest = CRESTS[0] },
	{ id = 10286, level = 4, max = 8, name = "Explorer", ilvl = 567, crest = CRESTS[0] },
	{ id = 10285, level = 5, max = 8, name = "Explorer", ilvl = 571, crest = CRESTS[0] },
	{ id = 10284, level = 6, max = 8, name = "Explorer", ilvl = 574, crest = CRESTS[0] },
	{ id = 10283, level = 7, max = 8, name = "Explorer", ilvl = 577, crest = CRESTS[0] },
	{ id = 10282, level = 8, max = 8, name = "Explorer", ilvl = 580 },
	{ id = 10297, level = 1, max = 8, name = "Adventurer", ilvl = 571, crest = CRESTS[0] },
	{ id = 10296, level = 2, max = 8, name = "Adventurer", ilvl = 574, crest = CRESTS[0] },
	{ id = 10295, level = 3, max = 8, name = "Adventurer", ilvl = 577, crest = CRESTS[0] },
	{ id = 10294, level = 4, max = 8, name = "Adventurer", ilvl = 580, crest = CRESTS[1] },
	{ id = 10293, level = 5, max = 8, name = "Adventurer", ilvl = 584, crest = CRESTS[1] },
	{ id = 10292, level = 6, max = 8, name = "Adventurer", ilvl = 587, crest = CRESTS[1] },
	{ id = 10291, level = 7, max = 8, name = "Adventurer", ilvl = 590, crest = CRESTS[1] },
	{ id = 10290, level = 8, max = 8, name = "Adventurer", ilvl = 593 },
	{ id = 10281, level = 1, max = 8, name = "Veteran", ilvl = 584, crest = CRESTS[1] },
	{ id = 10280, level = 2, max = 8, name = "Veteran", ilvl = 587, crest = CRESTS[1] },
	{ id = 10279, level = 3, max = 8, name = "Veteran", ilvl = 590, crest = CRESTS[1] },
	{ id = 10278, level = 4, max = 8, name = "Veteran", ilvl = 593, crest = CRESTS[2] },
	{ id = 10277, level = 5, max = 8, name = "Veteran", ilvl = 597, crest = CRESTS[2] },
	{ id = 10276, level = 6, max = 8, name = "Veteran", ilvl = 600, crest = CRESTS[2] },
	{ id = 10275, level = 7, max = 8, name = "Veteran", ilvl = 603, crest = CRESTS[2] },
	{ id = 10274, level = 8, max = 8, name = "Veteran", ilvl = 606 },
	{ id = 10273, level = 1, max = 8, name = "Champion", ilvl = 597, crest = CRESTS[2] },
	{ id = 10272, level = 2, max = 8, name = "Champion", ilvl = 600, crest = CRESTS[2] },
	{ id = 10271, level = 3, max = 8, name = "Champion", ilvl = 603, crest = CRESTS[2] },
	{ id = 10270, level = 4, max = 8, name = "Champion", ilvl = 606, crest = CRESTS[3] },
	{ id = 10269, level = 5, max = 8, name = "Champion", ilvl = 610, crest = CRESTS[3] },
	{ id = 10268, level = 6, max = 8, name = "Champion", ilvl = 613, crest = CRESTS[3] },
	{ id = 10267, level = 7, max = 8, name = "Champion", ilvl = 616, crest = CRESTS[3] },
	{ id = 10266, level = 8, max = 8, name = "Champion", ilvl = 619 },
	{ id = 10265, level = 1, max = 6, name = "Hero", ilvl = 610, crest = CRESTS[3] },
	{ id = 10264, level = 2, max = 6, name = "Hero", ilvl = 613, crest = CRESTS[3] },
	{ id = 10263, level = 3, max = 6, name = "Hero", ilvl = 616, crest = CRESTS[3] },
	{ id = 10262, level = 4, max = 6, name = "Hero", ilvl = 619, crest = CRESTS[4] },
	{ id = 10261, level = 5, max = 6, name = "Hero", ilvl = 623, crest = CRESTS[4] },
	{ id = 10256, level = 6, max = 6, name = "Hero", ilvl = 626 },
	{ id = 10260, level = 1, max = 6, name = "Myth", ilvl = 623, crest = CRESTS[4] },
	{ id = 10259, level = 2, max = 6, name = "Myth", ilvl = 626, crest = CRESTS[4] },
	{ id = 10258, level = 3, max = 6, name = "Myth", ilvl = 629, crest = CRESTS[4] },
	{ id = 10257, level = 4, max = 6, name = "Myth", ilvl = 632 },
	{ id = 10298, level = 5, max = 6, name = "Myth", ilvl = 636 },
	{ id = 10299, level = 6, max = 6, name = "Myth", ilvl = 639 },

	-- { id = 10407, level = 1, max = 12, name = "Awakened", ilvl = 493, crest = CRESTS[2] },
	-- { id = 10408, level = 2, max = 12, name = "Awakened", ilvl = 496, crest = CRESTS[2] },
	-- { id = 10409, level = 3, max = 12, name = "Awakened", ilvl = 499, crest = CRESTS[2] },
	-- { id = 10410, level = 4, max = 12, name = "Awakened", ilvl = 502, crest = CRESTS[2] },
	-- { id = 10411, level = 5, max = 12, name = "Awakened", ilvl = 506, crest = CRESTS[3] },
	-- { id = 10412, level = 6, max = 12, name = "Awakened", ilvl = 509, crest = CRESTS[3] },
	-- { id = 10413, level = 7, max = 12, name = "Awakened", ilvl = 512, crest = CRESTS[3] },
	-- { id = 10414, level = 8, max = 12, name = "Awakened", ilvl = 515, crest = CRESTS[3] },
	-- { id = 10415, level = 9, max = 12, name = "Awakened", ilvl = 519, crest = CRESTS[4] },
	-- { id = 10416, level = 10, max = 12, name = "Awakened", ilvl = 522, crest = CRESTS[4] },
	-- { id = 10417, level = 11, max = 12, name = "Awakened", ilvl = 525, crest = CRESTS[4] },
	-- { id = 10418, level = 12, max = 12, name = "Awakened", ilvl = 528, crest = CRESTS[4] },
	-- -- Rare Awakened Drops go to 1/14
	-- { id = 10490, level = 1, max = 14, name = "Awakened+", ilvl = 493, crest = CRESTS[2] },
	-- { id = 10491, level = 2, max = 14, name = "Awakened+", ilvl = 496, crest = CRESTS[2] },
	-- { id = 10492, level = 3, max = 14, name = "Awakened+", ilvl = 499, crest = CRESTS[2] },
	-- { id = 10493, level = 4, max = 14, name = "Awakened+", ilvl = 502, crest = CRESTS[2] },
	-- { id = 10494, level = 5, max = 14, name = "Awakened+", ilvl = 506, crest = CRESTS[3] },
	-- { id = 10495, level = 6, max = 14, name = "Awakened+", ilvl = 509, crest = CRESTS[3] },
	-- { id = 10496, level = 7, max = 14, name = "Awakened+", ilvl = 512, crest = CRESTS[3] },
	-- { id = 10497, level = 8, max = 14, name = "Awakened+", ilvl = 515, crest = CRESTS[3] },
	-- { id = 10498, level = 9, max = 14, name = "Awakened+", ilvl = 519, crest = CRESTS[4] },
	-- { id = 10499, level = 10, max = 14, name = "Awakened+", ilvl = 522, crest = CRESTS[4] },
	-- { id = 10500, level = 11, max = 14, name = "Awakened+", ilvl = 525, crest = CRESTS[4] },
	-- { id = 10501, level = 12, max = 14, name = "Awakened+", ilvl = 528, crest = CRESTS[4] },
	-- { id = 10502, level = 13, max = 14, name = "Awakened+", ilvl = 532, crest = CRESTS[4] },
	-- { id = 10503, level = 14, max = 14, name = "Awakened+", ilvl = 535, crest = CRESTS[4] },
}

local UPGRADE_TIERS = {
	Explorer = { minLevel = 558, maxLevel = 580, color = ITEM_POOR_COLOR },
	Adventurer = { minLevel = 571, maxLevel = 593, color = WHITE_FONT_COLOR },
	Veteran = { minLevel = 584, maxLevel = 606, color = UNCOMMON_GREEN_COLOR },
	Champion = { minLevel = 597, maxLevel = 619, color = RARE_BLUE_COLOR },
	Hero = { minLevel = 610, maxLevel = 626, color = ITEM_EPIC_COLOR },
	Myth = { minLevel = 623, maxLevel = 639, color = ITEM_LEGENDARY_COLOR },
	-- Awakened = { minLevel = 493, maxLevel = 528, color = ITEM_ARTIFACT_COLOR },
	-- ["Awakened+"] = { minLevel = 493, maxLevel = 535, color = ITEM_ARTIFACT_COLOR },
}

-- SetValueToKey function to manipulate the list based on given criteria
local function SetValueToKey(list, field, valuesArray)
	local newList = {}
	for _, v in ipairs(list) do
		local key = v
		local data = true
		if field then
			key = v[field]
		end

		if tonumber(key) then
			key = tonumber(key)
		end

		if valuesArray then
			data = v
		end

		newList[key] = data
	end

	return newList
end

UPGRADE_BONUSES = SetValueToKey(UPGRADE_BONUSES, "id", true)

-- Locale patterns for matching tooltip text across different languages
local localePatterns = {
	["enUS"] = "(%a+) (%d+)/(%d+)$",
	["koKR"] = "(.+): (.+) (%d+)/(%d+)$",
	["frFR"] = "(%a+) (%d+)/(%d+)$",
	["deDE"] = "(%a+) (%d+)/(%d+)$",
	["zhCN"] = "(.+) (%d+)/(%d+)$",
	["esES"] = "(%a+) (%d+)/(%d+)$",
	["zhTW"] = "(.+) (%d+)/(%d+)$",
	["esMX"] = "(%a+) (%d+)/(%d+)$",
	["ruRU"] = "(.+): (.+) (%d+)/(%d+)$",
	["ptBR"] = "(%a+) (%d+)/(%d+)$",
	["itIT"] = "(%a+) (%d+)/(%d+)$",
}

-- Function to get rank information from the tooltip text based on locale
local function GetRankInfoByLocale(text, locale)
	local tier, current, total, _
	if locale == "ruRU" or locale == "koKR" then
		_, tier, current, total = text:match(localePatterns[locale])
	elseif locale == "zhCN" or locale == "zhTW" then
		tier, current, total = text:match(localePatterns[locale])
	else
		tier, current, total = text:match(localePatterns["enUS"])
	end

	return tier, current, total
end

-- Tries to get rank info from the tooltip text by comparing current rank and item level
local function GetRankInfo(item, text, locale)
	local tier, current, total, bonusID = GetRankInfoByLocale(text, locale)
	if tier and current and total and not UPGRADE_TIERS[tier] then
		for _, v in pairs(UPGRADE_BONUSES) do
			if v.level == tonumber(current) and v.max == tonumber(total) and v.ilvl == item:GetCurrentItemLevel() then
				tier = v.name
				current = v.level
				total = v.max
				bonusID = v.id
			end
		end
	end

	return tier, current, total, bonusID
end

-- Function to convert the hex color to RGBA
local function HexToRGBA(hex)
	-- Check if the hex string has the alpha component
	if #hex == 8 then
		local a = tonumber(hex:sub(1, 2), 16) / 255
		local r = tonumber(hex:sub(3, 4), 16) / 255
		local g = tonumber(hex:sub(5, 6), 16) / 255
		local b = tonumber(hex:sub(7, 8), 16) / 255
		return r, g, b, a
	elseif #hex == 6 then
		local r = tonumber(hex:sub(1, 2), 16) / 255
		local g = tonumber(hex:sub(3, 4), 16) / 255
		local b = tonumber(hex:sub(5, 6), 16) / 255
		return r, g, b, 1
	else
		return 1, 1, 1, 1
	end
end

-- Function to process tooltip data
local function ProcessTooltip(tooltip)
	local _, itemLink = TooltipUtil.GetDisplayedItem(tooltip)
	if not itemLink then
		return
	end

	-- Create ItemMixin from itemLink
	local item = Item:CreateFromItemLink(itemLink)
	if item:IsItemEmpty() then
		return
	end

	local itemLevel = item:GetCurrentItemLevel()
	if itemLevel < 558 then
		return
	end

	-- Create bonusIDs table from item
	local itemLinkValues = StringSplitIntoTable(":", itemLink)
	local numBonusIDs = itemLinkValues[14]
	if not tonumber(numBonusIDs) then
		return
	end

	local bonusIDs = { unpack(itemLinkValues, 15, 15 + numBonusIDs - 1) }
	bonusIDs = SetValueToKey(bonusIDs)

	-- Match bonusID to UPGRADE_BONUSES
	local bonusID = false
	for id in pairs(bonusIDs) do
		if UPGRADE_BONUSES[id] then
			bonusID = id
		end
	end

	-- Loop over current tooltip lines
	for i = 1, tooltip:NumLines() do
		local line = _G[tooltip:GetName() .. "TextLeft" .. i]
		local text = line:GetText()

		if text and text:match(localePatterns[GetLocale()]) then
			local tier, current, total
			if bonusID then
				tier = UPGRADE_BONUSES[bonusID].name
				current = UPGRADE_BONUSES[bonusID].level
				total = UPGRADE_BONUSES[bonusID].max
			else
				tier, current, total, bonusID = GetRankInfo(item, text, GetLocale())
			end

			if not tier or not current or not total then
				return
			end

			if tier == "Awakened" and itemLevel >= 532 then
				tier = "Awakened+"
			end

			if tier and not UPGRADE_TIERS[tier] then
				return
			end

			-- Modify Upgrade Rank tooltip line
			local minLevel = UPGRADE_TIERS[tier].minLevel
			local maxLevel = UPGRADE_TIERS[tier].maxLevel
			if minLevel and maxLevel and itemLevel >= minLevel and itemLevel <= maxLevel then
				local tierHexColorMarkup = ""
				local rangeHexColorMarkup = ""

				-- Customize color as per settings (you can modify this logic)
				if Module:GetOption("colorRange") then
					local r, g, b, a = HexToRGBA(ilvlRangeColorValue)
					rangeHexColorMarkup = CreateColor(r, g, b, a):GenerateHexColorMarkup()
				end

				if Module:GetOption("colorRank") then
					tierHexColorMarkup = UPGRADE_TIERS[tier].color:GenerateHexColorMarkup()
				end

				local newLineText = string.format("%s%d/%d %s|r %s(%d-%d)|r", tierHexColorMarkup, current, total, tier, rangeHexColorMarkup, minLevel, maxLevel)
				line:SetText(newLineText)
				line:Show()
			end

			-- Add Crest required to upgrade
			if bonusID and UPGRADE_BONUSES[bonusID].crest and Module:GetOption("showUpgradeCurrency") then
				local crest = UPGRADE_BONUSES[bonusID].crest
				if crest then
					local crestName = crest.shortName
					local crestName_colored = crest.color:WrapTextInColorCode(crestName)
					local achieve = crest.achieve and select(13, GetAchievementInfo(crest.achieve))
					local rightLineText = "|A:2329:20:20:1:-1|a" .. (not achieve and crestName_colored or "")
					local rightLine = _G[tooltip:GetName() .. "TextRight" .. i]
					rightLine:SetText(rightLineText)
					rightLine:Show()
				end
			end
		end
	end
end

-- Hook into the tooltip and process it
local function OnTooltipSetItem(tooltip)
	ProcessTooltip(tooltip)
end

-- Add event listener to the tooltip
function Module:PLAYER_LOGIN()
	if not self.tooltipHooked then
		self.tooltipHooked = true
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
	end
end
