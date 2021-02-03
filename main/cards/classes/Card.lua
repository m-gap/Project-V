local M = {}
local Card = {}

function Card.new(name, baseWeight, type, mana, image) 
	local self = {}

	self.name = name
	self.baseWeight = baseWeight
	self.type = type
	self.mana = mana
	self.image = image

	return self
end

local cardData = {
	["Strike"] = {
		["action"] = function(sender, target)
			target.damage(6, sender)
		end,
		["data"] = Card.new("Strike", 15, {"Attack", "General"}, 1, nil)
	},
	["Block"] = {
		["action"] = function(sender, target)
			target.changeDefence(5)
		end,
		["data"] = Card.new("Block", 10, {"Defence", "General"}, 1, nil)
	}
}

function M.get(name) 
	return cardData[name]
end

return M

