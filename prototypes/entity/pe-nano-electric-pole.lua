local entity = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])

entity.name = "pe-nano-electric-pole"
entity.place_result = "pe-nano-electric-pole"
entity.icon = pe.cr.path.."/graphics/icons/pe-nano-electric-pole.png"
entity.icon_size = 32
entity.selection_box = {{-0.5,-0.5},{0.5,0.5}}
entity.minable.result = "pe-nano-electric-pole"
entity.maximum_wire_distance = 7
entity.supply_area_distance = 4
entity.draw_copper_wires = true
entity.pictures = {
	filename = pe.cr.path.."/graphics/entity/pe-nano-electric-pole/pe-nano-electric-pole.png",
	priority = "extra-high",
	width = 60, height = 36, direction_count = 4, shift = util.by_pixel(16,1)
}
entity.track_coverage_during_build_by_moving = false
entity.connection_points = {
	{ shadow  =  {red  =  {0.6, 0.4},  green  =  {0.9, 0.42}}, wire  =  {red  =  {-0.375, -0.35}, green  =  {0.00625, -0.35}} },
	{ shadow  =  {red  =  {0.5, 0.1},  green  =  {0.95, 0.4}}, wire  =  {red  =  {-0.31, -0.5},   green  =  {-0.1, -0.34}}    },
	{ shadow  =  {red  =  {0.85, 0.1}, green  =  {0.85, 0.5}}, wire  =  {red  =  {-0.09, -0.525}, green  =  {-0.08, -0.275}}  },
	{ shadow  =  {red  =  {0.85, 0.2}, green  =  {0.5, 0.48}}, wire  =  {red  =  {0.1, -0.45},    green  =  {-0.125, -0.3}}   },
}
entity.radius_visualisation_picture.filename  =  pe.cr.path.."/graphics/entity/pe-nano-electric-pole/pe-nano-electric-pole-radius-visualization.png"

data:extend{entity}