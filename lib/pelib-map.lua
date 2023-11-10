if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.map then pe.lib.map = {} end
if not pe.lib.maps then pe.lib.maps = {} end

function pe.lib.map.load_config(config)
    log("pe.lib.map.load_config")
    
    if (pe.lib.cfg.is_valid(config) and config.enabled) then
        local cfg = {}

        cfg.name = pe.lib.cfg.section.get_value(config, "name")
        cfg.generate_with_lab_tiles = pe.lib.cfg.section.get_value(config, "generate_with_lab_tiles", false)
        cfg.always_day = pe.lib.cfg.section.get_value(config, "always_day", false)
        cfg.daytime = pe.lib.cfg.section.get_value(config, "daytime", pe.lib.MAP_DEFAULT_DAYTIME)
        cfg.wind_speed = pe.lib.cfg.section.get_value(config, "wind_speed", pe.lib.MAP_DEFAULT_WIND_SPEED)
        cfg.wind_orientation = pe.lib.cfg.section.get_value(config, "wind_orientation", pe.lib.MAP_DEFAULT_WIND_ORIENTATION)
        cfg.wind_orientation_change = pe.lib.cfg.section.get_value(config, "wind_orientation_change", pe.lib.MAP_DEFAULT_WIND_ORIENTATION_CHANGE)
        cfg.peaceful_mode = pe.lib.cfg.section.get_value(config, "peaceful_mode", false)
        cfg.freeze_daytime = pe.lib.cfg.section.get_value(config, "freeze_daytime", false)
        cfg.ticks_per_day = pe.lib.cfg.section.get_value(config, "ticks_per_day", pe.lib.MAP_DEFAULT_TICKS_PER_DAY)
        cfg.dusk = pe.lib.cfg.section.get_value(config, "dusk", pe.lib.MAP_DEFAULT_DUSK)
        cfg.dawn = pe.lib.cfg.section.get_value(config, "dawn", pe.lib.MAP_DEFAULT_DAWN)
        cfg.evening = pe.lib.cfg.section.get_value(config, "evening", pe.lib.MAP_DEFAULT_EVENING)
        cfg.morning = pe.lib.cfg.section.get_value(config, "morning", pe.lib.MAP_DEFAULT_MORNING)
        cfg.solar_power_multiplier = pe.lib.cfg.section.get_value(config, "solar_power_multiplier", pe.lib.MAP_DEFAULT_SOLAR_POWER_MULTIPLIER)
        cfg.min_brightness = pe.lib.cfg.section.get_value(config, "min_brightness", pe.lib.MAP_DEFAULT_MIN_BRIGHTNESS)
        cfg.brightness_visual_weights = pe.lib.cfg.section.get_value(config, "brightness_visual_weights", { 0, 0, 0 })
        cfg.show_clouds = pe.lib.cfg.section.get_value(config, "show_clouds", true)
        
        cfg.map_gen_settings = {}
        if (pe.lib.cfg.section.is_available(config, "map_gen_settings")) then
            cfg.map_gen_settings.terrain_segmentation = pe.lib.cfg.section.get_value(config, "terrain_segmentation", pe.lib.defines.map_gen_size.normal)
            cfg.map_gen_settings.water = pe.lib.cfg.section.get_value(config, "water", pe.lib.defines.map_gen_size.normal)
            cfg.map_gen_settings.autoplace_controls = pe.lib.cfg.section.get_value(config, "autoplace_controls")
            cfg.map_gen_settings.default_enable_all_autoplace_controls = pe.lib.cfg.section.get_value(config, "default_enable_all_autoplace_controls", true)
            cfg.map_gen_settings.autoplace_settings = pe.lib.cfg.section.get_value(config, "autoplace_settings")
            cfg.map_gen_settings.seed = pe.lib.cfg.section.get_value(config, "seed", pe.lib.MAP_DEFAULT_SEED)
            cfg.map_gen_settings.width = pe.lib.cfg.section.get_value(config, "width", pe.lib.MAP_DEFAULT_WIDTH)
            cfg.map_gen_settings.height = pe.lib.cfg.section.get_value(config, "height", pe.lib.MAP_DEFAULT_HEIGHT)
            cfg.map_gen_settings.starting_area = pe.lib.cfg.section.get_value(config, "starting_area", pe.lib.defines.map_gen_size.normal)
            cfg.map_gen_settings.starting_points = pe.lib.cfg.section.get_value(config, "starting_points", { { 0, 0 } })
            cfg.map_gen_settings.peaceful_mode = pe.lib.cfg.section.get_value(config, "peaceful_mode", false)
            cfg.map_gen_settings.property_expression_names = pe.lib.cfg.section.get_value(config, "property_expression_names")
            
            cfg.map_gen_settings.cliff_settings = {}
            if (pe.lib.cfg.section.is_available(config.map_gen_settings, "cliff_settings")) then
                cfg.map_gen_settings.name = pe.lib.cfg.section.get_value(config, "name")
                cfg.map_gen_settings.cliff_elevation_0 = pe.lib.cfg.section.get_value(config, "cliff_elevation_0", pe.lib.MAP_DEFAULT_CLIFF_ELEVATION)
                cfg.map_gen_settings.cliff_elevation_interval = pe.lib.cfg.section.get_value(config, "cliff_elevation_interval", pe.lib.MAP_DEFAULT_CLIFF_ELEVATION_INTERVAL)
                cfg.map_gen_settings.richness = pe.lib.cfg.section.get_value(config, "richness", pe.lib.MAP_DEFAULT_CLIFF_RICHNESS)
            end
        end

        if (not pe.lib.maps[cfg.name]) then
            pe.lib.maps[cfg.name] = {}
        end

        pe.lib.maps[cfg.name].config = table.deepcopy(cfg)
    end
end


function pe.lib.map.create_surface(config)
    log("pe.lib.map.create_surface")
    
    local s = game.create_surface(config.name, config.map_gen_settings)
    
    s.generate_with_lab_tiles = config.generate_with_lab_tiles
    s.always_day = config.always_day
    s.daytime = config.daytime
    s.wind_speed = config.wind_speed
    s.wind_orientation = config.wind_orientation
    s.wind_orientation_change = config.wind_orientation_change
    s.peaceful_mode = config.peaceful_mode
    s.freeze_daytime = config.freeze_daytime
    s.ticks_per_day = config.ticks_per_day
    s.dusk = config.dusk
    s.dawn = config.dawn
    s.evening = config.evening
    s.morning = config.morning
    s.solar_power_multiplier = config.solar_power_multiplier
    s.min_brightness = config.min_brightness
    s.brightness_visual_weights = config.brightness_visual_weights
    s.show_clouds = config.show_clouds

    return s
end