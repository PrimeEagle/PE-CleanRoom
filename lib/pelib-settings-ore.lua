if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.settings then pe.lib.settings = {} end
if not pe.lib.settings.ore then pe.lib.settings.ore = {} end

		
function pe.lib.settings.ore.add_ore_setting(setting_type, ore, default_value)
	if(setting_type == pe.lib.defines.ore_setting_type.enable) then
		data:extend{
			{
				type = "bool-setting",
				name = pe.lib.NAME_PREFIX..ore..pe.lib.RESOURCE_SUFFIX..pe.lib.RESOURCE_SETTING_ENABLED_SUFFIX,
				setting_type = "startup",
				default_value = default_value or true
			}
		}
	elseif(setting_type == pe.lib.defines.ore_setting_type.starting_area) then
		data:extend{
			{
				type = "bool-setting",
				name = pe.lib.NAME_PREFIX..ore..pe.lib.RESOURCE_SUFFIX..pe.lib.RESOURCE_SETTING_STARTING_AREA_SUFFIX,
				setting_type = "startup",
				default_value = default_value or false
			}
		}
	elseif(setting_type == pe.lib.defines.ore_setting_type.infinite) then
		data:extend{
			{
				type = "bool-setting",
				name = pe.lib.NAME_PREFIX..ore..pe.lib.RESOURCE_SUFFIX..pe.lib.RESOURCE_SETTING_INFINITE_SUFFIX,
				setting_type = "startup",
				default_value = default_value or false
			}
		}
	end
end