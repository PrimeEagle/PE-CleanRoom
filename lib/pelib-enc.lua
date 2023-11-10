if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.enc then pe.lib.enc = {} end

local b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function pe.lib.enc.base64_encode(data)
    return ((data:gsub('.', function(x) 
        local r, b64 = '', x:byte()
        for i = 8, 1, -1 do
            r = r .. (b64 % 2 ^ i - b64 % 2 ^ (i - 1) > 0 and '1' or '0') 
        end
        return r
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then
            return ''
        end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) 
        end
        return b64:sub(c + 1, c + 1)
    end) .. ({ '', '==', '=' })[#data % 3 + 1])
end




function pe.lib.enc.base64_decode(data)
    data = string.gsub(data, '[^' .. b64 .. '=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then 
            return '' 
        end
        local r, f = '', (b64:find(x) - 1)
        for i=6, 1, -1 do 
            r = r .. (f % 2^i - f % 2^(i-1) > 0 and '1' or '0') 
        end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then 
            return '' 
        end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (8-i) or 0)
        end
        return string.char(c)
    end))
end




local function insert_node(nodes, node, value)
    table.insert(node, value)
    if 21 == #node then
        node = { "" }
        table.insert(nodes, node)
    end
    return node
end




function pe.lib.enc.encode(data)
    local node = { "" }
    local root = { node }
    local n = string.len(data)
    
    for i = 1, n, 200 do
        local value = string.sub(data, i, i + 199)
        node = insert_node(root, node, value)
    end
    
    while #root > 20 do
        local nodes,node = {}, {""}
        for _, value in ipairs(root) do
            node = insert_node(nodes, node, value)
        end
        root = nodes
    end
    
    if #root == 1 then root = root[1] else
        table.insert(root, 1, "")
    end
    
    return #root < 3 and (root[2] or "") or root
end




function pe.lib.enc.decode(data)
    if type(data) == "string" then
        return data
    end
    
    local str = {}
    
    for i = 2, #data do
        str[i - 1] = pe.lib.enc.decode(data[i])
    end
   
    return table.concat(str, "")
end