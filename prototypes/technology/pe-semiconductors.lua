data:extend({
  {
    type = "technology",
    name = "pe-semiconductors",
    icon = pe.cr.path.."/graphics/pe-semiconductors.png",
	icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "pe-cleanroom"
      },
  	  {
        type = "unlock-recipe",
        recipe = "pe-nano-electric-pole"
      },
	  {
        type = "unlock-recipe",
        recipe = "pe-nano-circuit-pole"
      },
	  {
        type = "unlock-recipe",
        recipe = "pe-circuit-pole"
      }
    },
    prerequisites = {"advanced-electronics-2", "circuit-network"},
    unit =
    {
      count = 350,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1}
      },
      time = 35
    }
  }
})