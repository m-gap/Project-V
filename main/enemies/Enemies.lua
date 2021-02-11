local Enemy = require "main.cards.classes.Enemy"
local Card = require "main.cards.classes.Card"

local M = {}
local enemies = {}

enemies["Keeper"] = function()
	local inventory = {
		{Card.get("Strike"), 4},
	}

	local self = Enemy.new("Keeper of Cards", 75, 75, "keeper", 3, 2, {""}, inventory)
	self.prefix = "Enemy"
	
	function self.playCard()
		return 1, self.hand[1]
	end

	return self
end

function M.get(enemyId)
	return enemies[enemyId]()
end

return M
