if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.ore then pe.lib.ore = {} end
if not pe.lib.ores then pe.lib.ores = {} end

resource_autoplace = require("resource-autoplace")
require("pelib-resource-icon-piece-sizes")


function pe.lib.resource.get_names(ore)
    log("pe.lib.resource.get_names")
    local base = pe.lib.NAME_PREFIX .. ore .. pe.lib.RESOURCE_SUFFIX
    
    local result = {
        ore = ore,
        ore_name = ore .. pe.lib.RESOURCE_SUFFIX,
        internal_name = base,
        noise_layer_name = base .. pe.lib.RESOURCE_NOISE_LAYER_SUFFIX,
        particle_name = base .. pe.lib.RESOURCE_PARTICLE_SUFFIX,
        autoplace_name = base .. pe.lib.RESOURCE_AUTOPLACE_SUFFIX,
        setting_name_enabled = base .. pe.lib.RESOURCE_SETTING_ENABLED_SUFFIX,
        setting_name_starting_area = base .. pe.lib.RESOURCE_SETTING_STARTING_AREA_SUFFIX,
        setting_name_infinite = base .. pe.lib.RESOURCE_SETTING_INFINITE_SUFFIX
    }
    
    return result
end


function pe.lib.resource.create_default_pe_subgroup()
    log("pe.lib.resource.create_default_pe_subgroup")
    pe.lib.resource.create_subgroup(pe.lib.DEFAULT_RESOURCE_SUBGROUP)
end


function pe.lib.resource.create_subgroup(name, order)
    log("pe.lib.resource.create_subgroup")
    
    data:extend(
    {
      {
        type = pe.lib.PROTOTYPE_TYPE_ITEM_SUBGROUP,
        name = name,
        group = pe.lib.PROTOTYPE_TYPE_ITEM_GROUP,
        order = order or ""
      }
    })
end


function pe.lib.resource.load_config(config)
    log("pe.lib.resource.load_ore")
    
    if (pe.lib.cfg.is_valid(config) and config.enabled) then
        local cfg = {}
        local names = pe.lib.cfg.section.get_value(config, "names")

        cfg.names = names
        cfg.enabled = pe.lib.cfg.section.get_value(config, "enabled", true)
        cfg.map_color = pe.lib.cfg.section.get_value(config, "map_color")
        cfg.subgroup = pe.lib.cfg.section.get_value(config, "subgroup", pe.lib.DEFAULT_RESOURCE_SUBGROUP)

        cfg.tint = pe.lib.cfg.section.get_value(config, "tint")
        cfg.starting_area = pe.lib.cfg.section.get_value(config, "starting_area", false)

        cfg.mining = {}
        if (pe.lib.cfg.section.is_available(config, "mining")) then    
            cfg.mining.enabled = pe.lib.cfg.section.get_value(config.mining, "enabled", true)
            cfg.mining.mining_time = pe.lib.cfg.section.get_value(config.mining, "mining_time", pe.lib.DEFAULT_RESOURCE_MINING_TIME)
            cfg.mining.infinite = pe.lib.cfg.section.get_value(config.mining, "infinite", false)
            
            cfg.mining.mining_results = {}
            if (pe.lib.cfg.section.is_available(config.mining, "mining_results")) then
                for k, v in pairs(config.mining.mining_results) do
                    cfg.mining.mining_results[k].name = pe.lib.cfg.section.get_value(config.mining.mining_results[k], "name", cfg.names.internal_name)
                    cfg.mining.mining_results[k].amount = pe.lib.cfg.section.get_value(config.mining.mining_results[k], "amount", pe.lib.DEFAULT_RESOURCE_MINING_RESULT_AMOUNT)
                end
            end
            
            if (#cfg.mining.mining_results == 0) then
                table.insert(cfg.mining.mining_results, { name = cfg.names.internal_name, amount = pe.lib.DEFAULT_RESOURCE_MINING_RESULT_AMOUNT })
            end
            
            cfg.mining.fluid = {}
            if (pe.lib.cfg.section.is_available(config.mining, "fluid")) then
                cfg.mining.fluid.required_fluid = pe.lib.cfg.section.get_value(config.mining.fluid, "required_fluid")
                cfg.mining.fluid.fluid_amount = pe.lib.cfg.section.get_value(config.mining.fluid, "fluid_amount",  pe.lib.DEFAULT_RESOURCE_MINING_FLUID_AMOUNT)
            end
        end

        cfg.biome_restriction = {}
        if (pe.lib.cfg.section.is_available(config, "biome_restriction") and pe.lib.cfg.section.is_available(config.biome_restriction, "biomes")) then
            cfg.biome_restriction.enabled = pe.lib.cfg.section.get_value(config.biome_restriction, "enabled", true)
            cfg.biome_restriction.biomes = {}
            
            for k, v in pairs(config.biome_restriction.biomes) do
                cfg.biome_restriction.biomes[k] = pe.lib.cfg.section.get_value(config.biome_restriction.biomes[k])
            end
        end
        
        cfg.resource = {}
        if (pe.lib.cfg.section.is_available(config, "resource")) then
            cfg.resource.enabled = pe.lib.cfg.section.get_value(config.resource, "enabled", true)
            cfg.resource.category = pe.lib.cfg.section.get_value(config.resource, "category", pe.lib.DEFAULT_RESOURCE_RESOURCE_CATEGORY)
            cfg.resource.order = pe.lib.cfg.section.get_value(config.resource, "order", "")
            cfg.resource.resource_patch_search_radius = pe.lib.cfg.section.get_value(config.resource, "resource_patch_search_radius", pe.lib.DEFAULT_RESOURCE_RESOURCE_PATCH_SEARCH_RADIUS)
            cfg.resource.collision_box = pe.lib.cfg.section.get_value(config.resource, "collision_box", pe.lib.DEFAULT_RESOURCE_COLLISION_BOX)
            cfg.resource.selection_box = pe.lib.cfg.section.get_value(config.resource, "selection_box", pe.lib.DEFAULT_RESOURCE_SELECTION_BOX)
            cfg.resource.map_grid = pe.lib.cfg.section.get_value(config.resource, "map_grid", true)
            
            cfg.resource.minimum = pe.lib.cfg.section.get_value(config.resource, "minimum", pe.lib.DEFAULT_RESOURCE_MINIMUM)
            if (cfg.resource.minimum < 1) then
                cfg.resource.minimum = 1
            end
            
            cfg.resource.normal = pe.lib.cfg.section.get_value(config.resource, "normal", pe.lib.DEFAULT_RESOURCE_NORMAL)
            if (cfg.resource.normal < 1) then
                cfg.resource.normal = 1
            end
            
            cfg.resource.autoplace = {}
            if (pe.lib.cfg.section.is_available(config.resource, "autoplace")) then
                cfg.resource.autoplace.enabled = pe.lib.cfg.section.get_value(config.resource.autoplace, "enabled", true)
                cfg.resource.autoplace.order = pe.lib.cfg.section.get_value(config.resource.autoplace, "order", "")
                cfg.resource.autoplace.base_density = pe.lib.cfg.section.get_value(config.resource.autoplace, "base_density", pe.lib.DEFAULT_RESOURCE_AUTOPLACE_BASE_DENSITY)
                cfg.resource.autoplace.has_starting_area_placement = pe.lib.cfg.section.get_value(config.resource.autoplace, "has_starting_area_placement", false)
                cfg.resource.autoplace.regular_rq_factor_multiplier = pe.lib.cfg.section.get_value(config.resource.autoplace, "regular_rq_factor_multiplier", pe.lib.DEFAULT_RESOURCE_AUTOPLACE_REGULAR_RQ_FACTOR_MULTIPLIER)
                cfg.resource.autoplace.starting_rq_factor_multiplier = pe.lib.cfg.section.get_value(config.resource.autoplace, "starting_rq_factor_multiplier", pe.lib.DEFAULT_RESOURCE_AUTOPLACE_STARTING_RQ_FACTOR_MULTIPLIER)
                cfg.resource.autoplace.patch_set_name = pe.lib.cfg.section.get_value(config.resource.autoplace, "patch_set_name")
                cfg.resource.autoplace.autoplace_control_name = pe.lib.cfg.section.get_value(config.resource.autoplace, "autoplace_control_name")
                cfg.resource.autoplace.random_probability = pe.lib.cfg.section.get_value(config.resource.autoplace, "random_probability", pe.lib.DEFAULT_RESOURCE_AUTOPLACE_RANDOM_PROBABILITY)
                cfg.resource.autoplace.base_spots_per_km2 = pe.lib.cfg.section.get_value(config.resource.autoplace, "base_spots_per_km2", pe.lib.DEFAULT_RESOURCE_AUTOPLACE_BASE_SPOTS_PER_KM2)
                cfg.resource.autoplace.seed1 = pe.lib.cfg.section.get_value(config.resource.autoplace, "seed1", pe.lib.DEFAULT_RESOURCE_AUTOPLACE_SEED1)
            
                cfg.resource.autoplace.peaks = {}
                if (pe.lib.cfg.section.is_available(config.resource.autoplace, "peaks")) then
                    for i = 1, #config.resource.autoplace.peaks do
                        local v = config.resource.autoplace.peaks[i]
                        if (not type(v) == "boolean") then
                            local peak = 
                            {
                                influence = pe.lib.cfg.section.get_value(v, "influence", pe.lib.DEFAULT_RESOURCE_PEAK_INFLUENCE),
                                min_influence = pe.lib.cfg.section.get_value(v, "min_influence"),
                                max_influence = pe.lib.cfg.section.get_value(v, "max_influence"),
                                richness_influence = pe.lib.cfg.section.get_value(v, "richness_influence", pe.lib.DEFAULT_RESOURCE_PEAK_RICHNESS_INFLUENCE),
                                noise_scale = pe.lib.cfg.section.get_value(v, "noise_scale", pe.lib.DEFAULT_RESOURCE_PEAK_NOISE_SCALE),
                                noise_layer = pe.lib.cfg.section.get_value(v, "noise_layer", names.noise_layer_name),
                                noise_octaves_difference = pe.lib.cfg.section.get_value(v, "noise_octaves_difference", pe.lib.DEFAULT_RESOURCE_PEAK_NOISE_OCTAVES_DIFFERENCE),
                                noise_persistence = pe.lib.cfg.section.get_value(v, "noise_persistence", pe.lib.DEFAULT_RESOURCE_PEAK_NOISE_PERSISTENCE),
                                starting_area_weight_optimal = pe.lib.cfg.section.get_value(v, "starting_area_weight_optimal"),
                                starting_area_weight_range = pe.lib.cfg.section.get_value(v, "starting_area_weight_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                starting_area_weight_max_range = pe.lib.cfg.section.get_value(v, "starting_area_weight_max_range"),
                                starting_area_weight_top_property_limit = pe.lib.cfg.section.get_value(v, "starting_area_weight_top_property_limit"),
                                elevation_optimal = pe.lib.cfg.section.get_value(v, "elevation_optimal"),
                                elevation_range = pe.lib.cfg.section.get_value(v, "elevation_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                elevation_max_range = pe.lib.cfg.section.get_value(v, "elevation_max_range"),
                                elevation_top_property_limit = pe.lib.cfg.section.get_value(v, "elevation_top_property_limit"),
                                water_optimal = pe.lib.cfg.section.get_value(v, "water_optimal"),
                                water_range = pe.lib.cfg.section.get_value(v, "water_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                water_max_range = pe.lib.cfg.section.get_value(v, "water_max_range"),
                                water_top_property_limit = pe.lib.cfg.section.get_value(v, "water_top_property_limit"),
                                temperature_optimal = pe.lib.cfg.section.get_value(v, "temperature_optimal"),
                                temperature_range = pe.lib.cfg.section.get_value(v, "temperature_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                temperature_max_range = pe.lib.cfg.section.get_value(v, "temperature_max_range"),
                                temperature_top_property_limit = pe.lib.cfg.section.get_value(v, "temperature_top_property_limit"),
                                aux_optimal = pe.lib.cfg.section.get_value(v, "aux_optimal"),
                                aux_range = pe.lib.cfg.section.get_value(v, "aux_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                aux_max_range = pe.lib.cfg.section.get_value(v, "aux_max_range"),
                                aux_top_property_limit = pe.lib.cfg.section.get_value(v, "aux_top_property_limit"),
                                tier_from_start_optimal = pe.lib.cfg.section.get_value(v, "tier_from_start_optimal"),
                                tier_from_start_range = pe.lib.cfg.section.get_value(v, "tier_from_start_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                tier_from_start_max_range = pe.lib.cfg.section.get_value(v, "tier_from_start_max_range"),
                                tier_from_start_top_property_limit = pe.lib.cfg.section.get_value(v, "tier_from_start_top_property_limit"),
                                distance_optimal = pe.lib.cfg.section.get_value(v, "distance_optimal"),
                                distance_range = pe.lib.cfg.section.get_value(v, "distance_range", pe.lib.DEFAULT_RESOURCE_PEAK_RANGE),
                                distance_max_range = pe.lib.cfg.section.get_value(v, "distance_max_range"),
                                distance_top_property_limit = pe.lib.cfg.section.get_value(v, "distance_top_property_limit")
                            }
                            
                            table.insert(cfg.resource.autoplace.peaks, v)
                        end
                    end
                end
            end
        end

        cfg.item  = {}
        if (pe.lib.cfg.section.is_available(config, "item")) then
            cfg.item.enabled = pe.lib.cfg.section.get_value(config.item, "enabled", true)
            cfg.item.order = pe.lib.cfg.section.get_value(config.item, "order", "")
            cfg.item.stack_size = pe.lib.cfg.section.get_value(config.item, "stack_size", pe.lib.DEFAULT_RESOURCE_ITEM_STACK_SIZE)
            cfg.item.tint = pe.lib.cfg.section.get_value(config.item, "tint", cfg.tint)
        end        

        cfg.particle = {}
        if (pe.lib.cfg.section.is_available(config, "particle")) then
            cfg.particle.enabled = pe.lib.cfg.section.get_value(config.particle, "enabled", true)
            cfg.particle.tint = pe.lib.cfg.section.get_value(config.particle, "tint", cfg.tint)
            cfg.particle.life_time = pe.lib.cfg.section.get_value(config.particle, "life_time", pe.lib.DEFAULT_RESOURCE_PARTICLE_LIFETIME)
        end

        cfg.autoplace_control = {}
        if (pe.lib.cfg.section.is_available(config, "autoplace_control")) then
            cfg.autoplace_control.enabled = pe.lib.cfg.section.get_value(config.autoplace_control, "enabled", true)
            cfg.autoplace_control.richness = pe.lib.cfg.section.get_value(config.autoplace_control, "richness", true)
            cfg.autoplace_control.can_be_disabled = pe.lib.cfg.section.get_value(config.autoplace_control, "can_be_disabled", true)
            cfg.autoplace_control.order = pe.lib.cfg.section.get_value(config.autoplace_control, "order", "")
        end

        cfg.images = {}
        if (pe.lib.cfg.section.is_available(config, "images")) then
            cfg.images.enabled = pe.lib.cfg.section.get_value(config.images, "enabled", true)
            cfg.images.create_variations = pe.lib.cfg.section.get_value(config.images, "create_variations", true)
            
            cfg.images.single_icon = {}
            if (pe.lib.cfg.section.is_available(config.images, "single_icon")) then
                cfg.images.single_icon.enabled = pe.lib.cfg.section.get_value(config.images.single_icon, "enabled", true)
                cfg.images.single_icon.icon = pe.lib.cfg.section.get_value(config.images.single_icon, "icon")
                cfg.images.single_icon.icon_size = pe.lib.cfg.section.get_value(config.images.single_icon, "icon_size", pe.lib.DEFAULT_RESOURCE_ICON_SIZE)
                cfg.images.single_icon.icon_mipmaps = pe.lib.cfg.section.get_value(config.images.single_icon, "icon_mipmaps", pe.lib.DEFAULT_RESOURCE_ICON_MIPMAP_SIZE)
            end
            
            cfg.images.multiple_icons = {}
            if (pe.lib.cfg.section.is_available(config.images, "multiple_icons")) then
                cfg.images.multiple_icons.enabled = pe.lib.cfg.section.get_value(config.images.multiple_icons, "enabled", true)
                cfg.images.multiple_icons.icons = pe.lib.cfg.section.get_value(config.images.multiple_icons, "icons", {})
            end
            
            cfg.images.sprite = {}
            if (pe.lib.cfg.section.is_available(config.images, "sprite")) then
                cfg.images.sprite.enabled = pe.lib.cfg.section.get_value(config.images.sprite, "enabled", true)
                cfg.images.sprite.sheet = pe.lib.cfg.section.get_value(config.images.sprite, "sheet", 1)
                cfg.images.sprite.filename = pe.lib.cfg.section.get_value(config.images.sprite, "filename")
                cfg.images.sprite.width = pe.lib.cfg.section.get_value(config.images.sprite, "width", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_WIDTH)
                cfg.images.sprite.height = pe.lib.cfg.section.get_value(config.images.sprite, "height", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HEIGHT)
                cfg.images.sprite.frame_count = pe.lib.cfg.section.get_value(config.images.sprite, "frame_count", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_FRAME_COUNT)
                cfg.images.sprite.variation_count = pe.lib.cfg.section.get_value(config.images.sprite, "variation_count", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_VARIATION_COUNT)
                cfg.images.sprite.scale = pe.lib.cfg.section.get_value(config.images.sprite, "scale", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_SCALE)
                cfg.images.sprite.tint = pe.lib.cfg.section.get_value(config.images.sprite, "tint", cfg.tint)
                
                cfg.images.sprite.hr_version = {}
                if (pe.lib.cfg.section.is_available(config.images.sprite, "hr_version")) then
                    cfg.images.sprite.hr_version.enabled = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "enabled", true)
                    cfg.images.sprite.hr_version.sheet = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "sheet")
                    cfg.images.sprite.hr_version.filename = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "filename")
                    cfg.images.sprite.hr_version.width = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "width", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_WIDTH)
                    cfg.images.sprite.hr_version.height = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "height", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_HEIGHT)
                    cfg.images.sprite.hr_version.frame_count = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "frame_count", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_FRAME_COUNT)
                    cfg.images.sprite.hr_version.variation_count = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "variation_count", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_VARIATION_COUNT)
                    cfg.images.sprite.hr_version.scale = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "scale", pe.lib.DEFAULT_RESOURCE_SPRITE_SHEET_HR_SCALE)
                    cfg.images.sprite.hr_version.tint = pe.lib.cfg.section.get_value(config.images.sprite.hr_version, "tint", cfg.tint)
                end
            end
            
            cfg.images.effect = {}
            if (pe.lib.cfg.section.is_available(config.images, "effect")) then
                cfg.images.effect.enabled = pe.lib.cfg.section.get_value(config.images.effect, "enabled", true)
                cfg.images.effect.filename = pe.lib.cfg.section.get_value(config.images.effect, "filename", pe.lib.DEFAULT_RESOURCE_EFFECT_FILENAME)
                cfg.images.effect.width = pe.lib.cfg.section.get_value(config.images.effect, "width", pe.lib.DEFAULT_RESOURCE_EFFECT_WIDTH)
                cfg.images.effect.height = pe.lib.cfg.section.get_value(config.images.effect, "height", pe.lib.DEFAULT_RESOURCE_EFFECT_HEIGHT)
                cfg.images.effect.frame_count = pe.lib.cfg.section.get_value(config.images.effect, "frame_count", pe.lib.DEFAULT_RESOURCE_EFFECT_FRAME_COUNT)
                cfg.images.effect.variation_count = pe.lib.cfg.section.get_value(config.images.effect, "variation_count", pe.lib.DEFAULT_RESOURCE_EFFECT_VARIATION_COUNT)
                cfg.images.effect.tint = pe.lib.cfg.section.get_value(config.images.effect, "tint", cfg.tint)
                cfg.images.effect.scale = pe.lib.cfg.section.get_value(config.images.effect, "scale", pe.lib.DEFAULT_RESOURCE_EFFECT_SCALE)
                cfg.images.effect.blend_mode = pe.lib.cfg.section.get_value(config.images.effect, "blend_mode", pe.lib.DEFAULT_RESOURCE_EFFECT_BLEND_MODE)
                
                cfg.images.effect.effect_animation_period = pe.lib.cfg.section.get_value(config.images.effect, "animation_period", pe.lib.DEFAULT_RESOURCE_EFFECT_ANIMATION_PERIOD)
                cfg.images.effect.effect_animation_period_deviation = pe.lib.cfg.section.get_value(config.images.effect, "animation_period_deviation", pe.lib.DEFAULT_RESOURCE_EFFECT_EFFECT_ANIMATION_PERIOD_DEVIATION)
                cfg.images.effect.effect_darkness_multiplier = pe.lib.cfg.section.get_value(config.images.effect, "darkness_multiplier", pe.lib.DEFAULT_RESOURCE_EFFECT_DARKNESS_MULTIPLIER)
                cfg.images.effect.min_effect_alpha = pe.lib.cfg.section.get_value(config.images.effect, "min_alpha", pe.lib.DEFAULT_RESOURCE_EFFECT_MIN_ALPHA)
                cfg.images.effect.max_effect_alpha = pe.lib.cfg.section.get_value(config.images.effect, "max_alpha", pe.lib.DEFAULT_RESOURCE_EFFECT_MAX_ALPHA)
                
                cfg.images.effect.hr_version = {}
                if (pe.lib.cfg.section.is_available(config.images.effect, "hr_version")) then
                    cfg.images.effect.hr_version.enabled = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "enabled", true)
                    cfg.images.effect.hr_version.filename = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "filename", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_FILENAME)
                    cfg.images.effect.hr_version.width = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "width", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_WIDTH)
                    cfg.images.effect.hr_version.height = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "height", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_HEIGHT)
                    cfg.images.effect.hr_version.frame_count = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "frame_count", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_FRAME_COUNT)
                    cfg.images.effect.hr_version.variation_count = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "variation_count", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_VARIATION_COUNT)
                    cfg.images.effect.hr_version.tint = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "tint", cfg.tint)
                    cfg.images.effect.hr_version.scale = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "scale", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_SCALE)
                    cfg.images.effect.hr_version.blend_mode = pe.lib.cfg.section.get_value(config.images.effect.hr_version, "blend_mode", pe.lib.DEFAULT_RESOURCE_EFFECT_HR_BLEND_MODE)
                end
            end
        end

        if (not pe.lib.ores[names.internal_name]) then
            pe.lib.ores[names.internal_name] = {}
        end

        pe.lib.ores[names.internal_name].config = table.deepcopy(cfg)
    end
end


function pe.lib.resource.create_icon(config)
    log("pe.lib.resource.create_icon")
    
    local tint = nil
    if (config.tint) then
        tint = config.tint
    end
    
    local icons =     {
                        { 
                            icon = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_ICON_1, 
                            tint = tint, 
                            icon_size = pe.lib.DEFAULT_RESOURCE_ICON_SIZE 
                        }
                    }

    if pe.lib.cfg.section.is_available(config.images, "sprite") then
        if config.images.sprite.sheet == 2 then
            icons.icon = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_ICON_2
        elseif config.images.sprite.sheet == 3 then
            icons.icon = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_ICON_3
        elseif config.images.sprite.sheet == 4 then
            icons.icon = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_ICON_4
        elseif config.images.sprite.sheet == 5 then
            icons.icon = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_ICON_LIQUID
        elseif config.images.sprite.sheet == 6 then
            icons.icon = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_ICON_5
        end
    end
    
  return icons
end


function pe.lib.resource.define_noise_layer(config)
    log("pe.lib.resource.define_noise_layer")
    
    local noise_layer = {
        type = pe.lib.PROTOTYPE_TYPE_NOISE_LAYER,
        name = config.names.noise_layer_name
    }
    
    pe.lib.ores[config.names.internal_name].noise_layer = table.deepcopy(noise_layer)
end


function pe.lib.resource.define_particle(config)
    log("pe.lib.resource.define_particle")
    
    if (pe.lib.cfg.section.is_available(config, "particle")) then
        local particle = 
        {
            type = pe.lib.PROTOTYPE_TYPE_PARTICLE,
            name = config.names.particle_name,
            flags = {
                        "not-on-map"
                    },
            life_time = config.particle.life_time,
            pictures =
            {
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_1,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 5,
                    height = 5,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_2,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 7,
                    height = 5,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_3,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 6,
                    height = 7,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_4,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 9,
                    height = 8,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_5,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 5,
                    height = 5,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_6,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 6,
                    height = 4,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_7,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 7,
                    height = 8,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_8,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    tint = config.particle.tint,
                    width = 6,
                    height = 5,
                    frame_count = 1
                }
            },
            shadows =
            {
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_1,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 5,
                    height = 5,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_2,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 7,
                    height = 5,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_3,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 6,
                    height = 7,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_4,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 9,
                    height = 8,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_5,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 5,
                    height = 5,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_6,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 6,
                    height = 4,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_7,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 7,
                    height = 8,
                    frame_count = 1
                },
                {
                    filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_PARTICLE_SHADOW_8,
                    priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                    width = 6,
                    height = 5,
                    frame_count = 1
                }
            }
        }

        pe.lib.ores[config.names.internal_name].particle = table.deepcopy(particle)
    end
end


function pe.lib.resource.get_icon_variation_single(variation_type, tint)
    log("pe.lib.resource.get_icon_variation_single")
    
    local piece = math.random(pe.lib.resource.icon_piece_counts[variation_type])

    local picture = {
        filename = pe.lib.path .. "/graphics/lib/icons/ore/" .. variation_type .. "/" .. piece .. ".png",
        width = pe.lib.resource.icon_piece_sizes[variation_type][piece].width,
        height = pe.lib.resource.icon_piece_sizes[variation_type][piece].height,
        tint = tint,
        scale = 0.5 * math.min(    pe.lib.DEFAULT_RESOURCE_ICON_SIZE / pe.lib.resource.icon_piece_sizes[variation_type][piece].width,
                                pe.lib.DEFAULT_RESOURCE_ICON_SIZE / pe.lib.resource.icon_piece_sizes[variation_type][piece].height,
                                1.0),
    }
    
    return picture
end


function pe.lib.resource.define_item(config)
    log("pe.lib.resource.define_item")
    
    if (pe.lib.cfg.section.is_available(config, "item")) then
        local icon
        local icons
        local icon_size
        local icon_mipmaps
        local item_pictures = {}
        
        if (pe.lib.cfg.section.is_available(config, "images")) then
            if (pe.lib.cfg.section.is_available(config.images, "single_icon")) then
                icon = config.images.single_icon.icon
                icon_size = config.images.single_icon.icon_size
                icon_mipmaps = config.images.single_icon.icon_mipmaps
                icons = nil
            elseif (pe.lib.cfg.section.is_available(config.images, "multiple_icons")) then
                icon = nil
                icon_size = nil
                icon_mipmaps = nil
                icons = config.images.multiple_icons.icons
            else
                icon = nil
                icon_size = nil
                icon_mipmaps = nil
                icons = pe.lib.resource.create_icon(config)
            end

            local num = 1

            if (config.images.create_variations) then
                num = 16
            end            

            if (pe.lib.cfg.section.is_available(config.images, "sprite")) then
                local variation_type = config.images.sprite.sheet

                if (variation_type) == 6 then
                    variation_type = 5
                end

                for i = num, 1, -1 do
                    local variation = pe.lib.resource.get_icon_variation_single(variation_type, config.item.tint)

                    table.insert(item_pictures, variation)
                end
            end
        end
        
        local item = 
        {
            type = pe.lib.PROTOTYPE_TYPE_ITEM,
            name = config.names.internal_name,
            icon = icon,
            icon_size = icon_size,
            icon_mipmaps = icon_mipmaps,
            icons = icons,
            subgroup = config.subgroup,
            order = config.item.order,
            stack_size = config.item.stack_size,
            pictures = item_pictures
        }
        
        pe.lib.ores[config.names.internal_name].item = table.deepcopy(item)
    end
end


function pe.lib.resource.define_peaks(config)
    log("pe.lib.resource.define_peaks")
    
    local peaks = {}
    
    for k,v in pairs(config.resource.autoplace.peaks) do
        local peak = 
        {
            influence = v.influence,
            min_influence = v.min_influence,
            max_influence = v.max_influence,
            richness_influence = v.richness_influence,
            noise_scale = v.noise_scale,
            noise_layer = v.noise_layer,
            noise_octaves_difference = v.noise_octaves_difference,
            noise_persistence = v.noise_persistence,
            starting_area_weight_optimal = v.starting_area_weight_optimal,
            starting_area_weight_range = v.starting_area_weight_range,
            starting_area_weight_max_range = v.starting_area_weight_max_range,
            starting_area_weight_top_property_limit = v.starting_area_weight_top_property_limit,
            elevation_optimal = v.elevation_optimal,
            elevation_range = v.elevation_range,
            elevation_max_range = v.elevation_max_range,
            elevation_top_property_limit = v.elevation_top_property_limit,
            water_optimal = v.water_optimal,
            water_range = v.water_range,
            water_max_range = v.water_max_range,
            water_top_property_limit = v.water_top_property_limit,
            temperature_optimal = v.temperature_optimal,
            temperature_range = v.temperature_range,
            temperature_max_range = v.temperature_max_range,
            temperature_top_property_limit = v.temperature_top_property_limit,
            aux_optimal = v.aux_optimal,
            aux_range = v.aux_range,
            aux_max_range = v.aux_max_range,
            aux_top_property_limit = v.aux_top_property_limit,
            tier_from_start_optimal = v.tier_from_start_optimal,
            tier_from_start_range = v.tier_from_start_range,
            tier_from_start_max_range = v.tier_from_start_max_range,
            tier_from_start_top_property_limit = v.tier_from_start_top_property_limit,
            distance_optimal = v.distance_optimal,
            distance_range = v.distance_range,
            distance_max_range = v.distance_max_range,
            distance_top_property_limit = v.distance_top_property_limit
        }
                            
        table.insert(peaks, peak)
    end
            
    return peaks
end


function pe.lib.resource.define_autoplace_control(config)
    log("pe.lib.resource.define_autoplace_control")
    
    if (pe.lib.cfg.section.is_available(config, "autoplace_control")) then
    
        local autoplace_control = {
            type = pe.lib.PROTOTYPE_TYPE_AUTOPLACE_CONTROL,
            category = "resource",
            name = config.names.autoplace_name,
            can_be_disabled = config.autoplace_control.can_be_disabled,
            richness = config.autoplace_control.richness,
            order = config.autoplace_control.order
        }
        
        pe.lib.ores[config.names.internal_name].autoplace_control = table.deepcopy(autoplace_control)
    end
end


function pe.lib.resource.define_hr_sprite(config)
    log("pe.lib.resource.define_hr_sprite")
    
    if (pe.lib.cfg.section.is_available(config.images, "sprite")) then
        local filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_HR_1

        if config.images.sprite.sheet == 2 then
            filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_HR_2
        elseif config.images.sprite.sheet == 3 then
            filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_HR_3
        elseif config.images.sprite.sheet == 4 then
            filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_HR_4
        elseif config.images.sprite.sheet == 6 then
            filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_HR_5
        end

        if (pe.lib.cfg.section.is_available(config.images.sprite, "hr_version")) then
            local hr_version = 
            {
                filename = filename,
                priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                width = config.images.sprite.hr_version.width,
                height = config.images.sprite.hr_version.height,
                frame_count = config.images.sprite.hr_version.frame_count,
                variation_count = config.images.sprite.hr_version.variation_count,
                tint = config.images.sprite.hr_version.tint,
                scale = config.images.sprite.hr_version.scale
            }
            return hr_version
        end
    end
end


function pe.lib.resource.define_animation_variations(config)
    log("pe.lib.resource.define_animation_variations")
    
    local sprite
    local filename
    local width
    local height
    local frame_count
    local variation_count
    local hr_version
    
    if (pe.lib.cfg.section.is_available(config.images, "sprite")) then
        sprite = config.images.sprite
        
        if (sprite.filename and #sprite.filename > 0) then
            filename = sprite.filename
            width = config.images.sprite.width
            height = config.images.sprite.height
            frame_count = config.images.sprite.frame_count
            variation_count = config.images.sprite.variation_count
        else
            filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_1
            width = 64
            height = 64
            frame_count = 8
            variation_count = 8
            hr_version = pe.lib.resource.define_hr_sprite(config)
            
            if (sprite.sheet == 2) then
                filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_2
                hr_version = pe.lib.resource.define_hr_sprite(config)
            elseif (sprite.sheet == 3) then
                filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_3
                hr_version = pe.lib.resource.define_hr_sprite(config)
            elseif (sprite.sheet == 4) then
                filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_4
                hr_version = pe.lib.resource.define_hr_sprite(config)
            elseif (sprite.sheet == 5) then
                filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_LIQUID
                width = 75
                height = 61
                frame_count = 4
                variation_count = 1
                hr_version = nil
            elseif (sprite.sheet == 6) then
                filename = pe.lib.path .. pe.lib.DEFAULT_RESOURCE_5
                hr_version = pe.lib.resource.define_hr_sprite(config)
            end
        end

        local stages =
        {
            sheet = {
                filename = filename,
                priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
                width = width,
                height = height,
                frame_count = frame_count,
                variation_count = variation_count,
                tint = config.images.sprite.tint,
                scale = config.images.sprite.scale,
                hr_version = hr_version
            }
        }
        
        return stages
    end
end


function pe.lib.resource.define_stages_hr_effect(config)
    log("pe.lib.resource.define_stages_hr_effect")
    
    if (pe.lib.cfg.section.is_available(config.images.effect, "hr_version")) then
        local effect = config.images.effect.hr_version

        local stages_effect =
        {
            filename = pe.lib.path .. effect.filename,
            priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
            width = effect.width,
            height = effect.height,
            frame_count = effect.frame_count,
            variation_count = effect.variation_count,
            tint = effect.tint,
            scale = effect.scale,
            blend_mode = effect.blend_mode,
            flags = { "light" }
        }

        return stages_effect
    end
end


function pe.lib.resource.define_stages_effect(config)
    log("pe.lib.resource.define_stages_effect")

    if (pe.lib.cfg.section.is_available(config.images, "effect")) then
        local effect = config.images.effect
        local hr_version

        hr_version = effect.hr_version or { sheet = 5, tint = effect.tint }
        pe.lib.resource.define_stages_hr_effect(config)

        local stages_effect =
        {
            filename = pe.lib.path .. effect.filename,
            priority = pe.lib.DEFAULT_RESOURCE_PRIORITY,
            width = effect.width,
            height = effect.height,
            frame_count = effect.frame_count,
            variation_count = effect.variation_count,
            tint = effect.tint,
            scale = effect.scale,
            blend_mode = effect.blend_mode,
            flags = { "light" },
            hr_version = hr_version
        }

        return stages_effect
    end
end


function pe.lib.resource.define_autoplace(config)
    local autoplace =     resource_autoplace.resource_autoplace_settings{
                             name = config.names.internal_name,
                             order = config.resource.autoplace.order,
                             base_density = config.resource.autoplace.base_density,
                             has_starting_area_placement = config.resource.autoplace.has_starting_area_placement,
                             regular_rq_factor_multiplier = config.resource.autoplace.regular_rq_factor_multiplier,
                             starting_rq_factor_multiplier = config.resource.autoplace.starting_rq_factor_multiplier,
                             patch_set_name = config.resource.autoplace.patch_set_name,    
                             autoplace_control_name = config.resource.autoplace.autoplace_control_name,
                             random_probability = config.resource.autoplace.random_probability,
                             base_spots_per_km2 = config.resource.autoplace.base_spots_per_km2,
                             seed1 = config.resource.autoplace.seed1    
                        }
    
    if (config.biome_restriction.biomes) then
        autoplace.tile_restriction = pe.lib.biome.get_tiles(config.biome_restriction.biomes)
    end
    
    if (config.resource.autoplace.peaks) then
        autoplace.peaks = pe.lib.resource.define_peaks(config)
    end
    
    return autoplace
end

function pe.lib.resource.define_resource(config)
    log("pe.lib.resource.define_resource")
    local minimum
    local normal
    local sprite
    local sheet
    local icon
    local infinite = false
    local effect
    local results = {}
    
    if (pe.lib.cfg.section.is_available(config, "resource")) then
        if (pe.lib.cfg.section.is_available(config, "mining")) then
            infinite = config.mining.infinite
            
            for k, v in pairs(config.mining.mining_results) do
                table.insert(results, { name = v.name, amount = v.amount, type = pe.lib.PROTOTYPE_TYPE_ITEM })
            end
        end
        local stage_counts = {}
        if (pe.lib.cfg.section.is_available(config, "images")) then
            if (pe.lib.cfg.section.is_available(config.images, "single_icon")) then
                icon = config.images.single_icon.icon
                icon_size = config.images.single_icon.icon_size
                icon_mipmaps = config.images.single_icon.icon_mipmaps
                icons = nil
            else
                icon = nil
                icon_size = nil
                icon_mipmaps = nil
                icons = pe.lib.resource.create_icon(config)
            end
            

            local multiplier = pe.lib.DEFAULT_RESOURCE_EFFECT_STAGE_MULT
            
            animation_variations = pe.lib.resource.define_animation_variations(config)
            
            if (animation_variations and config.images.sprite.sheet and animation_variations.sheet.variation_count) then
                stage = animation_variations.sheet.variation_count
                while(stage > 0) do
                    stage = stage - 1
                    table.insert(stage_counts, multiplier * (2 ^ stage))
                end
            end
                
            local effect_animation_period
            local effect_animation_period_deviation
            local effect_darkness_multiplier
            local min_effect_alpha
            local max_effect_alpha
            
            if (pe.lib.cfg.section.is_available(config.images, "effect")) then
                effect = config.images.effect or {}
                effect.tint = config.tint
                            
                effect_animation_period = config.images.effect.effect_animation_period
                effect_animation_period_deviation = config.images.effect.effect_animation_period_deviation
                effect_darkness_multiplier = config.images.effect.effect_darkness_multiplier
                min_effect_alpha = config.images.effect.min_effect_alpha
                max_effect_alpha = config.images.effect.max_effect_alpha
            end
        end
        
        local resource = 
        {
            type = pe.lib.PROTOTYPE_TYPE_RESOURCE,
            name = config.names.internal_name,
            flags = { "placeable-neutral" },
            category = config.resource.category,
            order = config.resource.order,
            minimum = config.resource.minimum,
            normal = config.resource.normal,
            resource_patch_search_radius = config.resource.resource_patch_search_radius,
            infinite = infinite,
            collision_box = config.resource.collision_box,
            selection_box = config.resource.selection_box,
            stages = animation_variations,
            stage_counts = stage_counts,
            map_color = config.map_color,
            minable =     {
                            mining_particle = config.names.particle_name,
                            mining_time = config.mining.mining_time,
                            required_fluid = config.mining.fluid.required_fluid,
                            fluid_amount = config.mining.fluid.fluid_amount,
                            results = table.deepcopy(results)
                        },
            map_grid = config.resource.map_grid or false,
            infinite_depletion_amount = config.mining.infinite_depletion_amount,
            icon = icon,
            icons = icons,
            icon_size = icon_size,
            icon_mipmaps = icon_mipmaps,
            stages_effect = pe.lib.resource.define_stages_effect(config),
            effect_animation_period = effect_animation_period,
            effect_animation_period_deviation = effect_animation_period_deviation,
            effect_darkness_multiplier = effect_darkness_multiplier,
            min_effect_alpha = min_effect_alpha,
            max_effect_alpha = max_effect_alpha,
            autoplace = pe.lib.resource.define_autoplace(config)
        }

        pe.lib.ores[config.names.internal_name].resource = table.deepcopy(resource)
    end
end


function pe.lib.resource.create_particle(ore)
    log("pe.lib.resource.create_particle")

    data:extend({ore.particle})
end


function pe.lib.resource.create_item(ore)
    log("pe.lib.resource.create_item")
    
    data:extend({ore.item})
end


function pe.lib.resource.create_autoplace_control(ore)
    log("pe.lib.resource.create_autoplace_control")
    
    data:extend({ore.autoplace_control})
    
    data.raw["map-gen-presets"].default["rich-resources"].basic_settings.autoplace_controls[ore.autoplace_control.name] = { richness = "very-good" }
    data.raw["map-gen-presets"].default["rail-world"].basic_settings.autoplace_controls[ore.autoplace_control.name] = { frequency = 0.33333333333, size = 3 }
    data.raw["map-gen-presets"].default["ribbon-world"].basic_settings.autoplace_controls[ore.autoplace_control.name] = { frequency = 3, size = 0.5, richness = 2 }
end


function pe.lib.resource.create_resource(ore)
    log("pe.lib.resource.create_resource")

    data:extend({ore.resource})
end


function pe.lib.resource.create_noise_layer(ore)
    log("pe.lib.resource.create_noise_layer")

    data:extend({ore.noise_layer})
end


function pe.lib.resource.define_prototypes()
    log("pe.lib.resource.define_prototypes")
    
    if (pe.lib.ores) then
        for k, o in pairs(pe.lib.ores) do
            pe.lib.resource.define_particle(o.config)
            pe.lib.resource.define_item(o.config)
            pe.lib.resource.define_autoplace_control(o.config)
            pe.lib.resource.define_noise_layer(o.config)
            pe.lib.resource.define_resource(o.config)
        end
    end
end


function pe.lib.resource.create_prototypes()
    log("pe.lib.resource.create_prototypes")
    
    if (pe.lib.ores) then
        for k, o in pairs(pe.lib.ores) do
            pe.lib.resource.create_particle(o)
            pe.lib.resource.create_item(o)
            pe.lib.resource.create_autoplace_control(o)
            pe.lib.resource.create_noise_layer(o)
            pe.lib.resource.create_resource(o)
        end
    end
end


function pe.lib.resource.create_ores()
    log("pe.lib.resource.create_ores")
    
    pe.lib.resource.define_prototypes()
    pe.lib.resource.create_prototypes()
end