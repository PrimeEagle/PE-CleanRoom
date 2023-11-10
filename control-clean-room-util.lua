if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

function pe.cr.is_valid_entity(ent)
	return pe.cr.allowedNames[ent.name] ~= nil
end