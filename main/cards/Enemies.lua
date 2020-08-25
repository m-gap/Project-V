local enemiesList = {}

enemiesList["Generic Enemy"] = {
	health = 75
	cardSet = {"Punch"}
}
	

function retrieveEnemy(name)
	return enemiesList[name]
end