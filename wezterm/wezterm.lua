local os = require("os")
local math = require("math")
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

-- wezterm.on("gui-startup", function()
--      local tab, pane, window = mux.spawn_window(cmd or {})
--      window:gui_window():toggle_fullscreen()
-- end)

local colors = {
	oniWhite = {
		rgb = "#ECE7DA",
		desc = "Terminal foreground",
	},
	fujiWhite = {
		rgb = "#DCD7BA",
		desc = "Default foreground",
	},
	oldWhite = {
		rgb = "#C8C093",
		desc = "Dark foreground (statuslines)",
	},
	inkBlack = {
		rgb = "#090618",
		desc = "black",
	},
	sumiInk0 = {
		rgb = "#16161D",
		desc = "Dark background (statuslines and floating windows)",
	},
	sumiInk1 = {
		rgb = "#1F1F28",
		desc = "Default background",
	},
	sumiInk2 = {
		rgb = "#2A2A37",
		desc = "Lighter background (colorcolumn, folds)",
	},
	sumiInk3 = {
		rgb = "#363646",
		desc = "Lighter background (cursorline)",
	},
	sumiInk4 = {
		rgb = "#54546D",
		desc = "Darker foreground (line numbers, fold column, non-text chars), float borders",
	},
	waveBlue1 = {
		rgb = "#223249",
		desc = "Popup background, visual selection background",
	},
	waveBlue2 = {
		rgb = "#2D4F67",
		desc = "Popup selection background, search background",
	},
	winterGreen = {
		rgb = "#2B3328",
		desc = "Diff Add (background)",
	},
	winterYellow = {
		rgb = "#49443C",
		desc = "Diff Change (background)",
	},
	winterRed = {
		rgb = "#43242B",
		desc = "Diff Deleted (background)",
	},
	winterBlue = {
		rgb = "#252535",
		desc = "Diff Line (background)",
	},
	autumnGreen = {
		rgb = "#76946A",
		desc = "Git Add",
	},
	autumnRed = {
		rgb = "#C34043",
		desc = "Git Delete",
	},
	autumnYellow = {
		rgb = "#DCA561",
		desc = "Git Change",
	},
	samuraiRed = {
		rgb = "#E82424",
		desc = "Diagnostic Error",
	},
	roninYellow = {
		rgb = "#FF9E3B",
		desc = "Diagnostic Warning",
	},
	waveAqua1 = {
		rgb = "#6A9589",
		desc = "Diagnostic Info",
	},
	dragonBlue = {
		rgb = "#658594",
		desc = "Diagnostic Hint",
	},
	fujiGray = {
		rgb = "#727169",
		desc = "Comments",
	},
	springViolet1 = {
		rgb = "#938AA9",
		desc = "Light foreground",
	},
	oniViolet = {
		rgb = "#957FB8",
		desc = "Statements and Keywords",
	},
	crystalBlue = {
		rgb = "#7E9CD8",
		desc = "Functions and Titles",
	},
	springViolet2 = {
		rgb = "#9CABCA",
		desc = "Brackets and punctuation",
	},
	springBlue = {
		rgb = "#7FB4CA",
		desc = "Specials and builtin functions",
	},
	lightBlue = {
		rgb = "#A3D4D5",
		desc = "Not used",
	},
	waveAqua2 = {
		rgb = "#7AA89F",
		desc = "Types",
	},
	springGreen = {
		rgb = "#98BB6C",
		desc = "Strings",
	},
	boatYellow1 = {
		rgb = "#938056",
		desc = "Not used",
	},
	boatYellow2 = {
		rgb = "#C0A36E",
		desc = "Operators, RegEx",
	},
	carpYellow = {
		rgb = "#E6C384",
		desc = "Identifiers",
	},
	sakuraPink = {
		rgb = "#D27E99",
		desc = "Numbers",
	},
	waveRed = {
		rgb = "#E46876",
		desc = "Standout specials 1 (builtin variables)",
	},
	peachRed = {
		rgb = "#FF5D62",
		desc = "Standout specials 2 (exception handling, return)",
	},
	surimiOrange = {
		rgb = "#FFA066",
		desc = "Constants, imports, booleans",
	},
	katanaGray = {
		rgb = "#717C7C",
		desc = "Deprecated",
	},
}

local checkEnv = function(e, t)
	local envvar = os.getenv(e)
	if envvar == nil then
		envvar = "NOT_FOUND"
	end
	-- wezterm.log_info(envvar)
	return envvar == t
end

local isTmux = function()
	local tmux = checkEnv("TERM_PROGRAM", "tmux")
	local WezTerm = checkEnv("TERM_PROGRAM", "WezTerm")
	if tmux or WezTerm then
		return true
	else
		return false
	end
end

local color = function(c)
	return string.lower(colors[c].rgb)
end

local icolor = function(i)
	local index = 0
	for k, _ in pairs(colors) do
		if index == i then
			return color(k)
		end
		index = index + 1
	end
end

local colorschemes = {
	kanagawa = {
		foreground = color("oniWhite"),
		background = color("sumiInk1"),
		cursor_bg = color("oldWhite"),
		cursor_fg = color("oldWhite"),
		cursor_border = color("oldWhite"),
		selection_fg = color("oldWhite"),
		selection_bg = color("waveBlue2"),
		scrollbar_thumb = color("sumiInk0"),
		split = color("sumiInk0"),

		ansi = {
			color("inkBlack"),
			color("autumnRed"),
			color("autumnGreen"),
			color("boatYellow2"),
			color("crystalBlue"),
			color("springViolet1"),
			color("waveAqua1"),
			color("oldWhite"),
		},

		brights = {
			color("fujiGray"),
			color("samuraiRed"),
			color("springGreen"),
			color("carpYellow"),
			color("springBlue"),
			color("oniViolet"),
			color("waveAqua2"),
			color("fujiWhite"),
		},

		indexed = {
			[16] = color("fujiWhite"), --     #DCD7BA
			[17] = color("oldWhite"), --      #C8C093
			[18] = color("inkBlack"), --      #090618
			[19] = color("sumiInk0"), --      #16161D
			[20] = color("sumiInk1"), --      #1F1F28
			[21] = color("sumiInk2"), --      #2A2A37
			[22] = color("sumiInk3"), --      #363646
			[23] = color("sumiInk4"), --      #54546D
			[24] = color("waveBlue1"), --     #223249
			[25] = color("waveBlue2"), --     #2D4F67
			[26] = color("winterGreen"), --   #2B3328
			[27] = color("winterYellow"), --  #49443C
			[28] = color("winterRed"), --     #43242B
			[29] = color("winterBlue"), --    #252535
			[30] = color("autumnGreen"), --   #76946A
			[31] = color("autumnRed"), --     #C34043
			[32] = color("autumnYellow"), --  #DCA561
			[33] = color("samuraiRed"), --    #E82424
			[34] = color("roninYellow"), --   #FF9E3B
			[35] = color("waveAqua1"), --     #6A9589
			[36] = color("dragonBlue"), --    #658594
			[37] = color("fujiGray"), --      #727169
			[38] = color("springViolet1"), -- #938AA9
			[39] = color("oniViolet"), --     #957FB8
			[40] = color("crystalBlue"), --   #7E9CD8
			[41] = color("springViolet2"), -- #9CABCA
			[42] = color("springBlue"), --    #7FB4CA
			[43] = color("lightBlue"), --     #A3D4D5
			[44] = color("waveAqua2"), --     #7AA89F
			[45] = color("springGreen"), --   #98BB6C
			[46] = color("boatYellow1"), --   #938056
			[47] = color("boatYellow2"), --   #C0A36E
			[48] = color("carpYellow"), --    #C0A36E
			[49] = color("sakuraPink"), --    #D27E99
			[50] = color("waveRed"), --       #E46876
			[51] = color("peachRed"), --      #FF5D62
			[52] = color("surimiOrange"), --  #FFA066
			[53] = color("katanaGray"), --    #717C7C
			[54] = color("oniWhite"), --      #E7E7DA
		},
	},
}

local UpdateKeyTable = function()
	if isTmux() then
		-- wezterm.log_info("activating tmux keytable")
		return act.ActivateKeyTable({
			name = "tmux",
			one_shot = false,
			replace_current = true,
		})
	else
		-- wezterm.log_info("activating wezterm keytable")
		return act.ActivateKeyTable({
			name = "wezterm",
			one_shot = false,
			replace_current = true,
		})
	end
end

function DeepCopy(obj)
	local copyTable = {}

	local function copy(o)
		if type(o) ~= "table" then
			return o
		end
		local newTable = {}
		copyTable[o] = newTable
		for k, v in pairs(o) do
			newTable[copy(k)] = copy(v)
		end
		return setmetatable(newTable, getmetatable(o))
	end

	copyTable = copy(obj)

	return copyTable
end

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

local tmuxActions = {
	cmd_d = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "|" }) }),
	cmd_shift_d = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "-" }) }),
	cmd_t = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "c" }) }),
	cmd_w = act.SendKey({ key = "d", mods = "CTRL" }),
	cmd_shift_Enter = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "m" }) }),
	cmd_shift_LeftBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "p" }) }),
	cmd_shift_RightBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "n" }) }),
	cmd_ctrl_LeftBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "p" }) }),
	cmd_ctrl_RightBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "n" }) }),
	-- toggle command broadcast
	cmd_opt_i = act.Multiple({
		act.SendKey({ key = "a", mods = "CTRL" }),
		act.SendKey({ key = "x", mods = "CTRL" }),
	}),
	cmd_shift_i = act.Multiple({
		act.SendKey({ key = "a", mods = "CTRL" }),
		act.SendKey({ key = "x", mods = "OPT" }),
	}),
}

-- dictionary contains all possible key mappings
local keymap = {
	cmd_d = {
		key = "d",
		mods = "CMD",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	cmd_shift_d = {
		key = "d",
		mods = "CMD|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	cmd_k = {
		key = "k",
		mods = "CMD",
		action = act.ClearScrollback("ScrollbackOnly"),
	},
	cmd_RightArrow = {
		key = "RightArrow",
		mods = "CMD",
		action = act.ActivatePaneDirection("Right"),
	},
	cmd_LeftArrow = {
		key = "LeftArrow",
		mods = "CMD",
		action = act.ActivatePaneDirection("Left"),
	},
	cmd_UpArrow = {
		key = "UpArrow",
		mods = "CMD",
		action = act.ActivatePaneDirection("Up"),
	},
	cmd_DownArrow = {
		key = "DownArrow",
		mods = "CMD",
		action = act.ActivatePaneDirection("Down"),
	},
	cmd_RightBracket = {
		key = "]",
		mods = "CMD",
		action = act.ActivatePaneDirection("Next"),
	},
	cmd_LeftBracket = {
		key = "[",
		mods = "CMD",
		action = act.ActivatePaneDirection("Next"),
	},
	cmd_ctrl_LeftBracket = {
		key = "[",
		mods = "CMD|CTRL",
		action = act.ActivateTabRelative(-1),
	},
	cmd_ctrl_RightBracket = {
		key = "]",
		mods = "CMD|CTRL",
		action = act.ActivateTabRelative(1),
	},
	cmd_shift_LeftBracket = {
		key = "{",
		mods = "CMD",
		action = act.ActivateTabRelative(-1),
	},
	cmd_shift_RightBracket = {
		key = "}",
		mods = "CMD",
		action = act.ActivateTabRelative(1),
	},
	cmd_w = {
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	cmd_shift_Enter = {
		key = "Enter",
		mods = "CMD|SHIFT",
		action = act.TogglePaneZoomState,
	},
	cmd_ctrl_f = {
		key = "f",
		mods = "CMD|CTRL",
		action = act.ToggleFullScreen,
	},
	cmd_shift_k = {
		key = "k",
		mods = "CMD|SHIFT",
		action = UpdateKeyTable(),
	},
	cmd_t = {
		key = "t",
		mods = "CMD",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	cmd_shift_t = {
		key = "t",
		mods = "CMD|SHIFT",
		action = act.ActivateKeyTable({
			name = "tmux",
			one_shot = false,
			replace_current = true,
		}),
	},
	cmd_shift_w = {
		key = "w",
		mods = "CMD|SHIFT",
		action = act.ActivateKeyTable({
			name = "wezterm",
			one_shot = false,
			replace_current = true,
		}),
	},
	cmd_opt_i = {
		key = "i",
		mods = "CMD|OPT",
		action = UpdateKeyTable(),
	},
	cmd_shift_i = {
		key = "i",
		mods = "CMD|SHIFT",
		action = UpdateKeyTable(),
	},
}

local actionmap = {
	tmux = tmuxActions,
}

local function getKeys(name)
	local actions = actionmap[name]
	local newKeys = {}
	local mapCopy = DeepCopy(keymap)
	for k, v in pairs(mapCopy) do
		local newKey = v
		if actions ~= nil and actions[k] ~= nil then
			newKey.action = actions[k]
		end
		table.insert(newKeys, newKey)
	end
	return newKeys
end

wezterm.on("window-focus-changed", function(window, pane)
	if isTmux() then
		UpdateKeyTable()
	end
end)

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

local function background(image)
	local image_path = nil
	if image ~= nil then
		image_path = string.format("%s/%s", wezterm.config_dir, image)
	end
	return image_path
end

function Time()
	-- local posix = require("posix")
	-- local timersub, gettimeofday = posix.timersub, posix.gettimeofday
	-- local began = gettimeofday()
	-- local elapsed = timersub(gettimeofday(), began)
	-- return elapsed.sec * 1000 + elapsed.usec / 1000
	return os.time()
end

function RandomNumber(n)
	-- print("Milliseconds: " .. socket.gettime()*1000)
	math.randomseed(Time())
	return math.random(0, n)
end

local fonts = {
	-- -- NOT PREFERRED
	-- "BigBlue_Terminal",
	-- "Literation",
	-- "MesloLG",
	-- "Symbols",
	-- "Arimo",
	-- "Tinos"
	-- "Mplus",
	-- "HeavyData",
	-- "OpenDyslexic",
	-- "Overpass",
	-- "Ubuntu",
	-- "ProggyCleanTT",
	-- "GohuFont",
	--
	-- -- REQUIRES ALT TMUX
	-- "DaddyTimeMono",
	-- "Mononoki",
	-- "DroidSansMono",
	-- "Monofur",
	-- "Inconsolata",
	-- "Hurmit",
	-- "Iosevka",
	-- "SpaceMono",
	-- "Agave",
	-- "Monoid",
	-- "DejaVuSansMono",
	-- "Anonymice",
	-- "3270",
	-- "BlexMono",
	-- "FiraCode",
	-- "BitstreamVeraSansMono",
	-- "ProFont",
	-- "InconsolataGo",
	-- "FuraMono",
	-- "IMWriting",
	-- "UbuntuMono",
	-- "Cousine",
	-- "VictorMono",
	-- "SauceCodePro",
	-- "CaskaydiaCove",
	-- "RobotoMono",
	-- "InconsolataLGC",
	-- "Lilex",
	-- "CodeNewRoman",
	-- "Hasklug",
	-- "ShureTechMono",
	-- "AurulentSansMono",
	-- "Lekton",
	-- "FantasqueSansMono",
	-- "NotoMono",
	-- "TerminessTTF",
	--
	-- -- PREFERRED
	"Hack",
	"GoMono",
	"JetBrainsMono",
	"SauceCodePro",
}

function RandomFont()
	return fonts[RandomNumber(#fonts)]
end

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--      if tab.is_active then
--              return {
--                      { Background = { Color = "blue" } },
--                      { Text = " " .. RandomFont() .. "   " },
--              }
--      end
--      return tab.active_pane.title
-- end)

local foreground_hsb_0 = {
	brightness = 0.92,
	hue = 1.000,
	saturation = 1.000,
}

local background_hsb_0 = {
	brightness = 0.020,
	-- hue = 1.000,
 	hue = 1.00,
	saturation = 0.33,
}

local background_hsb_1 = {
	brightness = 0.25,
	hue = 1.000,
	saturation = 1.000,
}

-- local background_hsb_0 = {
-- 	brightness = 0.037,
-- 	hue = -09.133,
-- 	saturation = 0.433,
-- }

-- local background_hsb_1 = {
--     brightness = 0.03,
--     hue = 1.15,
--     saturation = 0.35,
-- }

local background_image = wezterm.config_dir .. "/background.png"
local dark_tile = wezterm.config_dir .. "/dark_tile.png"
local purple_tile = wezterm.config_dir .. "/purple_tile.png"

local config = {
	initial_cols = 112,
	initial_rows = 34,
	enable_tab_bar = true,
	-- font = wezterm.font(RandomFont() .. " Nerd Font", { weight = "Regular" }),
    --[[ font = wezterm.font_with_fallback({
        {family="SauceCodePro Nerd Font", weight="DemiBold"},
        "Hack",
    }), ]]
    font = wezterm.font_with_fallback({
        {family="Hack Nerd Font", weight="Regular"},
        {family="SauceCodePro Nerd Font", weight="DemiBold"},
        "Hack Nerd Font",
        "SauceCodePro Nerd Font",
        "Hack",
        "SauceCodePro",
    }),
	font_size = 16,
	window_padding = { left = 4, right = 4, top = 4, bottom = 0 },
	use_fancy_tab_bar = true,
	colors = colorschemes.kanagawa,
	scrollback_lines = 5000,
	enable_scroll_bar = true,
	min_scroll_bar_height = "2cell",
	background = {
		{
			source = {
				File = dark_tile,
			},
			repeat_x = "Repeat",
			repeat_y = "Repeat",
            opacity = 0.50,
			hsb = foreground_hsb_0,
		},
		{
			source = {
				File = background_image,
			},
			width = "58cell",
			height = "29cell",
			vertical_offset = "-1cell",
			repeat_x = "Repeat",
			repeat_y = "Repeat",
            opacity = 0.75,
			hsb = background_hsb_0,
		},
		{
			source = {
				File = purple_tile,
			},
			repeat_x = "Repeat",
			repeat_y = "Repeat",
            opacity = 0.38,
			hsb = background_hsb_1,
		},
		{
			source = {
				File = dark_tile,
			},
			repeat_x = "Repeat",
			repeat_y = "Repeat",
            opacity = 0.25,
			hsb = foreground_hsb_0,
		},
	},
	key_tables = {
		tmux = getKeys("tmux"),
		wezterm = getKeys("wezterm"),
	},
	keys = getKeys("default"),
}

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = false
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

-- local envvars = os.capture("printenv", true)
-- wezterm.log_info(envvars)
-- wezterm.log_info("random_font: ", config.font)
-- wezterm.log_info("abcdefghijklmnopqrstuvwxyz")
-- wezterm.log_info("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
-- wezterm.log_info("oO08 iIlL1 {} [] g9qCGQ ~-+=>")

return config
