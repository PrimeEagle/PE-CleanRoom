if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.util then pe.lib.util = {} end


function pe.lib.util.is_table_valid(tab)
    local res = false
    
    if (tab and next(tab)) then
        res = true
    end

    return res
end


function pe.lib.util.is_table_array(tab)
  local i = 0
  
  for _ in pairs(tab) do
    i = i + 1
    
    if (tab[i]) == nil then
        return false 
    end
  end
  
  return true
end


function pe.lib.util.has_value (tab, val)
    local res = false
    
    for index, value in ipairs(tab) do
        if value == val then
            res = true
            break
        end
    end

    return res
end