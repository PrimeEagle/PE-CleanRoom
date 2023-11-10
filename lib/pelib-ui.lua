if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.ui then pe.lib.ui = {} end

function pe.lib.ui.flying_text(surface, position, text) 
    surface.create_entity{ name = "flying-text", position = position, text = text, speed = 3.0 }
end


