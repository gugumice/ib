local w=NATIVE_WIDTH
local h=NATIVE_HEIGHT
mainwin_w = w - w * 0.20 --  20% for sidebar
mainwin_h = h - h * 0.10 --  20% for bottom bar
print(mainwin_w, mainwin_h)
gl.setup(w, h)

local INTERVAL = 20
-- enough time to load next image
local SWITCH_DELAY = 1
-- transition time in seconds.
-- set it to 0 switching instantaneously
local SWITCH_TIME = 2.0
--BACKGROUND = resource.load_image('background.jpg')
local pict = nil
local video = nil

assert(SWITCH_TIME + SWITCH_DELAY < INTERVAL,
    "INTERVAL must be longer than SWITCH_DELAY + SWITCHTIME")

util.file_watch("playlist.txt", function(content) 
	playlist = {}
	for filename in string.gmatch(content, "[^\r\n]+") do
		playlist[#playlist+1] = filename
	end
	current_file_idx = 0
	print("Playlist")
	pp(playlist)
end)

function get_next()
		show_start = sys.now()
		current_file_idx = current_file_idx + 1
		if current_file_idx > #playlist then
			current_file_idx = 1
		end
		next_file = playlist[current_file_idx]
		--print("Showing ..." .. next_file)
		return next_file
end
function load_next(file)
	if string.upper(next_file):match(".*JPG") then
		pict = resource.load_image(next_file)
		if video then
			video:dispose()
			video=nil
		end
	elseif string.upper(next_file):match(".*MP4") then
		video = util.videoplayer(next_file)
		if pict then
			pict:dispose()
			pict = nil
		end
	end
end

--util.set_interval(INTERVAL, show_next)
load_next(get_next())

function node.render()
	gl.clear(0, .2, 0, 1) -- green
	local delta = sys.now() - show_start - SWITCH_TIME
	--print(delta .. " > " .. 1+delta/SWITCH_TIME)
	--BACKGROUND:draw(5, 5, mainwin_w-7, mainwin_h-7)
	if pict then
		if delta>INTERVAL then
			load_next(get_next())
		end
		if delta > 0 then 
			util.draw_correct(pict,10, 10, mainwin_w-7, mainwin_h-7)
		elseif delta <0 then
			local progress = delta / SWITCH_TIME
			util.draw_correct(pict,10, 10, mainwin_w-7, mainwin_h-7, 1+progress)
		end
	elseif video then
		if not video:next() then
			video:dispose()
			video=nil
			load_next(get_next())
		else
			util.draw_correct(video,10, 10, mainwin_w-7, mainwin_h-7)
		end
	end

	
	-- render to image object and draw
	local left = resource.render_child("left")
	left:draw(mainwin_w, 0, w, mainwin_h)
	left:dispose()

    local bottom = resource.render_child("bottom")
	bottom:draw(0, mainwin_h, w, h)
	bottom:dispose()
	-- render an draw without creating an intermediate value
	-- resource.render_child("blue"):draw(0, sh-(sh*bottombar), sw, sh)
end
