if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.cfg then pe.lib.cfg = {} end
if not pe.lib.cfg.section then pe.lib.cfg.section = {} end


function pe.lib.cfg.section.get_type(config, item)
    log("pe.lib.cfg.get_type")
    local result = nil

    if (config and config[item]) then
        if (type(config[item]) == "table") then
            if (config[item].enabled) then
                result = pe.lib.defines.section_type.group
            elseif (config[item].r and config[item].g and config[item].b and config[item].a) then
                result = pe.lib.defines.section_type.color
            elseif (config[item].setting_name) then
                result = pe.lib.defines.section_type.setting
            elseif (config[item].ore and config[item].ore_name and config[item].internal_name and config[item].particle_name and
                   config[item].autoplace_name and config[item].setting_name_enabled and config[item].setting_name_starting_area and
                   config[item].setting_name_infinite) then
                        result = pe.lib.defines.section_type.names
            elseif (pe.lib.util.is_table_array(config[item])) then
                result = pe.lib.defines.section_type.array
            elseif (next(config[item]) == nil) then
                result = pe.lib.defines.section_type.array
            end
        else
            result = pe.lib.defines.section_type.single
        end
    end
    
    return result
end


function pe.lib.cfg.section.is_single(config, item)
    log("pe.lib.cfg.is_single")
    local result = false
    
    if (pe.lib.cfg.section.get_type(config, item) == pe.lib.defines.section_type.single) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.is_group(config, item)
    log("pe.lib.cfg.is_group")
    local result = false
    
    if (pe.lib.cfg.section.get_type(config, item) == pe.lib.defines.section_type.group) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.is_color(config, item)
    log("pe.lib.cfg.is_color")
    local result = false
    
    if (pe.lib.cfg.section.get_type(config, item) == pe.lib.defines.section_type.color) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.is_setting(config, item)
    log("pe.lib.cfg.is_setting")
    local result = false
    
    if (pe.lib.cfg.section.get_type(config, item) == pe.lib.defines.section_type.setting) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.is_names(config, item)
    log("pe.lib.cfg.is_names")
    local result = false
    
    if (pe.lib.cfg.section.get_type(config, item) == pe.lib.defines.section_type.names) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.is_array(config, item)
    log("pe.lib.cfg.is_array")
    local result = false
    
    if (pe.lib.cfg.section.get_type(config, item) == pe.lib.defines.section_type.array) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.is_available(config, name)
    log("pe.lib.cfg.section.is_available")

    local result = false
    local t = pe.lib.cfg.section.get_type(config, name)
    
    if (t == pe.lib.defines.section_type.single) then
        result = (config[name] ~= nil)
    elseif (t == pe.lib.defines.section_type.group) then
        result = config[name].enabled
    elseif (t == pe.lib.defines.section_type.color) then
        result = true
    elseif (t == pe.lib.defines.section_type.setting) then
        if (pe.lib.settings.util.read_value(config[name].setting_name, pe.lib.defines.setting_type.startup)) then
            result = true
        end
    elseif (t == pe.lib.defines.section_type.names) then
        result = true
    elseif (t == pe.lib.defines.section_type.array) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.section.get_value(config, name, default)
    log("pe.lib.cfg.section.get_value")
    local result = nil

    if (pe.lib.cfg.section.is_available(config, name)) then
        if (type(config[name]) == "table") then
            result = table.deepcopy(config[name])
            if (next(result) == nil) then
                result = default
            end
        else
            if (config[name] and type(config[name]) == "string" and #config[name] == 0) then
                result = default
            else
                result = config[name]
            end
        end
    else
        result = default
    end

    return result
end


function pe.lib.cfg.section.adjust_tint(base_tint, adj_tint)
    log("pe.lib.cfg.section.adjust_tint")
    local color = base_tint
    
    if (base_tint and base_tint.r and base_tint.g and base_tint.b and base_tint.a and
       adj_tint and adj_tint.r and adj_tint.g and adj_tint.b and adj_tint.a) then
            color.r = color.r + adj_tint.r
            color.g = color.g + adj_tint.g
            color.b = color.b + adj_tint.b
            color.a = color.a + adj_tint.a
    end

    return color
end


-----------------------------------------------------------------------------------------


function pe.lib.cfg.is_available(config)
    log("pe.lib.cfg.is_available")
    local result = false
    
    if (config and pe.lib.cfg.section.is_available(config, "names") and pe.lib.cfg.section.is_available(config, "enabled") and pe.lib.cfg.section.get_value(config, "enabled")) then
        result = true
    end
    
    return result
end


function pe.lib.cfg.is_valid(config)
    log("pe.lib.cfg.is_valid")
    local result = false

    result = pe.lib.cfg.is_available(config)

    if (result) then
        result = pe.lib.cfg.section.is_available(config, "enabled")
    end

    if (result) then
        result = pe.lib.cfg.section.is_available(config, "map_color")
    end

    if (result) then
        result = pe.lib.cfg.section.is_available(config, "subgroup")
    end

    if (result) then
        if (pe.lib.cfg.section.is_available(config, "images")) then
            local si = pe.lib.cfg.section.is_available(config.images, "single_icon")

            si = si and config.images.single_icon.icon and #config.images.single_icon.icon > 0

            local mi = pe.lib.cfg.section.is_available(config.images, "multiple_icons")

            mi = mi and config.images.multiple_icons.icon and #config.images.multiple_icons.icon > 0
            result = si or mi
        end
    end

    return result
end