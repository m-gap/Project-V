local M = {}
local Player = require "main.cards.classes.Player"
local Deck = require "main.cards.classes.Deck"


function M.new(name, currentHP, maxHP, textureName, mana, defence, effects, inventory)
	local self = Player.new(currentHP, maxHP, defence, effects)

	self.name = name
	self.textureName = textureName
	self.card_inventory = inventory

	self.deck = Deck.new()
	self.deck.addCards(self.card_inventory)
	self.deck.shuffle()

	self.effects = effects
	
	self.hand = self.deck.draw(5)

	self.mana.current = mana 
	self.mana.max = mana
	
	return self
end

return M