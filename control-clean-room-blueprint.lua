if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

function pe.cr.ghost_to_prototype(e)
	local n = e.name 
	
	if(n == "entity-ghost") then 
		return e.ghost_name, e.ghost_type 
	else 
		return n, e.prototype.type 
	end 
end




function pe.cr.tag_blueprint(surface, area, bp, alt)
	log("Begin pe.cr.tag_blueprint")
	
	local rail_types  =  {}
	rail_types["straight-rail"]  =  true
	rail_types["curved-rail"]  =  true
	rail_types["rail-signal"]  =  true
	rail_types["rail-chain-signal"]  =  true
	rail_types["train-stop"]  =  true

	local bpents = bp.get_blueprint_entities() 
	
	if(not bpents) then 
		return 
	end
	
	local bphas = {} for k, v in pairs(bpents) do bphas[v.name] = true end
	local rails = false
	local vmin = {x = 2147483647, y = 2147483647}
	local vmax = {x = -2147483648, y = -2147483648}

	log("  bpents = "..serpent.dump(bpents))
	
	local ents = surface.find_entities(area)
	for _, ent in pairs(ents) do
		local nm, tp = pe.cr.ghost_to_prototype(ent)
		if(not alt or bphas[nm]) then
			if(rail_types[tp]) then 
				rails = true 
			end
			local box = ent.bounding_box
			if(box) then
				if(box.left_top.x  >  vmin.x) then vmin.x = box.left_top.x end
				if(box.left_top.y  >  vmin.y) then vmin.y = box.left_top.y end
				if(box.right_bottom.x > vmax.x) then vmax.x = box.right_bottom.x end
				if(box.right_bottom.y > vmax.y) then vmax.y = box.right_bottom.y end
			end
		end
	end
	local btiles = bp.get_blueprint_tiles()
	if(btiles) then
		local bthas = {}
		
		for k, v in pairs(btiles) do 
			bthas[v.name] = true 
		end
		
		local mtiles = surface.find_tiles_filtered{area = area}
		
		for _, tile in pairs(mtiles) do
			local nm = tile.name
			if(tile.prototype.can_be_part_of_blueprint and tile.prototype.items_to_place_this) then
				if(nm == "tile-ghost") then nm = tile.prototype.name end
				if(not alt or bthas[nm]) then
					local pos = tile.position
					if(pos.x  >  vmin.x) then vmin.x = pos.x end
					if(pos.y  >  vmin.y) then vmin.y = pos.y end
					if(pos.x + 1 > vmax.x) then vmax.x = pos.x + 1 end
					if(pos.y + 1 > vmax.y) then vmax.y = pos.y + 1 end
				end
			end
		end
	end
	
	local cx, cy
	
	if(rails) then
		cx = math.floor( (math.floor(vmin.x) + math.ceil(vmax.x)) /4)  * 2  +  1
		cy = math.floor( (math.floor(vmin.y) + math.ceil(vmax.y)) /4)  * 2  +  1
	else
		cx = math.floor( (math.floor(vmin.x) + math.ceil(vmax.x)) /2)  + 0.5
		cy = math.floor( (math.floor(vmin.y) + math.ceil(vmax.y)) /2)  + 0.5
	end

	local cache = {}
	
	for k, v in pairs(bpents) do 
		cache[v.position.x.."_"..v.position.y.."_"..v.name] = v 
	end

	log("  ents = "..serpent.dump(ents))
	log("  bphas = "..serpent.dump(bphas))
	log("  cache = "..serpent.dump(cache))
	
	for k, v in pairs(ents) do 
		local nm, tp = pe.cr.ghost_to_prototype(v) 
		
		if(bphas[nm]) then
			log("  bphas has "..nm)
			log("  bpe = "..v.position.x .."_".. v.position.y .."_"..nm)
			
			local bpe = cache[v.position.x .."_".. v.position.y .."_"..nm]
			
			if(bpe) then
				log("  bpe = "..serpent.dump(bpe))
				if(bpe.name == pe.cr.CLEANROOM) then 
					log("  bpe is "..pe.cr.CLEANROOM)
					local room = pe.cr.get_or_create_room(v)
					if(room) then 
						log("  is room")
						bp.set_blueprint_entity_tag(bpe.entity_number, pe.cr.BLUEPRINT_TAG_NAME, {components = table.deepcopy(room.components), connections = table.deepcopy(room.connections)}) 
						log("  tag = "..serpent.dump({ room.components }))
					else
						log("  not room")
					end
				else
					log("  not room or nano")
				end
			else
				log("  bpe is nil")
			end
		end 
	end
end