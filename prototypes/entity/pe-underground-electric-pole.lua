local entity = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])

entity.name = "pe-underground-electric-pole"
entity.flags = {"placeable-player", 
				"placeable-off-grid", 
				"not-blueprintable", 
				"not-deconstructable", 
				"not-on-map", 
				"hidden", 
				"hide-alt-info", 
				"not-flammable", 
				"no-copy-paste", 
				"not-selectable-in-game", 
				"not-upgradable"
}
entity.collision_box = {{-0, -0}, {0, 0}}
entity.collision_mask = {}
entity.selection_box = nil
entity.order = "z"
entity.mineable_properties = { minable = false }
entity.destructible = false
entity.max_health = 2147483648
entity.maximum_wire_distance = 9
entity.supply_area_distance = 0
entity.draw_copper_wires = false
entity.pictures = {
	filename = pe.cr.path.."/graphics/icons/invisible.png",
	width = 1,
	height = 1,
	direction_count = 1
}
entity.connection_points = {
	{
		shadow = {
			copper = {0, -0.2},
			red = {0, 0},
			green = {0, 0}
		},
		wire = {
			copper = {0, -0.2},
			red = {0, 0},
			green = {0, 0}
		}
	}
}

data:extend({
  entity
})
