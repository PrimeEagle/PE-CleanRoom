local item = 
  {
    type = "item",
    name = "pe-circuit-pole",
    icon = pe.cr.path.."/graphics/icons/pe-circuit-pole.png",
    icon_size = 32,
    subgroup = "circuit-network",
    order = "a[energy]-c[pe-circuit-pole]",
    place_result = "pe-circuit-pole",
    stack_size = 50
  }
  
  data:extend{item}