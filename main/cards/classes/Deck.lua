local M = {}
local Card = require "main.cards.classes.Card"

function M.new()
	local self = {}
	self.cards = {}

	function self.addCard(card)
		table.insert(self.cards, card)
	end

	function self.addCards(cards)
		for index, cardType in pairs(cards) do
			for i = 1, cardType[2] do
				table.insert(self.cards, cardType[1])
			end
		end

	end

	function self.draw(amount)
		local drawn = {}
		for i = 1, amount do
			table.insert(drawn, self.cards[i])
		end

		for i = 1, amount do 
			table.remove(self.cards, 1)
		end
		
		return drawn
	end

	function self.getAllCards()
		return self.cards
	end

	function self.getCards(amount)
		local drawn = {}
		for i = 1, amount do
			table.insert(drawn, self.cards[i])
		end

		return drawn
	end

	function self.removeCard(index)
		table.remove(self.cards, index)
	end

	function self.removeCards(cardId, firstOnly)
		for index, cardType in pairs(self.cards) do
			if cardType.data.name == cardId then
				table.remove(self.cards, index)

				if firstOnly == true then
					return
				end
			end
		end
	end

	function self.shuffle()
		math.randomseed(os.time()+math.random(1, 100))
		local shuffled = {}
		for i, v in ipairs(self.cards) do
			local pos = math.random(1, #shuffled+1)
			table.insert(shuffled, pos, v)
		end

		self.cards = shuffled
	end

	return self
end

return M