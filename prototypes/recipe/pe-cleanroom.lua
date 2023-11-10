local recipe = table.deepcopy(data.raw.recipe["decider-combinator"])

recipe.name = "pe-cleanroom"
recipe.result = "pe-cleanroom"
recipe.icon = pe.cr.path.."/graphics/entity/pe-cleanroom/pe-cleanroom.png"
recipe.icon_size = 52
recipe.ingredients =
    {
      { "copper-cable", 10 },
	  { "plastic-bar", 20 },
	  { "iron-plate", 10 },
	  { "concrete", 20 }
    }

data:extend{recipe}