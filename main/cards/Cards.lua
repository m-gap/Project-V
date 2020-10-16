		-- URL main.cards.Cards

local M = {}

local cards = {
	["Block"] = {
		["cardBaseWeight"] = 10,
		["cardType"] = {"Defence"},
		["vigourRequirement"] = 1,
		["cardAction"] = function (sender)
			M.applyDefence(sender, 5)
		end
	},
	["Bludgeon"] = {
		["cardBaseWeight"] = 30,
		["cardType"] = {"Attack"},
		["vigourRequirement"] = 2,
		["cardAction"] = function (target)
			M.damage(target, 15)
		end
	},
	["Defend"] = {
		["cardBaseWeight"] = 30,
		["cardType"] = {"Attack"},
		["vigourRequirement"] = 2,
		["cardAction"] = function (sender)
			M.applyDefence(sender, 10)
		end
	},
	["Focus"] = {
		["cardBaseWeight"] = 20,
		["cardType"] = {"Vigour"},
		["vigourRequirement"] = 0,
		["cardAction"] = function (sender)
			M.applyVigour(sender, 1)
		end
	},
	["Parry"] = {
		["cardBaseWeight"] = 40,
		["cardType"] = {"Attack", "Defence"},
		["vigourRequirement"] = 0,
		["cardAction"] = function (sender, target)
			M.damage(target, 7)
			M.applyDefence(sender, 5)
		end
	},
	["Search"] = {
		["cardBaseWeight"] = 10,
		["cardType"] = {"Draw"},
		["vigourRequirement"] = 0,
		["cardAction"] = function (target)
			M.applyVigour(target, 1)
		end
	},
	["Strike"] = {
		["cardBaseWeight"] = 15,
		["cardType"] = {"Attack"},
		["vigourRequirement"] = 0,
		["cardAction"] = function (target)
			M.applyVigour(target, 1)
		end
	}
}

-- {"Card Name", activeNum, inactiveNum}
local playerDeck = {
	{"Strike", 2, 0},
	{"Block", 2, 0}
}
--[[name: string target: URL args: table of arguments ]]

function M.applyDefence(target, defence)

end

function M.applyVigour(target, vigour)

end

function M.cedeTurn(target)

end
	
function M.damage(target, amount) 

end

function M.deploy(target, cardName, args)
--	cards[cardName](target, args)
end

function M.draw(target, number) 

end

function M.getCard(cardName)
	return cards[cardName]
end

function M.shuffle(target)

end

function M.effect(target, effect, level)

end




return M