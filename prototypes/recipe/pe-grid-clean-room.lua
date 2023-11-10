local recipe = table.deepcopy(data.raw.recipe["concrete"])

recipe.name = "pe-grid-clean-room"
recipe.result = "pe-grid-clean-room"
recipe.icon = pe.cr.path.."/graphics/entity/tiles/pe-grid-clean-room.png"
recipe.icon_size = 128
recipe.ingredients =
    { 
		{"iron-plate", 1}, 
		{"plastic-bar", 2}
	}

data:extend{recipe}