local entity = table.deepcopy(data.raw["decider-combinator"]["decider-combinator"])

entity.name = "pe-cleanroom"
entity.icon = pe.cr.path.."/graphics/entity/pe-cleanroom/pe-cleanroom.png"
entity.icon_size = 52
entity.minable.result = entity.name

data:extend{entity}