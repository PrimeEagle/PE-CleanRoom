if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

function pe.cr.shift_tags(tags, x, y)
	log("pe.cr.shift_tags")
	
	for k, v in pairs(tags) do
		v.position.y = v.position.y + y
		v.position.x = v.position.x + x
		
		tags[k] = v
	end
	
	return tags
end




function pe.cr.get_entity_from_tags(name, tags)
	log("pe.cr.get_entity_from_tags")
	log("  name = "..name)
	log("  tags = "..serpent.dump(tags))
	
	for k, v in pairs(tags) do
		if(v.name == name) then
			return v
		end
	end

	return nil
end




function pe.cr.rotate_tags(tags)
	log("pe.cr.rotate_tags")
	local width = settings.startup["pe-clean-room-width"].value
	local height = settings.startup["pe-clean-room-height"].value
	
	for k, v in pairs(tags) do
		local temp = v.position.y
		v.position.y = v.position.x
		v.position.x = -temp
		
		v.direction = v.direction + 2
		if(v.direction == 8) then
			v.direction = 0
		end
				
		tags[k] = v
	end
	
	return tags
end




function pe.cr.flip_horizontal(tags)
	log("pe.cr.flip_horizontal")

	for k, v in pairs(tags) do
		v.position.x = -v.position.x
		v.position.y = v.position.y
		
		v.direction = v.direction + 4
		if(v.direction > 6) then
			v.direction = v.direction - 8
		end
		log("  new pe.dir = "..v.direction)
		
		tags[k] = v
	end
	
	return tags
end




function pe.cr.flip_vertical(tags)
	log("pe.cr.flip_vertical")

	for k, v in pairs(tags) do
		v.position.x = v.position.x
		v.position.y = -v.position.y
		
		v.direction = v.direction + 4
		if(v.direction > 6) then
			v.direction = v.direction - 8
		end
		log("  new pe.dir = "..v.direction)
		
		tags[k] = v
	end
	
	return tags
end