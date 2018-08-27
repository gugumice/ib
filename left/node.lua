gl.setup(100, 800)
local font = resource.load_font('ARIALN.TTF')

function shadow_txt(x, y, str, size)
	x = x or 0
	y = y or 0
	str = str or ''
	size = size or 10
	font:write(x+2, y+2, str, size, 0,0,0,1)
	font:write(x, y, str, size, 1,1,1,1)
end

function read_to_lines(str)
	local splitted = {}
	for par in string.gmatch(str, "[^\n\r]+") do
		print(par)
		splitted[#splitted + 1] = par
	end
	return splitted
end

util.file_watch("work_hours.txt", function(content)
	lines = read_to_lines(content:sub(4))
end)


function node.render()
	gl.clear(0, .4, .4, 1) -- red
	--shadow_txt(7,60,'Kab. #1', 30)
	--shadow_txt(7,110,'laiks:', 40)
	y = 100
	
	for i, line in ipairs(lines) do
	local size = 15
		if i == 1 then
			size = 20
			shadow_txt(5,y,line, size)
		else
			font:write(2, y, line, size, 1, 1, 1, 1)
		end
		y = y + size+20
    end
	
	
	
end
