if not pe then pe = {} end
if not pe.lib then pe.lib = {} end

pe.lib.XFR_PREFIX = "DCXFR-"

-- names
pe.lib.NAME_PREFIX = "pe-"
pe.lib.RESOURCE_SUFFIX = "-ore"
pe.lib.RESOURCE_PARTICLE_SUFFIX = "-particle"
pe.lib.RESOURCE_NOISE_LAYER_SUFFIX = "-noise"
pe.lib.RESOURCE_AUTOPLACE_SUFFIX = "" --"-autocontrol"
pe.lib.RESOURCE_SUFFIX = "-ore"
pe.lib.PARTICLE_SUFFIX = "-particle"
pe.lib.RESOURCE_SETTING_ENABLED_SUFFIX = "-setting-enabled"
pe.lib.RESOURCE_SETTING_STARTING_AREA_SUFFIX = "-setting-starting-area"
pe.lib.RESOURCE_SETTING_INFINITE_SUFFIX = "-setting-infinite"
pe.lib.RESOURCE_SETTING_OFFSHORE_SUFFIX = "-setting-offshore"

-- prototype types
pe.lib.PROTOTYPE_TYPE_ITEM = "item"
pe.lib.PROTOTYPE_TYPE_ITEM_SUBGROUP = "item-subgroup"
pe.lib.PROTOTYPE_TYPE_ITEM_GROUP = "intermediate-products"
pe.lib.PROTOTYPE_TYPE_NOISE_LAYER = "noise-layer"
pe.lib.PROTOTYPE_TYPE_PARTICLE = "optimized-particle"
pe.lib.PROTOTYPE_TYPE_AUTOPLACE_CONTROL = "autoplace-control"
pe.lib.PROTOTYPE_TYPE_RESOURCE = "resource"

-- map config
pe.lib.MAP_DEFAULT_DAYTIME = 0.5
pe.lib.MAP_DEFAULT_WIND_SPEED = 0
pe.lib.MAP_DEFAULT_WIND_ORIENTATION = 0
pe.lib.MAP_DEFAULT_WIND_ORIENTATION_CHANGE = 0
pe.lib.MAP_DEFAULT_TICKS_PER_DAY = 25000
pe.lib.MAP_DEFAULT_DUSK = 0.25
pe.lib.MAP_DEFAULT_DAWN = 0.75
pe.lib.MAP_DEFAULT_EVENING = 0.45
pe.lib.MAP_DEFAULT_MORNING = 0.55
pe.lib.MAP_DEFAULT_SOLAR_POWER_MULTIPLIER = 1
pe.lib.MAP_DEFAULT_MIN_BRIGHTNESS = 0.15
pe.lib.MAP_DEFAULT_SEED = 100
pe.lib.MAP_DEFAULT_WIDTH = 0
pe.lib.MAP_DEFAULT_HEIGHT = 0
pe.lib.MAP_DEFAULT_CLIFF_ELEVATION = 10
pe.lib.MAP_DEFAULT_CLIFF_ELEVATION_INTERVAL = 40
pe.lib.MAP_DEFAULT_CLIFF_RICHNESS = 1


-- ore images
pe.lib.DEFAULT_RESOURCE_ICON_1 = "/graphics/lib/icons/ore-1.png"
pe.lib.DEFAULT_RESOURCE_ICON_2 = "/graphics/lib/icons/ore-2.png"
pe.lib.DEFAULT_RESOURCE_ICON_3 = "/graphics/lib/icons/ore-3.png"
pe.lib.DEFAULT_RESOURCE_ICON_4 = "/graphics/lib/icons/ore-4.png"
pe.lib.DEFAULT_RESOURCE_ICON_5 = "/graphics/lib/icons/ore-5.png"
pe.lib.DEFAULT_RESOURCE_ICON_6 = "/graphics/lib/icons/ore-6.png"
pe.lib.DEFAULT_RESOURCE_ICON_LIQUID = "/graphics/lib/icons/liquid.png"
pe.lib.DEFAULT_RESOURCE_1 = "/graphics/lib/entity/ores/ore-1.png"
pe.lib.DEFAULT_RESOURCE_2 = "/graphics/lib/entity/ores/ore-2.png"
pe.lib.DEFAULT_RESOURCE_3 = "/graphics/lib/entity/ores/ore-3.png"
pe.lib.DEFAULT_RESOURCE_4 = "/graphics/lib/entity/ores/ore-4.png"
pe.lib.DEFAULT_RESOURCE_5 = "/graphics/lib/entity/ores/ore-5.png"
pe.lib.DEFAULT_RESOURCE_LIQUID = "/graphics/lib/entity/ores/ore-liquid.png"
pe.lib.DEFAULT_RESOURCE_HR_1 = "/graphics/lib/entity/ores/hr-ore-1.png"
pe.lib.DEFAULT_RESOURCE_HR_2 = "/graphics/lib/entity/ores/hr-ore-2.png"
pe.lib.DEFAULT_RESOURCE_HR_3 = "/graphics/lib/entity/ores/hr-ore-3.png"
pe.lib.DEFAULT_RESOURCE_HR_4 = "/graphics/lib/entity/ores/hr-ore-4.png"
pe.lib.DEFAULT_RESOURCE_HR_5 = "/graphics/lib/entity/ores/hr-ore-5.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_1 = "/graphics/lib/entity/ores/ore-particle-1.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_2 = "/graphics/lib/entity/ores/ore-particle-2.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_3 = "/graphics/lib/entity/ores/ore-particle-3.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_4 = "/graphics/lib/entity/ores/ore-particle-4.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_5 = "/graphics/lib/entity/ores/ore-particle-5.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_6 = "/graphics/lib/entity/ores/ore-particle-6.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_7 = "/graphics/lib/entity/ores/ore-particle-7.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_8 = "/graphics/lib/entity/ores/ore-particle-8.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_9 = "/graphics/lib/entity/ores/ore-particle-9.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_1 = "/graphics/lib/entity/ores/ore-particle-shadow-1.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_2 = "/graphics/lib/entity/ores/ore-particle-shadow-2.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_3 = "/graphics/lib/entity/ores/ore-particle-shadow-3.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_4 = "/graphics/lib/entity/ores/ore-particle-shadow-4.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_5 = "/graphics/lib/entity/ores/ore-particle-shadow-5.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_6 = "/graphics/lib/entity/ores/ore-particle-shadow-6.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_7 = "/graphics/lib/entity/ores/ore-particle-shadow-7.png"
pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_8 = "/graphics/lib/entity/ores/ore-particle-shadow-8.png"

-- ore config, main
pe.lib.DEFAULT_RESOURCE_SUBGROUP = "pe-ores"
pe.lib.DEFAULT_RESOURCE_COLLISION_BOX = { { -0.1, -0.1}, {0.1, 0.1} }
pe.lib.DEFAULT_RESOURCE_SELECTION_BOX = { { -0.5, -0.5}, {0.5, 0.5} }
pe.lib.DEFAULT_RESOURCE_PRIORITY = "extra-high"

-- ore config, mining
pe.lib.DEFAULT_RESOURCE_MINING_RESULT_AMOUNT = 1
pe.lib.DEFAULT_RESOURCE_MINING_FLUID_AMOUNT = 10
pe.lib.DEFAULT_RESOURCE_MINING_INFINITE_DEPLETION_AMOUNT = 1
pe.lib.DEFAULT_RESOURCE_MINING_TIME = 1

-- ore config, resource
pe.lib.DEFAULT_RESOURCE_MINIMUM = 35
pe.lib.DEFAULT_RESOURCE_NORMAL = 350
pe.lib.DEFAULT_RESOURCE_AUTOPLACE_REGULAR_RQ_FACTOR_MULTIPLIER = 1
pe.lib.DEFAULT_RESOURCE_AUTOPLACE_STARTING_RQ_FACTOR_MULTIPLIER = 1
pe.lib.DEFAULT_RESOURCE_AUTOPLACE_BASE_DENSITY = 4
pe.lib.DEFAULT_RESOURCE_AUTOPLACE_RANDOM_PROBABILITY = 1
pe.lib.DEFAULT_RESOURCE_AUTOPLACE_BASE_SPOTS_PER_KM2 = 2.5
pe.lib.DEFAULT_RESOURCE_AUTOPLACE_SEED1 = 100
pe.lib.DEFAULT_RESOURCE_RESOURCE_CATEGORY = "basic-solid"
pe.lib.DEFAULT_RESOURCE_RESOURCE_PATCH_SEARCH_RADIUS = 3
pe.lib.DEFAULT_RESOURCE_PEAK_INFLUENCE = 1
pe.lib.DEFAULT_RESOURCE_PEAK_RICHNESS_INFLUENCE = 0
pe.lib.DEFAULT_RESOURCE_PEAK_NOISE_PERSISTENCE = 0.5
pe.lib.DEFAULT_RESOURCE_PEAK_NOISE_OCTAVES_DIFFERENCE = -0.85
pe.lib.DEFAULT_RESOURCE_PEAK_NOISE_SCALE = 1
pe.lib.DEFAULT_RESOURCE_PEAK_RANGE = 0

-- ore config, item
pe.lib.DEFAULT_RESOURCE_ITEM_STACK_SIZE = 50

-- ore config, particle
pe.lib.DEFAULT_RESOURCE_PARTICLE_LIFETIME = 180

-- ore config, icon
pe.lib.DEFAULT_RESOURCE_ICON_SIZE = 32
pe.lib.DEFAULT_RESOURCE_ICON_MIPMAP_SIZE = 4

-- ore config, sprite
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_WIDTH = 64
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HEIGHT = 64
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_FRAME_COUNT = 8
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_VARIATION_COUNT = 8
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_SCALE = 1.0
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_WIDTH = 128
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_HEIGHT = 128
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_FRAME_COUNT = 8
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_VARIATION_COUNT = 8
pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_SCALE = 0.5

-- ore config, effect
pe.lib.DEFAULT_RESOURCE_EFFECT_WIDTH = 64
pe.lib.DEFAULT_RESOURCE_EFFECT_HEIGHT = 64
pe.lib.DEFAULT_RESOURCE_EFFECT_FRAME_COUNT = 4
pe.lib.DEFAULT_RESOURCE_EFFECT_VARIATION_COUNT = 8
pe.lib.DEFAULT_RESOURCE_EFFECT_SCALE = 1
pe.lib.DEFAULT_RESOURCE_EFFECT_BLEND_MODE = "additive"
pe.lib.DEFAULT_RESOURCE_EFFECT_FILENAME = "/graphics/lib/entity/ores/ore-5-glow.png"
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_WIDTH = 128
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_HEIGHT = 128
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_FRAME_COUNT = 4
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_VARIATION_COUNT = 8
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_SCALE = 0.5
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_BLEND_MODE = "additive"
pe.lib.DEFAULT_RESOURCE_EFFECT_HR_FILENAME = "/graphics/lib/entity/ores/hr-ore-5-glow.png"
pe.lib.DEFAULT_RESOURCE_EFFECT_ANIMATION_PERIOD = 5
pe.lib.DEFAULT_RESOURCE_EFFECT_EFFECT_ANIMATION_PERIOD_DEVIATION = 1
pe.lib.DEFAULT_RESOURCE_EFFECT_DARKNESS_MULTIPLIER = 3.6
pe.lib.DEFAULT_RESOURCE_EFFECT_MIN_ALPHA = 0.2
pe.lib.DEFAULT_RESOURCE_EFFECT_MAX_ALPHA = 0.3
pe.lib.DEFAULT_RESOURCE_EFFECT_STAGE_MULT = 100