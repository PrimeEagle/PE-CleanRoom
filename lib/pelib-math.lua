if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.math then pe.lib.math = {} end




function pe.lib.math.vector_length(v) 
    return math.sqrt(math.abs(v.x) ^ 2 + math.abs(v.y) ^ 2)
end



function pe.lib.math.snap_angle(position, ang)
    local vx = pe.lib.math.vector_length(position) 
    local rad = math.rad(math.deg(math.atan2(position.x, position.y)) + ang)
   
    return { x = vx * (math.sin(rad)), y = vx * (math.cos(rad)) }
end




function pe.lib.math.snap_orientation(position, angle)
    return pe.lib.math.snap_angle(position, angle * 360)
end