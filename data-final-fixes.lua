if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

require("lib/pelib-data")
require("clean-room-constants")

pe.cr.namesToLoad = {}

for drk, drv in pairs(data.raw.item) do
	local add = false
	local sg = drv.subgroup
	local nm = drv.name
	
	if(sg) then
		if(pe.lib.util.has_value(pe.allowedSubgroups, sg) and not pe.lib.util.has_value(pe.excludedItems, nm)) then
			add = true
		end
	
		if(pe.lib.util.has_value(pe.additionalAllowedItems, nm)) then
			add = true
		end
	end
	
	if(add) then
		pe.cr.namesToLoad[nm] = nm
	end
end


data:extend 
{
	pe.lib.data.transferdata.put("allowedNames", pe.cr.namesToLoad)
}