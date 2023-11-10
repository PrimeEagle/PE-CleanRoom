if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

script.on_init(pe.cr.init)
script.on_configuration_changed(pe.cr.configuration_changed)
script.on_load(pe.cr.load)
script.on_event(defines.events.on_gui_click, pe.cr.gui_click)

script.on_event(defines.events.on_gui_opened, pe.cr.gui_opened)
script.on_event(defines.events.on_pre_build, pe.cr.pre_build)
script.on_event( {  defines.events.on_built_entity, 
					defines.events.script_raised_built, 
					defines.events.on_robot_built_entity, 
					defines.events.script_raised_revive }, pe.cr.create)
script.on_event(defines.events.on_entity_cloned, pe.cr.cloned)
script.on_event({defines.events.on_player_mined_entity, on_robot_mined_entity},
	function(e)
		pe.cr.mined(e)
		pe.cr.destroyed(e)
	end)
script.on_event({defines.events.script_raised_destroy, defines.events.on_entity_died}, pe.cr.destroyed)
script.on_event(defines.events.on_player_rotated_entity, pe.cr.rotated)
script.on_event(defines.events.on_entity_settings_pasted, pe.cr.settings_pasted)
script.on_event(defines.events.on_player_setup_blueprint, pe.cr.setup_blueprint)