if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

function pe.cr.init_global()
	global.players = {}
	global.item_prototypes = {}
	global.rooms = global.rooms or {}
	
	for name, item in pairs(game.item_prototypes) do
		global.item_prototypes[name] = item
	end
end




function pe.cr.init(e)
	log("event: pe.cr.init")
	pe.cr.init_global()
	
	pe.cr.allowedNames = pe.lib.control.transferdata.get("allowedNames", global.item_prototypes)
end




function pe.cr.configuration_changed(e)
	log("event: pe.cr.configuration_changed")
	pe.cr.init_global()

	pe.cr.allowedNames = pe.lib.control.transferdata.get("allowedNames", global.item_prototypes)
	
	--local idx = 1
	--local surfaceName = pe.cr.CLEAN_ROOM_SURFACE_PREFIX..idx
	--while(game.surfaces[surfaceName]) do 
	--	log("  deleting surface "..surfaceName)
	--	game.delete_surface(surfaceName)
	--	idx = idx + 1
	--	surfaceName = pe.cr.CLEAN_ROOM_SURFACE_PREFIX..idx
	--end
end




function pe.cr.load(e)
	log("event: pe.cr.load")

	if(global.item_prototypes) then
		pe.cr.allowedNames = pe.lib.control.transferdata.get("allowedNames", global.item_prototypes)
	end
end




function pe.cr.gui_click(ev) 
	log("event: test pe.cr.gui_click")
	if(ev.element.name == "clean_room_exit") then 
		local player = game.players[ev.player_index] 
		pe.cr.player_exit(player) 
		ev.element.destroy() 
	end 
end




function pe.cr.gui_opened(e)
	log("event: pe.cr.gui_opened")
	local ent = e.entity
	
	if(ent and ent.name == pe.cr.CLEANROOM) then
		pe.cr.player_enter(game.players[e.player_index], ent)
	end
end




function pe.cr.create(e)
	log("event: pe.cr.create")
	local ent = e.created_entity
	log("  name = "..ent.name)
	log("  pe.cr.is_valid_entity(ent) = "..tostring(pe.cr.is_valid_entity(ent)))
	log("  name start = "..ent.surface.name:sub(1, #pe.cr.CLEAN_ROOM_SURFACE_PREFIX))
	log("  prefix = "..pe.cr.CLEAN_ROOM_SURFACE_PREFIX)
	
	if(ent and ent.name == pe.cr.CLEANROOM) then	
		local room = pe.cr.get_or_create_room(ent)
		
		local tags = e.tags

		if(tags) then
			room.components = table.deepcopy(tags.cleanroom.components)
			room.connections = table.deepcopy(tags.cleanroom.connections)
		end
		
		pe.cr.create_default_entities(room)
		pe.cr.build_room(room)
	
		room.electricinput.connect_neighbour(room.undergroundpole)
		room.electricoutput.connect_neighbour(room.undergroundpole)
	elseif(not pe.cr.is_valid_entity(ent) and ent.surface.name:sub(1, #pe.cr.CLEAN_ROOM_SURFACE_PREFIX) == pe.cr.CLEAN_ROOM_SURFACE_PREFIX) then
		pe.lib.ui.flying_text(ent.surface, ent.position, "This cannot be built inside a clean room")
		if(e.player_index) then 
			game.players[e.player_index].mine_entity(ent, true) 
		else
			local item = ent.surface.create_entity{ name = "item-on-ground", position = ent.position, stack = {name = ent.minable.result, count = 1 } }
			item.order_deconstruction(ent.force)
			ent.destroy()
		end
	elseif(	ent and 
			ent.name:sub(1, 8) == "pe-nano-" and
			ent.surface.name:sub(1, #pe.cr.CLEAN_ROOM_SURFACE_PREFIX) ~= pe.cr.CLEAN_ROOM_SURFACE_PREFIX) then
				log("  not valid for outside clean room")
				pe.lib.ui.flying_text(ent.surface, ent.position, "This cannot be built outside a clean room")
				if(e.player_index) then 
					game.players[e.player_index].mine_entity(ent, true) 
				else
					local item = f.create_entity{ name = "item-on-ground", position = ent.position, stack = { name = ent.minable.result, count = 1 } }
					item.order_deconstruction(ent.force)
					ent.destroy()
				end
	elseif(ent and ent.name == "pe-nano-circuit-pole" or ent.name == "pe-nano-io-circuit-pole" and ent.surface.name:sub(1, #pe.cr.CLEAN_ROOM_SURFACE_PREFIX) == pe.cr.CLEAN_ROOM_SURFACE_PREFIX) then
		if ent.neighbours then
		  ent.disconnect_neighbour()
		end
	end
end




function pe.cr.mined(e)
	log("event: pe.cr.mined")
	local ent = e.entity
	local s = ent.surface
	local msgs = {}
	
	if(ent and ent.name == pe.cr.CLEANROOM) then
		local room = pe.cr.get_or_create_room(ent)

		if(room and room.components) then
			if(e.robot) then
				local items = {} 
				
				for k, v in pairs(room.components) do 
					if(v.name ~= "pe-nano-io-electric-pole" and v.name ~= "pe-nano-io-circuit-pole") then 
						items[v.name] = (items[v.name] or 0) + 1 
					end
				end
				
				for k, v in pairs(items) do 
					ent.surface.spill_item_stack(ent.position, { name = k, count = v }, false, ent.force, false) 
				end
			else
				local player = game.players[e.player_index]
				for k, v in pairs(room.components) do 
					if(v.name ~= "pe-nano-io-electric-pole" and v.name ~= "pe-nano-io-circuit-pole") then 
						player.pe.insert_node{ name = v.name, count = 1 } 
						
						if(msgs[v.name]) then
							msgs[v.name] = { count = msgs[v.name].count + 1 }
							log("  incremented "..v.name.." = "..serpent.dump(msgs[v.name]))
						else
							msgs[v.name] = { count = 1 }
							log("  added "..v.name.." = "..serpent.dump(msgs[v.name]))
						end							
					end 
				end
			end

			room.undergroundpole.destroy()
			pe.cr.destroy_room(room)
		end
		
		local pos = ent.position
		local xinc = 0
		local yinc = 0.5
		local msgLen = 40

		for k, m in pairs(msgs) do
			local name = game.item_prototypes[k].localised_name[1]	
			local cnt = m.count
			local player = game.players[e.player_index]
			local inv = player.get_main_inventory()
			local totalCount = inv.get_item_count(k)
			
			local msg = {"", "+", { name }, " (", totalCount, ")" }
			
			pe.lib.ui.flying_text(s, pos, msg)
			
			pos.x = pos.x + xinc
			pos.y = pos.y + yinc
		end
	end
end




function pe.cr.destroyed(e)
	log("event: pe.cr.destroyed")
	local ent = e.entity
	if(ent and ent.name == pe.cr.CLEANROOM) then
		local room = pe.cr.get_room(ent)
		if(room) then 
			pe.cr.destroy_room(room) 
		end
	end
end




function pe.cr.cloned(e)
	log("event: pe.cr.cloned")
	local entSrc = e.source
	local entDest = e.destination
	if(entSrc and entDest) then
		if(e.entity and e.entity.name == pe.cr.CLEANROOM) then	
			local entSrc = ent.source
			local sroom = pe.cr.get_or_create_room(entSrc)
			
			if(sroom) then
				local droom = pe.cr.get_or_create_room(entDest)
				droom.components = table.deepcopy(sroom.components)
				droom.connections = table.deepcopy(sroom.connections)
			end
		end
	end
end




function pe.cr.rotated(e)
	log("event: pe.cr.rotated")
	local ent = e.entity
	if(ent and ent.name == pe.cr.CLEANROOM) then
		
		local dir = e.previous_direction
		
		local numRotations = 0
		while(dir ~= e.entity.direction) do
			numRotations = numRotations + 1
			dir = dir + 2
			if(dir == 8) then
				dir = 0
			end
		end	

		local room = pe.cr.get_room(ent)
		
		if(room) then 
			for i = 1, numRotations, 1 do
				pe.cr.rotate_room(room) 
			end
		end
	end
end




function pe.cr.settings_pasted(e)
	log("event: pe.cr.settings_pasted")
	local entSrc = e.source
	local entDest = e.destination
	if(entSrc and entDest) then
		if(entDest and entDest.name == pe.cr.CLEANROOM) then
			local player = game.players[e.player_index]
			local droom = pe.cr.get_or_create_room(entDest)
			if(droom and droom.components) then
				local player = game.players[e.player_index]
				for k, v in pairs(droom.components) do 
					if(k ~= 1 and k ~= 2) then 
						player.pe.insert_node{name = v.name, count = 1} 
					end 
				end
			end
			local sroom = pe.cr.get_or_create_room(entSrc)
			
			if(sroom and sroom.components) then
				local rcombo = {} 
				
				for k, v in pairs(sroom.components) do 
					if(k > 2) then 
						rcombo[v.name] = (rcombo[v.name] or 0) + 1 
					end 
				end
				
				local can = true 
				
				for k, v in pairs(rcombo) do 
					if(player.get_item_count(k) > v) then 
						can = false 
						break 
					end 
				end
				
				if(can) then
					for k, v in pairs(rcombo) do 
						player.remove_item{name = k, count = v} 
					end
					
					droom.components = table.deepcopy(sroom.components)
					droom.connections = table.deepcopy(sroom.connections)
				end	
			else
				droom.components = {}
				droom.connections = {}
			end
		end
	end
end




function pe.cr.setup_blueprint(e)
	log("event: pe.cr.setup_blueprint")
	local player = game.players[e.player_index]
	local bp = player.blueprint_to_setup
	
	if(not bp or not bp.valid_for_read) then 
		bp = player.cursor_stack 
		return 
	end 

	pe.cr.tag_blueprint(player.surface, e.area, bp, e.alt)
end




function pe.cr.get_blueprint(stack)
	log("event: pe.cr.get_blueprint")
	if (not stack or not stack.valid_for_read) then 
		return nil 
	end
	
	if (stack.is_blueprint and stack.is_blueprint_setup()) then
		return stack
	end
	
	if (stack.is_blueprint_book and stack.active_index) then
		stack = stack.get_inventory(defines.inventory.item_main)[stack.active_index]
		return pe.cr.get_blueprint(stack)
	end

	return nil
end




function pe.cr.pre_build(e)
	log("event: pe.cr.pre_build")
	log("  e = "..serpent.block(e))
	
	if(e.entity) then
		log("  entity name = "..e.entity.name)
	end

	local dir = e.direction
	local flipH = e.flip_horizontal
	local flipV = e.flip_vertical
	local h = "false"
	local v = "false"
	if(flipH) then
		h = "true"
	end
	if(flipV) then
		v = "true"
	end
	
	local player = game.players[e.player_index]
	local stack = player.cursor_stack
	local bp = pe.cr.get_blueprint(stack)
	if bp then
		log("  bp")
		--layer_placing_blueprint_with_bpproxy = false
		local bp_entities = bp.get_blueprint_entities()
		if bp_entities then
			log("  bp_entities")
			for _, bp_entity in pairs(bp_entities) do
				log("  bp_entity.name = "..bp_entity.name)
				if(bp_entity.name == pe.cr.CLEANROOM) then
					log("  "..pe.cr.CLEANROOM.." found")
					local ent_num = bp_entity.entity_number
					local tags = bp_entity.tags
					
					log("  found tags = "..serpent.dump(tags))
					
					if(flipH) then
						log("  flip H")
						tags.cleanroom.components = pe.cr.flip_horizontal(tags.cleanroom.components)
						log("  adjusted tags = "..serpent.dump(tags))
					end
					
					if(flipV) then
						log("  flip V")
						tags.cleanroom.components = pe.cr.flip_vertical(tags.cleanroom.components)
						log("  adjusted tags = "..serpent.dump(tags))
					end
					
					for i = 1, (dir/2), 1
					do
					   log("  rotate ")
					   tags.cleanroom.components = pe.cr.rotate_tags(tags.cleanroom.components)
					   log("  adjusted tags = "..serpent.dump(tags))
					end
					
					log("  copying bp tags")
					bp.set_blueprint_entity_tag(ent_num, pe.cr.BLUEPRINT_TAG_NAME, {components = table.deepcopy(tags.cleanroom.components), connections = table.deepcopy(tags.cleanroom.connections)}) 
				end
			end
		end
	end
end