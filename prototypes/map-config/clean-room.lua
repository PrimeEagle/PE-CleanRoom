local config = 
{
	name											=	pe.cr.CLEAN_ROOM_SURFACE_PREFIX,																												-- required
	map_gen_settings								=
														{
															terrain_segmentation						=	pe.lib.defines.map_gen_size.none,							-- optional, default = pe.lib.defines.map_gen_size.normal
															water										=	pe.lib.defines.map_gen_size.none,							-- optional, default = pe.lib.defines.map_gen_size.normal
															autoplace_controls							=	{},															-- optional, no default
															default_enable_all_autoplace_controls		=	true,														-- optional, default = true
															autoplace_settings							=	{},															-- optional, no default
															cliff_settings								=
																											{
																												name									=	"",			-- required
																												cliff_elevation_0						=	0,			-- optional, default = 0
																												cliff_elevation_interval				=	40,			-- optional, default = pe.lib.MAP_DEFAULT_CLIFF_ELEVATION_INTERVAL
																												richness								=	0			-- optional, default = pe.lib.MAP_DEFAULT_CLIFF_RICHNESS
																											},
															seed										=	100,														-- optional, default = 100
															width										=	0,															-- optional, default = 0
															height										=	0,															-- optional, default = 0
															starting_area								=	pe.lib.defines.map_gen_size.normal,							-- optional, default = pe.lib.defines.map_gen_size.normal
															starting_points								=	{ { 0, 0 } },												-- optional, default = { 0, 0 }
															peaceful_mode								=	true,														-- optional, default = false
															property_expression_names					=	{}															-- optional, no default
														},
	generate_with_lab_tiles							=	false,																											-- optional, default = false
	always_day										=	true,																											-- optional, default = false
	daytime											=	0.5,																											-- optional, default = 0.5
	wind_speed										=	0,																												-- optional, default = 0
	wind_orientation								=	0,																												-- optional, default = 0
	wind_orientation_change							=	0,																												-- optional, default = 0
	peaceful_mode									=	false,																											-- optional, default = false
	freeze_daytime									=	true,																											-- optional, default = false
	ticks_per_day									=	25000,																											-- optional, default = 25000 
	dusk											=	0.25,																											-- optional, default = 0.25
	dawn											=	0.75,																											-- optional, default = 0.75
	evening											=	0.45,																											-- optional, default = 0.45
	morning											=	0.55,																											-- optional, default = 0.55
	solar_power_multiplier							=	1,																												-- optional, default = 1
	min_brightness									=	0.15,																											-- optional, default = 0.15
	brightness_visual_weights						=	{ 0, 0, 0 },																									-- optional, default = { 0, 0 }
	show_clouds										=	false																											-- optional, default = true
}


pe.lib.map.load_config(config)