from config import colors
from libqtile import layout, bar, widget
from libqtile.lazy import lazy
from libqtile.config import Screen

# WIDGETS FOR THE BAR
def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=colors[1])

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
						active = colors[9],
						inactive = colors[5],
						rounded = False,
						highlight_method = "text",
						this_current_screen_border = colors[9],
						foreground = colors[2],
						background = colors[1]
						),
				widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        size_percent = 50,
                        foreground = colors[2],
                        background = colors[1]
                        ),						
				widget.CurrentLayoutIcon(
						custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
						foreground = colors[0],
						background = colors[1],
						padding = 0,
						scale = 0.6
						),
				widget.CurrentLayout(
						font = "FontAwesome",
						fontsize = 16,
						foreground = colors[5],
						background = colors[1]
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
				widget.Sep(
                       linewidth = 0,
                       padding = 1850,
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
                       filename = "~/.config/qtile/icons/arch-linux-blue.png",
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
                        fontsize = 14,
                        margin_y = 3,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 3,
                        disable_drag = True,
                        active = colors[9],
                        inactive = colors[5],
                        rounded = True,
                        highlight_method = "text",
                        this_current_screen_border = colors[9],
                        foreground = colors[2],
                        background = colors[1]
                        ),
				widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        size_percent = 50,
                        foreground = colors[2],
                        background = colors[1]
                        ),
				widget.CurrentLayoutIcon(
						custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
						foreground = colors[0],
						background = colors[1],
						padding = 0,
						scale = 0.6
						),
				widget.CurrentLayout(
						font = "FontAwesome",
						fontsize = 14,
						foreground = colors[5],
						background = colors[1]
						),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[1]
						),
				widget.GenPollText(
						update_interval=10,
						background = colors[1],
						foreground = colors[9],
						font="FontAwesome",
						fontsize = 14,
						padding = 5,
						func=lambda: subprocess.check_output("/home/ngc/.bin/qtile-bar/loadav.sh").decode("utf-8"),
						),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[1]
						),
				#widget.WindowName(font="FontAwesome",
                        #fontsize = 14,
                        #foreground = colors[5],
                        #background = colors[1],
                        #),
				widget.WindowTabs(
						padding = 10,
						separator = '  |  '
						),
                # widget.Mpris2(
                        # name="audacious",
                        # objname="org.mpris.MediaPlayer2E",
                        # display_metadata=["xesam:title", "xesam:artist"],
                        # scroll_chars=None,
                        # stop_pause_text="Stop",
                        # mouse_callbacks={
                            # "Button1": mpris_playpause,
                            # "Button4": mpris_nexttrack,
                            # "Button5": mpris_prevtrack,
							# },
						# ),
				widget.TextBox(
						font="FontAwesome",
						fontsize=20,
						text="",
						foreground=colors[5],
						background=colors[1],
						padding = 5
						),
				widget.Moc(
						background='#1D1D1D',
						play_color='00ff00',
						noplay_color='cecece',
						font='FontAwesome',
						fontsize=14,
						max_chars = 40,
						padding = 3
						),
				widget.Sep(
						linewidth = 0,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[1]
						),
				widget.Image(
						filename = "~/.config/qtile/icons/ram4.png",
						margin = 5,
						scale = "True"
						),
				widget.GenPollText(
						update_interval=30,
						background = colors[1],
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
						background = colors[1],
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
						background = colors[1],
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
						background = colors[1]
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
						background = colors[1]
						),
				widget.TextBox(
                        font="FontAwesome",
                        text="  ",
                        foreground=colors[5],
                        background=colors[1],
                        padding = 0,
                        fontsize=16
                        ),
				widget.Clock(
						timezone="Europe/Sofia",
                        foreground = colors[5],
                        background = colors[1],
                        fontsize = 14,
                        format="%m.%d.%y %H:%M"
                        ),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 40,
						foreground = colors[2],
						background = colors[1]
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
						background = colors[1],
						padding = 2
						),
				#widget.KeyboardLayout(
					  # font="FontAwesome", #                  
					  # fontsize = 14,
					  # configured_keyboards = ['us','bg'],
					  # option = "grp:alt_shift_toggle"				  
						#),
				widget.Sep(
						linewidth = 1,
						padding = 10,
						size_percent = 40,
						foreground = colors[2],
						background = colors[1]
						),
				widget.Systray(
                        background=colors[1],
                        icon_size=20,
                        padding = 4
                        ),
                        #widget.TextBox(
                        #text = '',
                        #background = colors[1],
                        #foreground = colors[2],
                        #padding = 0,
                        #fontsize = 22
                        #),
				#widget.TextBox(
                        #text = " Vol:",
                        #foreground = colors[2],
                        #background = colors[1],
                        #padding = 0
                        #),
				#widget.Volume(
                        #foreground = colors[2],
                        #background = colors[1],
                        #padding = 5
                        #),
				#widget.Sep(
                        #linewidth = 1,
                        #padding = 10,
                        #foreground = colors[2],
                        #background = colors[1]
                        #),  
                widget.Sep(
						linewidth = 0,
						padding = 10,
						size_percent = 50,
						foreground = colors[2],
						background = colors[1]
						
						), 
   
              ]
              
    return widgets_list

def init_widgets_screen0():
    widgets_screen0 = init_widgets_list()
    #del widgets_screen1                
    return widgets_screen0					# Monitor 0 will display all widgets in widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list1()
#    del widgets_screen1[6:25]				# Slicing removes unwanted widgets (systray) on Monitor 1
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
