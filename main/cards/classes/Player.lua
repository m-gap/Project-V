local M = {}
local Card = require "main.cards.classes.Card"
local Deck = require "main.cards.classes.Deck"

function M.new(currentHP, maxHP, defence, mana, effects)
	local self = {}

	-- temporary until saving system is implemented
	self.card_inventory = {
		{ Card.get("Strike"), 4 },
		{ Card.get("Block"), 3 }
	}

	self.hp = {}
	self.hp.current = currentHP
	self.hp.max = maxHP

	self.defence = defence

	self.deck = Deck.new()
	self.deck.addCards(self.card_inventory)
	self.deck.shuffle()

	self.effects = effects
	self.hand = self.deck.draw(5)
	pprint(self.hand)
	self.mana = {}
	self.mana.current = mana
	self.mana.max = mana
	
	self.prefix = "Player"
	
	function self.addEffect(effect)
		if self.findEffect(effect.name) then
			self.effects[effect.name].level = self.effects[effect.name].level + effect.level
		else
			table.insert(self.effects, effect)
		end
	end

	-- start of turn
	function self.applyEffects()
		for index, effect in pairs(self.effects) do
			if effect["apply"] ~= nil then
				effect.apply(self)
			end
		end
	end

	function self.changeDefence(amount)
		self.defence = self.defence+amount
	end

	function self.findEffect(name)
		for index, effect in pairs(self.effects) do
			if effect[name] ~= nil then
				return true
			end
		end
	end

	function self.damage(amount, sender)
		local amount = amount
		local multiplierTable = sender.retrieveEffect("damageMultiplier")
		local multiplierValue = 1

		for index, multiplier in pairs(multiplierTable) do
			multiplierValue = multiplier["damageMultiplier"] * multiplierValue
		end

		amount = math.floor(amount * multiplierValue)

		if amount >= self.defence then
			amount = amount - self.defence
			self.defence = 0
		else 
			self.defence = self.defence - amount
			return
		end

		local real_hp = self.hp.current - (damage*multiplierValue)

		if real_hp <=0 then
			self.lose()
		else

		end
	end

	function self.lose()

	end

	function self.playCard(card)
		table.remove(self.hand, card)
	end 

	function self.retrieveEffect(propertyName) 
		local effectTable = {}
		for index, effect in pairs(self.effects) do
			if effect[propertyName] ~= nil then
				table.insert(effectTable, effect[index])
			end
		end

		return effectTable
	end

	function self.trueDamage(damage)
		self.hp.current = self.hp.current - damage
	end

	return self
end

return M