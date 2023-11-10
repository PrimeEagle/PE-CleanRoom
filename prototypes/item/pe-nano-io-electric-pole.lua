local item = table.deepcopy(data.raw["item"]["small-electric-pole"])

item.name = "pe-nano-io-electric-pole"
item.icon = pe.cr.path.."/graphics/icons/pe-nano-electric-pole.png"
item.icon_size = 32
item.subgroup = "energy-pipe-distribution"
item.order = "a[energy]-c[small-electric-pole]"
item.stack_size = 50
item.place_result = "pe-nano-io-electric-pole"

data:extend{item}