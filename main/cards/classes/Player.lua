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

	function self.addTables(table1, table2)
		local new = {}

		for i, v in pairs(table1) do
			table.insert(new, v)
		end

		for i, v in pairs(table2) do
			table.insert(new, v)
		end

		return new
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

		local real_hp = self.hp.current - (amount*multiplierValue)

		if real_hp <=0 then
			self.lose()
		else
			self.hp.current = real_hp
		end
	end

	function self.lose()
		
	end

	function self.playCard(card, sender, target)
		self.mana.current = self.mana.current - self.hand[card].data.mana

		self.hand[card].action(sender, target)
		table.remove(self.hand, card)

		self.refill(5)
		
		return sender, target
	end 

	function self.refill(amount)
		if #self.hand == 0 then
			if #self.deck.cards < amount and #self.deck.cards > 0 then
				local remaining = self.deck.draw(#self.deck.cards)
				self.deck.addCards(self.card_inventory)

				for i, v in pairs(remaining) do
					self.deck.removeCards(v.data.name, true)
				end

				self.deck.shuffle()

				self.hand = self.addTables(remaining, self.deck.draw(amount-#remaining))
			elseif #self.deck.cards == 0 then
				self.deck.addCards(self.card_inventory)
				self.deck.shuffle()

				self.hand = self.deck.draw(5)
			end
		end
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