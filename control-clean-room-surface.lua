if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

function pe.cr.rebuild_surface_tiles(room)
	log("pe.cr.rebuild_surface_tiles")
	
	local surface = room.surface
	
	surface.request_to_generate_chunks({0, 0}, room.dimension_info.chunk_radius)
	surface.force_generate_chunk_requests()
	surface.destroy_decoratives({})
	
	local ents = surface.find_entities(room.dimension_info.bounding_box)
	
	for k, v in pairs(ents) do
		if(v.name:sub(1, 10) ~= "pe-nano-io") then
			v.destroy()
		end
	end
	
	local surfaceTiles = surface.find_tiles_filtered({ area = room.dimension_info.bounding_box })
	local tiles = {}

	for k, v in pairs(surfaceTiles) do
		local pos = v.position

		if(pos.x == math.floor(room.circuitinput.position.x) and pos.y == math.floor(room.circuitinput.position.y)) then
			log("  rst circuit input = "..serpent.dump(pos))
			table.insert(tiles, {name = room.floor_tile, position = pos})
		elseif(pos.x == math.floor(room.circuitoutput.position.x) and pos.y == math.floor(room.circuitoutput.position.y)) then
			log("  rst circuit output = "..serpent.dump(pos))
			table.insert(tiles, {name = room.floor_tile, position = pos})
		elseif(pos.x == math.floor(room.electricinput.position.x) and pos.y == math.floor(room.electricinput.position.y)) then
			log("  rst electric input = "..serpent.dump(pos))
			table.insert(tiles, {name = room.floor_tile, position = pos})
		elseif(pos.x == math.floor(room.electricoutput.position.x) and pos.y == math.floor(room.electricoutput.position.y)) then
			log("  rst electric output = "..serpent.dump(pos))
			table.insert(tiles, {name = room.floor_tile, position = pos})
		elseif(pos.x >= room.dimension_info.left and pos.x <= room.dimension_info.right and pos.y >= room.dimension_info.top and pos.y <= room.dimension_info.bottom) then
			table.insert(tiles, {name = room.floor_tile, position = pos})
		else
			table.insert(tiles, {name = "out-of-map", position = pos})
		end
	end

	surface.set_tiles(tiles)
end




function pe.cr.create_default_entities(room)
	log("pe.cr.create_default_entities")
	
	local circuitDim = pe.cr.get_io_circuit_position_info(room)
	local electricDim = pe.cr.get_io_power_position_info(room)
	local s = room.surface
	
	pe.lib.surface.delete_entities(s)
			
	room.circuitinput  = s.create_entity{	name = "pe-nano-io-circuit-pole", 
											position = circuitDim.input.position, 
											force = game.forces.player, 
											direction = circuitDim.input.direction }, 
											false, false
											
	room.circuitoutput = s.create_entity{	name = "pe-nano-io-circuit-pole", 
											position = circuitDim.output.position, 
											force = game.forces.player, 
											direction = circuitDim.output.direction }, 
											false, false
											
	room.electricinput = s.create_entity{	name = "pe-nano-io-electric-pole", 
											position = electricDim.input.position, 
											force = game.forces.player, 
											direction = electricDim.input.direction }
											
	room.electricoutput = s.create_entity{	name = "pe-nano-io-electric-pole", 
											position = electricDim.output.position, 
											force = game.forces.player, 
											direction = electricDim.output.direction }
	
	room.undergroundpole = room.entity.surface.create_entity{	name = "pe-underground-electric-pole", 
											position = room.entity.position, 
											force = game.forces.player, 
											direction = electricDim.output.direction }
	
	room.electricinput.connect_neighbour(room.undergroundpole)
	room.electricoutput.connect_neighbour(room.undergroundpole)
	room.circuitinput.connect_neighbour( { wire = defines.wire_type.red, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_input } )
	room.circuitinput.connect_neighbour( { wire = defines.wire_type.green, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_input } )
	room.circuitoutput.connect_neighbour( { wire = defines.wire_type.red, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_output } )
	room.circuitoutput.connect_neighbour( { wire = defines.wire_type.green, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_output } )
	
	if room.circuitinput then
	  room.circuitinput.disconnect_neighbour()
	end
	
	if room.circuitoutput then
	  room.circuitoutput.disconnect_neighbour()
	end
end




function pe.cr.make_surface(room)
	log("pe.cr.make_surface")

	local surfaceName = pe.cr.CLEAN_ROOM_SURFACE_PREFIX..room.index
	
	pe.cr.init_room_settings(room)
	local config = pe.lib.maps[pe.cr.CLEAN_ROOM_SURFACE_PREFIX]
	local s = pe.lib.map.create_surface(config)
	s.name = surfaceName
	s.width = room.dimension_info.width,
	s.height = room.dimension_info.height
	
	room.surface = s
	pe.cr.create_default_entities(room)
	pe.cr.rebuild_surface_tiles(room)
end




function pe.cr.get_or_create_surface(room) 
	log("pe.cr.get_or_create_surface")
	
	if(not room.surface) then
		pe.cr.make_surface(room)
	end
	
	return room.surface
end