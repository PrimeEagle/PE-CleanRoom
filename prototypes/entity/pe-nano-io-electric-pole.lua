local entity = 
  {
    type = "electric-pole",
    name = "pe-nano-io-electric-pole",
    icon = pe.cr.path.."/graphics/icons/pe-nano-electric-pole.png",
    icon_size = 32,
	flags = {	"not-rotatable", 
				"not-deconstructable", 
				"hide-alt-info", 
				"not-flammable", 
				"not-upgradable", 
				"not-in-kill-statistics", 
				"not-in-made-in", 
				"no-automated-item-removal", 
				"no-automated-item-insertion" 
			},
    mineable_properties = { minable = false },
    max_health = 100,
	destructible = false,
    corpse = "small-remnants",
    collision_box = { { -0.15, -0.15 }, { 0.15, 0.15 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    drawing_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    maximum_wire_distance = 7,
    supply_area_distance = 4,
    vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
    track_coverage_during_build_by_moving = false,
    fast_replaceable_group = "electric-pole",
    pictures =
    {
      filename = pe.cr.path.."/graphics/entity/pe-nano-electric-pole/pe-nano-electric-pole.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      direction_count = 1,
      scale = 0.5,
      hr_version = 
      {
        filename = pe.cr.path.."/graphics/entity/pe-nano-electric-pole/hr-pe-nano-electric-pole.png",
        priority = "extra-high",
        width = 256,
        height = 256,
        direction_count = 1,
        scale = 0.25
      }
    },
    connection_points =
    {
      {
        wire =
        {
          copper = {      0, -84/256 },
          red =    { -74/256,  32/256 },
          green =  { 72/256,  32/256 }
        },
        shadow =
        {
          copper = { 114/256,  18/256 },
          red =    { 42/256, 134/256 },
          green =  { 186/256, 134/256 }
        },
      }
    },
    radius_visualisation_picture =
    {
      filename = pe.cr.path.."/graphics/entity/pe-nano-electric-pole/pe-nano-electric-pole-radius-visualization.png",
      width = 12,
      height = 12,
      priority = "extra-high-no-scale"
    }
  }

data:extend{entity}