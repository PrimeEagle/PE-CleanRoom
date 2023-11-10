local item = 
  {
    type = "item",
    name = "pe-nano-circuit-pole",
    icon = pe.cr.path.."/graphics/icons/pe-nano-circuit-pole.png",
    icon_size = 32,
    subgroup = "circuit-network",
    order = "a[energy]-c[pe-nano-circuit-pole]",
    place_result = "pe-nano-circuit-pole",
    stack_size = 50
  }
  
  data:extend{item}