local recipe = table.deepcopy(data.raw.recipe["small-electric-pole"])

recipe.name = "pe-nano-circuit-pole"
recipe.result = "pe-nano-circuit-pole"
recipe.icon = pe.cr.path.."/graphics/entity/pe-nano-circuit-pole/pe-nano-circuit-pole.png"
recipe.icon_size = 128
recipe.ingredients =
    { 
		{"red-wire", 1}, 
		{"green-wire", 1}, 
		{"iron-plate", 1} 
	}

data:extend{recipe}