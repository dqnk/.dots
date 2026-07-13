-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Old: monitor=DP-1,highrr,0x0,1
-- hl.monitor({
-- 	output = "eDP-1",
-- 	mode = "highrr",
-- 	position = "0x1080",
-- 	scale = 1,
-- })
-- Hyprland re-applies monitor config on every reload, which would re-enable
-- eDP-1 even with the lid closed (see hyprwm/Hyprland#4090). So we read the
-- actual lid state at config-evaluation time and declare eDP-1 accordingly.
-- This also covers booting with the lid already closed.
local function lid_closed()
	local p = io.popen("cat /proc/acpi/button/lid/*/state 2>/dev/null")
	if not p then
		return false
	end
	local s = p:read("*a")
	p:close()
	return s:find("closed") ~= nil
end

if lid_closed() then
	hl.monitor({ output = "eDP-1", disabled = true })
else
	hl.monitor({
		output = "eDP-1",
		mode = "highrr",
		position = "0x1080",
		scale = 1,
	})
end

-- Old: monitor=HDMI-A-1,disable
hl.monitor({
	output = "DP-1",
	mode = "3840x2160@60.00",
	position = "3840x2160",
	scale = 2,
})

-- Old (commented): monitor=HDMI-A-1,highrr,2560x0,1
-- hl.monitor({ output = "HDMI-A-1", mode = "highrr", position = "2560x0", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local fileManager = "dolphin"
local editor = "kitty -e nvim"
local menu = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Ported from your exec-once / exec lines.
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("dunst")
	hl.exec_cmd('gnome-keyring-daemon --start --components="pkcs11,ssh,secrets"')
	hl.exec_cmd("kanshi")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
	hl.exec_cmd("sunsetr")
	hl.exec_cmd("sleep 1 && sunsetr restart")
	-- hl.exec_cmd("(killall hyprsunset) || (sleep 1 && hyprsunset -t 2500)")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Dolphin file type (was: env = XDG_MENU_PREFIX,arch-)
hl.env("XDG_MENU_PREFIX", "arch-")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		layout = "dwindle",

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,
	},

	decoration = {
		rounding = 10,

		-- Your old shadow block was commented out, so it's disabled here.
		shadow = {
			enabled = false,
			-- range        = 4,
			-- render_power = 3,
			-- color        = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},
	},

	animations = {
		enabled = true,
	},

	cursor = {
		no_warps = false, -- don't jump the cursor to the focused window
		persistent_warps = true, -- remember per-window cursor position on refocus
	},
})

-- Custom bezier (was: bezier = myBezier, 0.05, 0.9, 0.1, 1.05)
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Ported from your animation = ... lines
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "dvorak",
		kb_model = "",
		kb_options = "compose:ralt",
		kb_rules = "",

		numlock_by_default = true,

		follow_mouse = 1,

		accel_profile = "flat",
		sensitivity = -0.25, -- -1.0 - 1.0, 0 means no modification.

		repeat_rate = 40,
		repeat_delay = 400,

		touchpad = {
			natural_scroll = true,
		},
	},
})

-- 3-finger horizontal swipe to switch workspaces (replaces old workspace_swipe)
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT" -- main modifier
local mainMod2 = "SUPER" -- secondary modifier (used for second-monitor binds)

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("discord --enable-features=UseOzonePlatform --ozone-platform=wayland"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("kitty -e ipython"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen())
hl.bind("code:95", hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))     -- dwindle only

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("hyprlock"))

-- Screenshot region to clipboard
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + vim keys
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Second monitor workspaces (11-20) on mainMod2 -- enable when HDMI-A-1 is active
-- for i = 1, 10 do
--     local key = i % 10
--     hl.bind(mainMod2 .. " + " .. key,         hl.dsp.focus({ workspace = i + 10 }))
--     hl.bind(mainMod2 .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i + 10 }))
-- end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume + media keys (ported from your bindelti lines)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, repeating = true })

-- Brightness keys
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
-- Laptop lid switch
-- Lid closed
hl.bind("switch:on:Lid Switch", function()
	if #hl.get_monitors() > 1 then
		hl.monitor({ output = "eDP-1", disabled = true }) -- external attached → panel off
		hl.timer(function()
			hl.exec_cmd("hyprpaper")
		end, { timeout = 500, type = "oneshot" })
	else
		hl.exec_cmd("hyprlock") -- only screen → just lock
	end
end, { locked = true })

-- Lid opened
hl.bind("switch:off:Lid Switch", function()
	hl.monitor({
		output = "eDP-1",
		mode = "highrr",
		position = "0x1080",
		scale = 1,
		disabled = false,
	})
	hl.timer(function()
		hl.exec_cmd("hyprpaper")
	end, { timeout = 500, type = "oneshot" })
end, { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Confine the pointer when a window is fullscreen.
	-- NOTE: verify `confine_pointer` is still a valid rule on your Hyprland
	-- version; if it errors, remove this rule.
	name = "capture-mouse",
	match = { fullscreen = true },

	confine_pointer = true,
})
