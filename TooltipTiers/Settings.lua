local _, Settings = ...

Settings:RegisterSettings("TooltipTiersDB", {
	{
		key = "colorRank",
		type = "toggle",
		title = "Color Rank in Tooltip",
		tooltip = "Enable this option to color the rank of the item in the tooltip.",
		default = false,
	},
	{
		key = "colorRange",
		type = "toggle",
		title = "Color Item Level Range",
		tooltip = "Enable this option to color the item level range in the tooltip.",
		default = false,
	},
	{
		key = "showUpgradeCurrency",
		type = "toggle",
		title = "Show Upgrade Currency",
		tooltip = "Enable this option to display the required crests for item upgrades in the tooltip.",
		default = false,
	},
	{
		key = "ilvlRangeColor",
		type = "color",
		title = "Item Level Range Color",
		tooltip = "Choose the color for the item level range display in the tooltip.",
		default = "FF00FF00",
	},
})

Settings:RegisterSettingsSlash("/ttt")

function Settings:OnLoad()
	if not TooltipTiersDB then
		-- set default
		TooltipTiersDB = CopyTable(TooltipTiersDB)
	end
end
