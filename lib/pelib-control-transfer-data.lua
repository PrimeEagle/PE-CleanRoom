if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.control then pe.lib.control = {} end
if not pe.lib.control.transferdata then pe.lib.control.transferdata = {} end

require("pelib-constants")
require("pelib-enc")

function pe.lib.control.transferdata.get(name, prototypeList)
    prototypeList = prototypeList or game.item_prototypes
    
    log("get name = " .. pe.lib.XFR_PREFIX  ..  name)
    log("get prototypeList = " .. serpent.dump(prototypeList))
    
    local idxName = pe.lib.XFR_PREFIX  ..  name
    local prototype = prototypeList[idxName]
    
    
    local res

    if (prototype) then
        res = loadstring("return " .. pe.lib.enc.decode(prototype.localised_description))()
    end
    
    return res
end