local item = table.deepcopy(data.raw.item["concrete"])

item.name = "pe-grid-clean-room"
item.icon = pe.cr.path.."/graphics/tiles/pe-grid-clean-room.png"
item.icon_size = 52
item.place_result = "pe-grid-clean-room"
item.type = "item-with-tags"
item.order = "b[concrete]-c[pe-grid-clean-room]"

data:extend{item}