local M = {}
local Effect = {}
local LingeringEffect = {}

function Effect.new(name, level, image)
	local self = {}

	self.name = name
	self.level = level 
	self.image = image 

	return self
end

function LingeringEffect.new(name, level, image)
	local self = Effect.new(name, level, image)

	function self.linger(target, mechanic, counter)
		mechanic(self.level)

		self.level = self.level + counter
	end

	return self
end

Effect["Bleed"] = {
	["new"] = function(level)
		local self = LingeringEffect.new("Bleed", level, nil)

		function self.apply(target)
			self.linger(target, target.trueDamage, -1)
		end

		return self
	end
}
Effect["Bolster"] = {
	["new"] = function(level)
		local self = LingeringEffect.new("Bolster", level, nil)

		function self.apply(target)
			self.linger(target, target.changeDefence, -1)
		end

		return self
	end
}
Effect["Burn"] = {
	["new"] = function(level)
		local self = LingeringEffect.new("Burn", level, nil)

		function self.apply(target)
			self.linger(target, target.trueDamage, -1)
		end

		return self
	end
}

Effect["Poison"] = {
	["new"] = function(level)
		local self = LingeringEffect.new("Poison", level, nil)

		function self.apply(target)
			self.linger(target, target.trueDamage, -1)
		end

		return self
	end
}
Effect["Strength"] = {
	["new"] = function(level)
		local self = Effect.new("Strength", level, nil)

		self.damageMultiplier = level + 1 -- where level > 0

		return self
	end
}
Effect["Weakness"] = {
	["new"] = function(level)
		local self = Effect.new("Weakness", level, nil)

		self.damageMultiplier = 1/(level+1)

		return self
	end
}

function M.get(name) 
	return Effect[name]
end

return M

