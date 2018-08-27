gl.setup(1000, 100)
local fnt = resource.load_font('ARIALN.TTF')
local lines_1=""
local lines_2=""

function asc(str)
	local rv = {}
	for i = 1, string.len(str) do
		c= string.sub(str, i, i)
		print(c,string.byte(c))
	end
end

function read_to_lines(str)
	local splitted = {}
	for par in string.gmatch(str, "[^\n\r]+") do
		--asc(par)
		splitted[#splitted + 1] = par:gsub("^%s*(.-)%s*$", "%1")
	end
	return splitted
end

util.file_watch("news_1.txt", function(content)
	--lines_1 = read_to_lines(content:sub(4))
	lines_1 = read_to_lines(content)
	end)

util.file_watch("news_2.txt", function(content)
	lines_2 = read_to_lines(content:sub(4))
	end)

function feeder1()
	return lines_1
end
function feeder2()
	return lines_2
end


text_1 = util.running_text{
    font = fnt;
	size = 40;
	speed = 80;
	color = {1,1,1,1};
	generator = util.generator(feeder1)
}

text_2 = util.running_text{
    font = fnt;
	size = 30;
	speed = 40;
	color = {1,1,1,1};
	generator = util.generator(feeder2)
}

function node.render()
    gl.clear(0, .5, .5, 1) -- blue
	text_1:draw(5)
	text_2:draw(60)
end
