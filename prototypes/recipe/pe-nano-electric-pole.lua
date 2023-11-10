local recipe = table.deepcopy(data.raw.recipe["small-electric-pole"])

recipe.name = "pe-nano-electric-pole"
recipe.result = "pe-nano-electric-pole"
recipe.icon = pe.cr.path.."/graphics/entity/pe-nano-electric-pole/pe-nano-electric-pole.png"
recipe.icon_size = 36
recipe.ingredients =
    { 
		{"copper-cable", 1}, 
		{"iron-plate", 1} 
	}

data:extend{recipe}