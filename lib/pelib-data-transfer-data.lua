if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.data then pe.lib.data = {} end
if not pe.lib.data.transferdata then pe.lib.data.transferdata = {} end

require("pelib-constants")
require("pelib-enc")

function pe.lib.data.transferdata.put(name, data)
    res =     {
        type = "item",
        name = pe.lib.XFR_PREFIX  ..  name,
        icon = "__core__/graphics/empty.png",
        icon_size = 1,
        stack_size = 1,
        flags = {"hidden", "hide-from-bonus-gui", "hide-from-fuel-tooltip"},
        localised_name = pe.lib.XFR_PREFIX  ..  name,
        localised_description = pe.lib.enc.encode(serpent.serialize(data, {})),
        order = "z"
    }
    
    return res
end