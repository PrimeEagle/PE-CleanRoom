if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

function pe.cr.make_room(ent)
	log("pe.cr.make_room")

	local idx = #global.rooms + 1
	global.rooms[idx] = { index = idx, entity = ent, surface = {}, components = {}, connections = {}, circuitinput = {}, circuitoutput = {}, powerinput = {}, poweroutput = {} }

	local room = global.rooms[idx]
	pe.cr.make_surface(room)
	
	return room
end




function pe.cr.get_room(ent)
	log("pe.cr.get_room - "..ent.name)

	for k, v in pairs(global.rooms) do 
		if(v.entity == ent) then
			--log("  surface is "..v.surface.name)
			return v 
		end 
	end
end




function pe.cr.destroy_room(room)
	if(room.players) then
		for k, v in pairs(room.players) do
			v.player.teleport(v.position, v.surface)
		end
	end
	
	if(room.surface) then 
		game.delete_surface(room.surface) 
	end
	
	room.undergroundpole.destroy()
	
	for k, v in pairs(room.surface.find_entities()) do 
		v.destroy() 
	end 
	
	global.rooms[room.index] = nil
	--table.remove(global.rooms, room.index)
end




function pe.cr.normalize_room_dimensions(room)
	log("pe.cr.normalize_room_dimensions")
	local s_width = settings.startup["pe-clean-room-width"].value
	local s_height = settings.startup["pe-clean-room-height"].value
	local horizontal = (room.entity.direction == pe.lib.dir.right or room.entity.direction == pe.lib.dir.left)
	local vertical = (room.entity.direction == pe.lib.dir.up or room.entity.direction == pe.lib.dir.down)
	
	local roomDir = room.entity.direction
	
	if(s_width < 1) then
		s_width = 1
	end
	
	if(s_height < 1) then
		s_height = 1
	end
	
	if(s_width > pe.cr.MAX_SURFACE_WIDTH) then
		s_width = pe.cr.MAX_SURFACE_WIDTH
	end
	
	if(s_height > pe.cr.MAX_SURFACE_HEIGHT) then
		s_height = pe.cr.MAX_SURFACE_HEIGHT
	end
	
	if(vertical) then
		if(s_width > s_height) then
			room.width = s_height
			room.height = s_width
		else
			room.width = s_width
			room.height = s_height
		end
	end
	
	if(horizontal) then
		if(s_width > s_height) then
			room.width = s_width
			room.height = s_height
		else
			room.width = s_height
			room.height = s_width
		end
	end
end




function pe.cr.get_or_create_room(ent)
	log("pe.cr.get_or_create_room")
	local room = pe.cr.get_room(ent)
	
	if(not room) then
		room = pe.cr.make_room(ent)
	end
	
	return room
end




function pe.cr.rotate_room(room)
	log("pe.cr.rotate_room")
	
	local tags = pe.cr.rotate_tags(room.components)
	log("pe.cr.rotate_room 1")
	room.components = table.deepcopy(tags)
	log("pe.cr.rotate_room 2")
	pe.cr.realign_entities(room)
	log("pe.cr.rotate_room 3")
	pe.cr.create_default_entities(room)
	log("pe.cr.rotate_room 4")
	pe.cr.build_room(room)
	log("pe.cr.rotate_room 5")

	if(room.undergroundpole) then 
		log("  undergroundpole present") 
		log("  ug pole connections = "..serpent.block(room.undergroundpole.circuit_connection_definitions))
	end
	
	room.electricinput.connect_neighbour(room.undergroundpole)
	room.electricoutput.connect_neighbour(room.undergroundpole)
	room.circuitinput.connect_neighbour( { wire = defines.wire_type.red, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_input } )
	room.circuitinput.connect_neighbour( { wire = defines.wire_type.green, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_input } )
	room.circuitoutput.connect_neighbour( { wire = defines.wire_type.red, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_output } )
	room.circuitoutput.connect_neighbour( { wire = defines.wire_type.green, target_entity = room.entity, target_circuit_id = defines.circuit_connector_id.combinator_output } )
	
	room.circuitinput.disconnect_neighbour()
	room.circuitoutput.disconnect_neighbour()
	
	if(room.undergroundpole) then 
		log("  ug pole connections = "..serpent.block(room.undergroundpole.circuit_connection_definitions))
	end
	
	log("pe.cr.rotate_room 6")
end




function pe.cr.build_room(room)
	log("pe.cr.build_room")
	--log("  surface is "..room.surface.name)
	local s = pe.cr.get_or_create_surface(room)
	--log("  surface is "..room.surface.name)
	local entities = {}
	
	for k, v in pairs(room.components) do 
		local ex = s.create_entity{name = v.name, surface = f, position = v.position, direction = v.direction, force = game.forces.player}
		if(v.parameters) then 
			local mode = ex.get_or_create_control_behavior() 
			mode.parameters = table.deepcopy(v.parameters) 
		end
		entities[tonumber(k)] = ex
	end
	
	for kx, tbl in pairs(room.connections) 
		do local k = tonumber(kx)
		for wire, vtbl in pairs(tbl) do
			for cbidx, ctbl in pairs(vtbl) do 
				
				local cbid = tonumber(cbidx)
				for _, conn in pairs(ctbl) do
					entities[k].connect_neighbour({wire = wire, target_entity = entities[tonumber(cbid)], source_circuit_id = conn.source, target_circuit_id = conn.target})
				end
			end
		end
	end
end




function pe.cr.realign_entities(room)
	log("pe.cr.realign_entities")
	
	local icp1
	local icp2
	
	for k, v in pairs(room.components) do
		if(v.name == "pe-nano-io-circuit-pole") then
			if(not icp1) then
				icp1 = v
			else
				icp2 = v
			end
		end
	end

	if(icp1 and icp2) then
		local ioPos = pe.cr.get_io_circuit_position_info(room)
		local icp1Dist = math.sqrt((ioPos.input.position.x - icp1.position.x)^2 + (ioPos.input.position.y - icp1.position.y)^2)
		local icp2Dist = math.sqrt((ioPos.input.position.x - icp2.position.x)^2 + (ioPos.input.position.y - icp2.position.y)^2)

		local icp
		if(icp1Dist < icp2Dist) then
			icp = icp1
		else
			icp = icp2
		end
		
		local xAdj = ioPos.input.position.x - icp.position.x
		local yAdj = ioPos.input.position.y - icp.position.y
		tags = pe.cr.shift_tags(room.components, xAdj, yAdj)
		
		pe.cr.rooms.components = table.deepcopy(tags)
	end
end




function pe.cr.get_io_power_position_info(room)
	log("pe.cr.get_io_power_position_info")
	
	local roomDir = room.entity.direction
	local dim = room.dimension_info
	local inputX
	local inputY
	local outputX
	local outputY
	
	if(roomDir == pe.lib.dir.right) then
		inputX = dim.left - 1
		inputY = -1
		outputX = dim.right + 1
		outputY = -1
	elseif(roomDir == pe.lib.dir.down) then
		inputX = 1
		inputY = dim.top - 1
		outputX = 1
		outputY = dim.bottom + 1
	elseif(roomDir == pe.lib.dir.left) then
		if(room.dimension_info.height_even) then
			inputY = 0
			outputY = 0
		else
			inputY = 1
			outputY = 1
		end
		inputX = dim.right + 1
		outputX = dim.left - 1
	elseif(roomDir == pe.lib.dir.up) then
		if(room.dimension_info.height_even) then
			inputX = 0
			outputX = 0
		else
			inputX = -1
			outputX = -1
		end

		inputY = dim.bottom + 1
		outputY = dim.top - 1
	end
	
	local res = {
					input = {
								position = { x = inputX, y = inputY },
								direction = roomDir
							},
					output = {
								position = { x = outputX, y = outputY },
								direction = roomDir
							}
				}
	
	return res
end




function pe.cr.get_io_circuit_position_info(room)
	log("pe.cr.get_io_circuit_position_info")
	
	local roomDir = room.entity.direction
	local dim = room.dimension_info
	local inputX
	local inputY
	local outputX
	local outputY
	
	if(roomDir == pe.lib.dir.right) then
		inputX = dim.left - 1
		inputY = 0
		outputX = dim.right + 1
		outputY = 0
	elseif(roomDir == pe.lib.dir.down) then
		inputX = 0
		inputY = dim.top - 1
		outputX = 0
		outputY = dim.bottom + 1
	elseif(roomDir == pe.lib.dir.left) then
		if(room.dimension_info.height_even) then
			inputY = -1
			outputY = -1
		else
			inputY = 0
			outputY = 0
		end
		inputX = dim.right + 1
		outputX = dim.left - 1
	elseif(roomDir == pe.lib.dir.up) then
		if(room.dimension_info.height_even) then
			inputX = 1
			outputX = 1
		else
			inputX = 0
			outputX = 0
		end

		inputY = dim.bottom + 1
		outputY = dim.top - 1
	end
	
	local res = {
					input = {
								position = { x = inputX, y = inputY },
								direction = roomDir
							},
					output = {
								position = { x = outputX, y = outputY },
								direction = roomDir
							}
				}
	
	log("  res = "..serpent.dump(res))
	return res
end




function pe.cr.build_components(room)
	log("pe.cr.build_components")
	local s = room.surface
	local cx = {}
	
	local components = {}
	local connections = {}

	local ents = s.find_entities()
	
	for k, v in pairs(s.find_entities()) do
		if(pe.cr.is_valid_entity(v)) then
			table.insert(components, v) 
		else
			game.print("An incompatible entity was lost in a clean room: " .. v.name) 
		end
	end

	for k, v in pairs(components) do 
		local nb = v.circuit_connection_definitions
		if(nb) then
			for kx, conn in pairs(nb) do
				for kdx, ve in pairs(components) do 
					if(ve == conn.target_entity) then
						if(not ((connections[kdx] or {})[conn.wire] or {})[kdx]) then
							connections[k] = connections[k] or {}
							connections[k][conn.wire] = connections[k][conn.wire] or {}
							connections[k][conn.wire][kdx] = connections[k][conn.wire][kdx] or {}
							table.insert(connections[k][conn.wire][kdx], {source = conn.source_circuit_id, target = conn.target_circuit_id})
						end
					end 
				end
			end
		end
	end

	room.connections = connections
	room.components = {}

	for k, v in pairs(components) do
		local mode, data
		
		if(pe.cr.is_valid_entity(v) and v.get_control_behavior() ~= nil) then 
			mode = v.get_control_behavior() 
			if(mode and mode.parameters) then
				data = table.deepcopy(mode.parameters)
			end
		end
		
		local vpos = v.position
		
		room.components[k] = { name = v.name, position = vpos, direction = v.direction, parameters = data }
	end
end



function pe.cr.init_room_dimension_info(room)
	log("pe.cr.init_room_dimension_info")
	local s_width = settings.startup["pe-clean-room-width"].value
	local s_height = settings.startup["pe-clean-room-height"].value
	local width_even = (s_width % 2) == 0
	local height_even = (s_height % 2) == 0
	local horizontal = (room.entity.direction == pe.lib.dir.right or room.entity.direction == pe.lib.dir.left)
	local vertical = (room.entity.direction == pe.lib.dir.up or room.entity.direction == pe.lib.dir.down)
	
	local width
	local height
	local left
	local right
	local top
	local bottom
	
	if(vertical) then
		if(s_width > s_height) then
			width = s_height
			height = s_width
		else
			width = s_width
			height = s_height
		end
	end
	
	if(horizontal) then
		if(s_width > s_height) then
			width = s_width
			height = s_height
		else
			width = s_height
			height = s_width
		end
	end
	
	if(width_even) then
		left = -(room.width / 2)
		right = (room.width / 2)
	else
		left = -(room.width - 1) / 2
		right = (room.width + 1) / 2
	end
	
	if(height_even) then
		top = -(room.height / 2)
		bottom = (room.height / 2)
	else
		top = -(room.height - 1) / 2
		bottom = (room.height + 1) / 2
	end
	
	local horizontal_adjustment = 0
	local vertical_adjustment = 0
	
	if(horizontal) then
		horizontal_adjustment = 2
	end
	
	if(vertical) then
		vertical_adjustment = 2
	end
	
	local bounding_box = { left_top = { x = left - horizontal_adjustment, y = top - vertical_adjustment }, right_bottom = { x = right + horizontal_adjustment, y = bottom + vertical_adjustment } }

	local maxTiles = 0
	if(room.width > room.height) then
		maxTiles = room.width
	else
		maxTiles = room.height
	end
	
	maxTiles = maxTiles / 2
	local chunk_radius = ((maxTiles - 1) / pe.lib.CHUNK_SIZE) / 2

	local res = {
					top = top,
					bottom = bottom,
					right = right,
					left = left,
					horizontal = horizontal,
					vertical = vertical,
					horizontal_adjustment = horizontal_adjustment,
					vertical_adjustment = vertical_adjustment,
					width_even = width_even,
					height_even = height_even,
					width = width,
					height = height,
					room_width = room.width,
					room_height = room.height,
					room_direction = room.entity.direction,
					bounding_box = bounding_box,
					chunk_radius = chunk_radius
				}
				
	room.dimension_info = table.deepcopy(res)
	
	
end




function pe.cr.init_room_floor_tile(room)
	local floorTile  =  settings.startup["clean-room-floor-tile-setting"].value
	local floorTileName = ""	
	
	if(floorTile == "Concrete") then
		floorTileName = "concrete"
	elseif(floorTile == "Refined Concrete") then
		floorTileName = "refined-concrete"
	elseif(floorTile == "Clean Room Grid") then
		floorTileName = "pe-grid-clean-room"
	end
	
	room.floor_tile = floorTileName
end




function pe.cr.init_room_settings(room)
	pe.cr.normalize_room_dimensions(room)	
	pe.cr.init_room_dimension_info(room)
	pe.cr.init_room_floor_tile(room)
end