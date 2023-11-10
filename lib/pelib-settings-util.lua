if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.settings then pe.lib.settings = {} end
if not pe.lib.settings.util then pe.lib.settings.util = {} end


function pe.lib.settings.util.is_valid(name, setting_type, player_index)
    local res = false

    if (setting_type == pe.lib.defines.setting_type.startup and settings.startup[name] and settings.startup[name].value) then
        res = true
    elseif (setting_type == pe.lib.defines.setting_type.global and settings.global[name] and settings.global[name].value) then
        res = true
    elseif (setting_type == pe.lib.defines.setting_type.player and settings.get_player_settings(player_index)[name] and settings.get_player_settings(player_index)[name].value) then
        res = true
    end

    return res
end


function pe.lib.settings.util.read_value(name, setting_type, player_index)
    local res = nil
    
    if (pe.lib.settings.util.is_valid(name, setting_type, player_index)) then
        if (setting_type == pe.lib.defines.setting_type.startup) then
            res = settings.startup[name].value
        elseif (setting_type == pe.lib.defines.setting_type.global) then
            res = settings.global[name].value
        elseif (setting_type == pe.lib.defines.setting_type.player) then
            res = settings.get_player_settings(player_index)[name].value
        end
    end

    return res
end