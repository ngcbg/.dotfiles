# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

# Bindings
mod = "mod4"
mod1 = "alt"
mod2 = "control"
myTerm = "kitty"
menu = "jgmenu_run"
home = os.path.expanduser('~')

keys = [

# Kill, Shutdown, Rstgart and Full Screen
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "z", lazy.shutdown()),

# Layouts
    Key([mod], "n", lazy.layout.reset()),
    Key([mod], "space", lazy.next_layout()),

# Refocus
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

# Resize up, down, left, right
    Key([mod, "control"], "l", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete(),),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete(),),
    Key([mod, "control"], "h", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add(),),
    Key([mod, "control"], "Left", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add(),),
    Key([mod, "control"], "k", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster(),),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster(),),
    Key([mod, "control"], "j", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster(),),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster(),),

# Layout flip (MonadTall and MonadWide)
    Key([mod, "shift"], "f", lazy.layout.flip()),

# Rotate windows (MonadTall and MonadWide)
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

# Toglle ON/OFF floating layout
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    
# Keyboards focus to specific monitor
	Key([mod], "Left", lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
	Key([mod], "Right", lazy.to_screen(1), desc='Keyboard focus to monitor 2')

    ]



groups = []

# Groups & Layouts
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]
group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0",]
group_layouts = ["monadtall", "monadtall", "matrix", "monadwide", "max", "max", "matrix", "floating", "monadtall", "monadwide",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([

# Workspace change
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift" ], "Tab", lazy.screen.prev_group()),        

# Move window to workspace and STAY on current one
        Key([mod, "mod1"], i.name, lazy.window.togroup(i.name)),
        
# Move window to workspace and FOLLOW the window
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
        
    ])

def init_layout_theme():
    return {"margin":10,
            "border_width":2,
#            "border_focus": "#5e81ac",
			"border_focus": "#F08080",
            "border_normal": "#4c566a"
            }

layout_theme = init_layout_theme()

layouts = [
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),    
    #layout.Zoomy(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.RatioTile(**layout_theme),
    layout.MonadTall(margin=12, border_width=2, border_focus="#F08080", border_normal="#4c566a"),
    layout.MonadWide(margin=8, border_width=2, border_focus="#F08080", border_normal="#4c566a"),
    layout.Matrix(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Max(**layout_theme)
]

# Bar colors
def init_colors():
    return [["#2F343F", "#363F53"], # color 0
            ["#2F343F", "#2F343F"], # color 1
            ["#c0c5ce", "#c0c5ce"], # color 2
            ["#fba922", "#fba922"], # color 3
            ["#3384d0", "#3384d0"], # color 4
            ["#f3f4f5", "#f3f4f5"], # color 5
            ["#cd1f3f", "#cd1f3f"], # color 6
            ["#62FF00", "#62FF00"], # color 7
            ["#6790eb", "#6790eb"], # color 8
			["#F08080", "#F08080"]] # color 9

colors = init_colors()

# Widgets
def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=colors[0])

widget_defaults = init_widgets_defaults()

def init_widgets_list1():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list1 = [
				widget.GroupBox(
						font="FontAwesome",
						fontsize = 16,
						margin_y = 3,
						margin_x = 0,
						padding_y = 5,
						padding_x = 5,
						borderwidth = 3,
						disable_drag = True,
						active = "#7BA1B3",
						inactive = colors[5],
						rounded = False,
						highlight_method = "line",
						invert_mouse_wheel="True",
						this_current_screen_border = colors[9],
						foreground = colors[2],
						background = colors[0]
						),
				widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        size_percent = 50,
                        foreground = colors[2],
                        background = colors[0]
                        ),						
				widget.CurrentLayoutIcon(
						custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
						foreground = colors[0],
						background = colors[0],
						padding = 0,
						scale = 0.6
						),
				widget.CurrentLayout(
						font = "FontAwesome",
						fontsize = 16,
						foreground = colors[5],
						background = colors[0]
						),
				widget.Sep(
                       linewidth = 0,
                       padding = 100,
                       size_percent = 50,
                       foreground = colors[2],
                       background = colors[0]
                       ),						
				widget.DF(
						font = "FontAwesome",
						fontsize = 16,
						partition = '/',
						format = '{p} ({uf}{m}|{r:.0f}%)',
						measure = 'G',
						update_interval = 3600,
						visible_on_warn = False
						),
				widget.Sep(
                       linewidth = 0,
                       padding = 10,
                       size_percent = 50,
                       foreground = colors[2],
                       background = colors[0]
                       ),
				widget.DF(
						font = "FontAwesome",
						fontsize = 16,
						partition = '/home/',
						format = '{p} ({uf}{m}|{r:.0f}%)',
						measure = 'G',
						update_interval = 3600,
						visible_on_warn = False
						),
				widget.WindowTabs(
						padding = 10,
						separator = '  |  '
						),
				widget.Sep(
                       linewidth = 0,
                       padding = 1000,
                       size_percent = 50,
                       foreground = colors[2],
                       background = colors[0]
                       ),
					]
    return widgets_list1
                       
def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
				widget.Image(
                       filename = "~/.config/qtile/icons/arch-linux-botichely.png",
                       #filename = "~/.config/qtile/icons/arch-linux-wonb.png",
                       margin = 4,
                       scale = "True",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(menu)}
                       ),
				widget.Sep(
                       linewidth = 0,
                       padding = 10,
                       size_percent = 50,
                       foreground = colors[2],
                       background = colors[0]
                       ),
				widget.GroupBox(
						font="FontAwesome",
                        fontsize = 15,
                        margin_y = 3,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 3,
                        disable_drag = True,
                        active = "#7BA1B3",
                        inactive = colors[5],
#                        hide_unused="True",
                        highlight_method = "line",
                        invert_mouse_wheel="True",
                        this_current_screen_border = colors[9],
                        foreground = colors[2],
                        background = colors[0]
                        ),
				widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        size_percent = 50,
                        foreground = colors[2],
                        background = colors[0]
                        ),
				widget.CurrentLayoutIcon(
						custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
						foreground = colors[0],
						background = colors[0],
						padding = 0,
						scale = 0.6
						),
				widget.CurrentLayout(
						font = "FontAwesome",
						fontsize = 14,
						foreground = colors[5],
						background = colors[0]
						),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[0]
						),
				widget.GenPollText(
						update_interval=10,
						background = colors[0],
						foreground = "#7BA1B3",
						font="FontAwesome",
						fontsize = 15,
						padding = 5,
						func=lambda: subprocess.check_output("/home/ngc/.bin/qtile-bar/loadav.sh").decode("utf-8"),
						),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[0]
						),						
				widget.WindowTabs(
						padding = 10,
						separator = '  |  '
						),
				widget.TextBox(
						font="FontAwesome",
						fontsize=20,
						text="",
						foreground=colors[5],
						#background="#1D1D1D",
						background= colors[0],
						padding = 5
						),						
				widget.GenPollText(
						update_interval=5,
						#background = "#1D1D1D",
						foreground = "#7BA1B3",
						background = colors[0],
						#foreground = colors[8],
						font="Comic Sans MS",
						max_chars=60,
						fontsize = 16,
						padding = 5,
						func=lambda: subprocess.check_output("/home/ngc/.bin/qtile-bar/play.sh").decode("utf-8"),
						mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("playerctl play-pause"), 
										   'Button2': lambda: qtile.cmd_spawn("playerctl next"),
										   'Button3': lambda: qtile.cmd_spawn("playerctl previous"),
										   'Button5': lambda: qtile.cmd_spawn("playerctl position 10+"),
										   'Button4': lambda: qtile.cmd_spawn("playerctl position 10-")},
						),						
				# widget.TextBox(
						# font="FontAwesome",
						# fontsize=20,
						# text="",
						# foreground=colors[5],
						# background=colors[0],
						# padding = 5
						# ),
				# widget.Moc(
						# background='#1D1D1D',
						# play_color='00ff00',
						# noplay_color='cecece',
						# font='FontAwesome',
						# fontsize=14,
						# max_chars = 40,
						# padding = 3
						# ),
				widget.Sep(
						linewidth = 0,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[0]
						),
				widget.Image(
						filename = "~/.config/qtile/icons/ram4.png",
						margin = 5,
						scale = "True"
						),
				widget.GenPollText(
						update_interval=30,
						background = colors[0],
						font="FontAwesome",
						fontsize = 14,
						padding = 5,
						func=lambda: subprocess.check_output("/home/ngc/.bin/qtile-bar/mem-real.sh").decode("utf-8"),
						),              
				widget.Image(
						filename = "~/.config/qtile/icons/nvidia2.png",
						margin = 7,
						scale = "True"
						),
				widget.NvidiaSensors(
						update_interval = 10,
						format = '{temp}°',
						background = colors[0],
						font="FontAwesome",
						fontsize = 14,
						padding = 5,
						),
				widget.Image(
						filename = "~/.config/qtile/icons/cpu2.png",
						margin = 6,
						scale = "True"
						),                        
				widget.GenPollText(
						update_interval=20,
						background = colors[0],
						font="FontAwesome",
						fontsize = 14,
						padding = 5,
						func=lambda: subprocess.check_output("/home/ngc/.bin/qtile-bar/cpu_temp.sh").decode("utf-8"),
						),
				widget.Sep(
						linewidth = 1,
						padding = 5,
						size_percent = 50,
						foreground = colors[2],
						background = colors[0]
						),                            
				widget.Image(
						filename = "~/.config/qtile/icons/layout-floating.png",
						margin = 6,
						scale = "True",
						mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("skippy-xd")},
						padding = 5
						),
				widget.Sep(
						linewidth = 1,
						padding = 5,
						size_percent = 50,
						foreground = colors[2],
						background = colors[0]
						),
				widget.TextBox(
                        font="FontAwesome",
                        text="  ",
                        foreground=colors[5],
                        background=colors[0],
                        padding = 0,
                        fontsize=16
                        ),
				widget.Clock(
						timezone="Europe/Sofia",
                        foreground = colors[5],
                        background = colors[0],
                        fontsize = 14,
                        format="%m.%d.%y %H:%M"
                        ),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 40,
						foreground = colors[2],
						background = colors[0]
						),                        
				widget.CheckUpdates(
						update_interval = 3600,
						distro = "Arch_checkupdates",
						display_format = " Updates: {updates}",
						no_update_string = '',
						colour_no_updates = 'ffffff',
						colour_have_updates = 'cd1f3f',
						foreground = colors[5],
						mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('xterm' + ' -e sudo pacman -Suy')},
						background = colors[0],
						padding = 2
						),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 40,
						foreground = colors[2],
						background = colors[0]
						),
				widget.Systray(
                        background=colors[0],
                        icon_size=20,
                        padding = 4
                        ),
                widget.Sep(
						linewidth = 0,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[0]
						
						), 
   
              ]
              
    return widgets_list

def init_widgets_screen0():
    widgets_screen0 = init_widgets_list()
    return widgets_screen0

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list1()
    return widgets_screen1

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen0(), opacity=1.0, size=28)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=28))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_list1 = init_widgets_list1()
    widgets_screen0 = init_widgets_screen0()
    widgets_screen1 = init_widgets_screen1()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)
    
def show_shortcuts():
    key_map = {"mod1": "alt", "mod4": "super"}
    shortcuts_path = "{0}/{1}".format(os.environ["HOME"], "qtile_shortcuts")
    shortcuts = open("{0}".format(shortcuts_path), 'w')
    shortcuts.write("{0:30}| {1:50}\n".format("KEYS COMBINATION", "COMMAND"))
    shortcuts.write("{0:80}\n".format("=" * 80))
    for key in keys:
        key_comb = ""
        for modifier in key.modifiers:
            key_comb += key_map.get(modifier, modifier) + "+"
        key_comb += key.key
        shortcuts.write("{0:30}| ".format(key_comb))
        cmd_str = ""
        for command in key.commands:
            cmd_str += command.name + " "
            for arg in command.args:
                cmd_str += "{0} ".format(repr(arg))
        shortcuts.write("{0:50}\n".format(cmd_str))
        shortcuts.write("{0:80}\n".format("-" * 80))
    shortcuts.close()
    return lazy.spawn("xterm -wf -e vim {0}".format(shortcuts_path))
    
keys.append(Key([mod, "mod1" ], "h", show_shortcuts()))    

# MOUSE 
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

#Programs  to groups 

@hook.subscribe.client_new
def assign_app_group(client):
	d = {}
	d[group_names[0]] = ["Firefox", "Chromium", "firefox", "chromium", "Pcmanfm", "pcmanfm" ]
	d[group_names[1]] = ["Geany", "TelegramDesktop", "Discord", "geany", "telegramDesktop", "discord", ]
	d[group_names[2]] = ["Inkscape", "Nomacs", "Ristretto", "Nitrogen", "Feh", "inkscape", "nomacs", "ristretto", "nitrogen", "feh", ]
	d[group_names[3]] = ["Gimp", "gimp", "Incscape", "incskcape", ]
	d[group_names[4]] = ["Meld", "meld", "org.gnome.meld" "org.gnome.Meld", "VirtualBox Machine", "virtualbox machine", ]
	d[group_names[5]] = ["Vlc","vlc", "Mpv", "mpv", "Smplayer", "smplayer" ]
	d[group_names[6]] = ["VirtualBox Manager",  "Vmplayer", "virtualbox manager", "vmplayer", ]
	d[group_names[7]] = ["Thunar", "thunar", ]
	d[group_names[8]] = ["Thunderbird", "thunderbird" ]
	d[group_names[9]] = ["Audacious", "audacious" ]

	wm_class = client.window.get_wm_class()[0]
	for i in range(len(d)):
		if wm_class in list(d.values())[i]:
			group = list(d.keys())[i-1]
			client.togroup(group)
			client.group.cmd_toscreen(toggle=False)

main = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

@hook.subscribe.startup
def start_always():
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True
        
@hook.subscribe.client_new
def dialogs(window):
    if(window.window.get_wm_type() == 'dialog'
        or window.window.get_wm_transient_for()):
        window.floating = True        

floating_types = ["notification", "toolbar", "splash", "dialog"]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules, 
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='Arcolinux-welcome-app.py'),
    Match(wm_class='Arcolinux-tweak-tool.py'),
    Match(wm_class='Arcolinux-calamares-tool.py'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='Galculator'),
    Match(wm_class='arcolinux-logout'),
    Match(wm_class='xfce4-terminal'),

],  fullscreen_border_width = 0, border_width = 0)

focus_on_window_activationfocus_on_window_activationauto_fullscreen = True
focus_on_window_activation = "smart" # or focus
wmname = "Qtile"
