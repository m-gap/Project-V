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
		["data"] = Card.new("Strike", 15, {"Default", "Attack"}, 1, nil),
		["text"] = "Deal 6 damage."
	},
	["Block"] = {
		["action"] = function(sender, target)
			sender.changeDefence(5)
		end,
		["data"] = Card.new("Block", 10, {"Default", "Defence"}, 1, nil),
		["text"] = "Gain 5 defence."
	}
}

function M.get(name) 
	return cardData[name]
end

return M

