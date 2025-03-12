#ifndef ABSENT_CONFIG_H
#define ABSENT_CONFIG_H

#include <X11/keysym.h>

#include "src/keycallbacks.h"
#include "src/types.h"

#define DEFAULT_LAYOUT TILED

#define SCREEN_GAP 10
#define LAYOUT_GAP 5

#define MAIN_WINDOW_AREA 0.5

#define SET_NEW_WINDOW_MAIN 0

#define MIN_WINDOW_WIDTH 100
#define MIN_WINDOW_HEIGHT 100

#define BORDER_WIDTH 1
#define FOCUSED_BORDER_COLOR 0xf38ba8
#define UNFOCUSED_BORDER_COLOR 0x9399b2

#define NOMOD XCB_NONE
#define ALT XCB_MOD_MASK_1
#define SUPER XCB_MOD_MASK_4
#define SHIFT XCB_MOD_MASK_SHIFT
#define CONTROL XCB_MOD_MASK_CONTROL

#define BUTTON_MOD SUPER

#define ENABLE_AUTOSTART 1

static const desktop_config_t desktops[] = {
    {"eDP-1", {"1", "2", "3", "4"}},
    {"HDMI-1", {"5", "6", "7", "8"}},
};

static const keybind_t keybinds[] = {
    {XK_Return, SUPER, run, "kitty"},
    {XK_b, SUPER, run, "librewolf"},
    {XK_r, SUPER, run, "rofi -show drun"},
    {XK_Print, NOMOD, run,
     "flameshot gui -r | xclip -selection clipboard -t image/png"},
    {XK_j, SUPER, cyclefocusdown, NULL},
    {XK_k, SUPER, cyclefocusup, NULL},
    {XK_t, SUPER, setlayout, "TILED"},
    {XK_v, SUPER, setlayout, "VERTICAL"},
    {XK_h, SUPER, setlayout, "HORIZONTAL"},
    {XK_p, SUPER, setlayout, "PSEUDOFULLSCREEN"},
    {XK_t, SUPER | SHIFT, setfocustiled, NULL},
    {XK_f, SUPER | SHIFT, setfocusfullscreen, NULL},
    {XK_s, SUPER, swapmainfocus, NULL},
    {XK_j, SUPER | SHIFT, swapfocusdown, NULL},
    {XK_k, SUPER | SHIFT, swapfocusup, NULL},
    {XK_c, SUPER, destroyclient, NULL},
    {XK_c, SUPER | SHIFT, killclient, NULL},
    {XK_Escape, SUPER, killwm, NULL},
    {XK_1, SUPER, setcurrentdesktop, "1"},
    {XK_2, SUPER, setcurrentdesktop, "2"},
    {XK_3, SUPER, setcurrentdesktop, "3"},
    {XK_4, SUPER, setcurrentdesktop, "4"},
    {XK_5, SUPER, setcurrentdesktop, "5"},
    {XK_6, SUPER, setcurrentdesktop, "6"},
    {XK_7, SUPER, setcurrentdesktop, "7"},
    {XK_8, SUPER, setcurrentdesktop, "8"},
    {XK_1, ALT, movefocustodesktop, "1"},
    {XK_2, ALT, movefocustodesktop, "2"},
    {XK_3, ALT, movefocustodesktop, "3"},
    {XK_4, ALT, movefocustodesktop, "4"},
    {XK_5, ALT, movefocustodesktop, "5"},
    {XK_6, ALT, movefocustodesktop, "6"},
    {XK_7, ALT, movefocustodesktop, "7"},
    {XK_8, ALT, movefocustodesktop, "8"},
};
#endif
