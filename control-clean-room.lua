if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

require("util")
require("lib/pelib-control")
require("clean-room-constants")
require("control-clean-room-globals")
require("control-clean-room-util")
require("control-clean-room-surface")
require("control-clean-room-room")
require("control-clean-room-tags")
require("control-clean-room-blueprint")
require("control-clean-room-delegates")
require("control-clean-room-events")



function pe.cr.player_enter(player, ent)
	log("pe.cr.player_enter - "..ent.name)
	local room = pe.cr.get_or_create_room(ent)
	--log("  surface is "..room.surface.name)
	room.players = room.players or {}
	--log("  surface is "..room.surface.name)
	global.players[player.index] = { player = player, surface = player.surface, position = player.position, room = room }
	--log("  surface is "..room.surface.name)
	table.insert(room.players, global.players[player.index])
	--log("  surface is "..room.surface.name)
	
	player.teleport({0, 0}, room.surface)
	
	player.gui.left.add{ type = "button", caption = "Exit Clean Room", name = "clean_room_exit" }
end




function pe.cr.player_exit(player)
	log("pe.cr.player_exit")
	local room = global.players[player.index].room
	
	local pk, pv

	for k, v in pairs(room.players) do
		if(v.player == player) then 
			pk, pv = k, v 
			break 
		end 
	end
	
	player.teleport(pv.position, pv.surface)
	room.players[pk] = nil
	global.players[player.index] = nil

	if(table_size(room.players) == 0) then
		pe.cr.build_components(room)
	end
end