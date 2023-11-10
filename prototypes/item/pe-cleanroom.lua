local item = table.deepcopy(data.raw.item["decider-combinator"])

item.name = "pe-cleanroom"
item.icon = pe.cr.path.."/graphics/entity/pe-cleanroom/pe-cleanroom.png"
item.icon_size = 52
item.place_result = "pe-cleanroom"
item.type = "item-with-tags"
item.order = "b[wires]-c[pe-cleanroom]"

data:extend{item}