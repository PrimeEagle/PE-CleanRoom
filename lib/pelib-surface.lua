if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.surface then pe.lib.surface = {} end

function pe.lib.surface.delete_entities(surface)
    log("pe.lib.surface.delete_entities")
    for k, v in pairs(surface.find_entities()) do 
        v.destroy() 
    end 
end


 