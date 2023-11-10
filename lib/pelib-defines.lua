if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.defines then pe.lib.defines = {} end

pe.lib.defines.dir = {
    up = 0,
    right = 2,
    down = 4,
    left = 6 
}

pe.lib.defines.setting_type = {
    startup = 1,
    global = 2,
    player = 3
}

pe.lib.defines.ore_setting_type = {
    enabled = 1,
    starting_area = 2,
    infinite = 3,
    offshore = 4
}

pe.lib.defines.ore_peak_type = {
    starting_area_weight = 1,
    elevation = 2,
    water = 3,
    temperature = 4,
    aux = 5,
    tier_from_start = 6,
    distance = 7
}

pe.lib.defines.section_type = {
    single = 1,
    group = 2,
    color = 3,
    setting = 4,
    names = 5,
    array = 6
}

pe.lib.defines.map_gen_size = {
    none = "none",
    very_low = "very-low",
    very_small = "very-small",
    very_poor = "very-poor",
    low = "low",
    small = "small",
    poor = "poor",
    normal = "normal",
    medium = "medium",
    regular = "regular",
    high = "high",
    big = "big",
    good = "good",
    very_high = "very-high",
    very_big = "very-big",
    very_good = "very-good"
}