data:extend{
  {
    type = "tile",
    name = "pe-grid-clean-room",
    collision_mask = {"ground-tile"},
    layer = 70,
    variants =
    {
      main =
      {
        {
          picture = pe.cr.path.."/graphics/tiles/pe-grid-clean-room.png",
          count = 1,
          size = 1
        },
      },
      inner_corner =
      {
        picture = pe.cr.path.."/graphics/tiles/pe-grid-clean-room.png",
        count = 0
      },
      outer_corner =
      {
        picture = pe.cr.path.."/graphics/tiles/pe-grid-clean-room.png",
        count = 0
      },
      side =
      {
        picture = pe.cr.path.."/graphics/tiles/pe-grid-clean-room.png",
        count = 0
      }
    },
    map_color={r=0, g=0, b=0},
    ageing=0.0006,
    pollution_absorption_per_second = 1000000,
  }
}
