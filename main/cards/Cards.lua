-- URL main.cards.Cards
local playerDeck = {}

local M = {}

local cards = {
	Punch = function (target)
		-- Do 3 damage to the opponent
		-- damage(3, target) 
		print ("punched")
	end, 
}
--[[
	name: string
	target: URL
	args: table of arguments
]]

function M.activate(cardName, target, args)
	cards[cardName](target, args)
end


local function damage(amount, target)
	--fun damage is done
end

return M