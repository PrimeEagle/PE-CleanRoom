local recipe = table.deepcopy(data.raw.recipe["small-electric-pole"])

recipe.name = "pe-circuit-pole"
recipe.result = "pe-circuit-pole"
recipe.icon = pe.cr.path.."/graphics/entity/pe-circuit-pole/pe-circuit-pole.png"
recipe.icon_size = 128
recipe.ingredients =
    { 
		{"red-wire", 2}, 
		{"green-wire", 2}, 
		{"iron-plate", 2} 
	}

data:extend{recipe}