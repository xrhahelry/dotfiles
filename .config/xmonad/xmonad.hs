import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Actions.Navigation2D
import XMonad.Layout.WindowNavigation
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Actions.CycleWS
import System.Exit
import System.Process
import qualified XMonad.StackSet as W
import qualified Data.Map as M

------------------------------------------------------------------------
-- Basic Configuration
------------------------------------------------------------------------
myTerminal :: String
myTerminal = "alacritty"

myModMask :: KeyMask
myModMask = mod4Mask  -- Super key

myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#3f444a"

myFocusedBorderColor :: String
myFocusedBorderColor = "#51afef"

myWorkspaces :: [String]
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

-- Keep track of previous layout
previousLayout :: String
previousLayout = "Tall"

------------------------------------------------------------------------
-- Monitor Detection and Setup
------------------------------------------------------------------------
-- Detect number of connected monitors
getConnectedMonitors :: IO Int
getConnectedMonitors = do
    output <- readProcess "xrandr" ["--listactivemonitors"] ""
    let monitors = length $ filter (elem ':') $ lines output
    return $ max 1 monitors  -- At least 1 monitor

-- Setup monitor configuration based on detected monitors
setupMonitors :: IO ()
setupMonitors = do
    numMonitors <- getConnectedMonitors
    case numMonitors of
        1 -> return ()  -- Single monitor, no setup needed
        2 -> spawn "xrandr --output HDMI-1-0 --mode 1600x900 --right-of eDP-1"
        3 -> do
            spawn "xrandr --output HDMI-1-0 --mode 1600x900 --right-of eDP-1"
            spawn "xrandr --output DP-1 --mode 1920x1080 --right-of HDMI-1-0"
        _ -> return ()  -- Handle additional monitors as needed

------------------------------------------------------------------------
-- Custom Functions
------------------------------------------------------------------------
-- Toggle between fullscreen and previous layout
toggleFullscreen :: X ()
toggleFullscreen = do
    description <- gets (description . W.layout . W.workspace . W.current . windowset)
    if "Full" `elem` words description
        then sendMessage $ JumpToLayout "Tall"  -- Exit fullscreen to Tall layout
        else sendMessage $ JumpToLayout "Full"  -- Enter fullscreen

------------------------------------------------------------------------
-- Navigation Configuration
------------------------------------------------------------------------
myNavConf :: Navigation2DConfig
myNavConf = def
    { defaultTiledNavigation = centerNavigation
    , floatNavigation = centerNavigation
    , layoutNavigation = [("Full", centerNavigation)]
    }

------------------------------------------------------------------------
-- Key Bindings
------------------------------------------------------------------------
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Basic bindings
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)  -- mod + return = terminal
    , ((modm,               xK_p     ), spawn "dmenu_run")             -- mod + p = dmenu
    , ((modm,               xK_q     ), kill)                          -- mod + c = close window
    , ((modm,               xK_w     ), spawn "firefox")
    , ((modm,               xK_n     ), spawn "obsidian")
    , ((modm,               xK_e     ), spawn "nautilus")

    -- Window focus navigation (hjkl)
    , ((modm,               xK_h     ), windowGo L True)              -- mod + h = focus left
    , ((modm,               xK_j     ), windowGo D True)              -- mod + j = focus down
    , ((modm,               xK_k     ), windowGo U True)              -- mod + k = focus up
    , ((modm,               xK_l     ), windowGo R True)              -- mod + l = focus right

    -- Window movement (shift + hjkl)
    , ((modm .|. shiftMask, xK_h     ), windowSwap L True)            -- mod + shift + h = move window left
    , ((modm .|. shiftMask, xK_j     ), windowSwap D True)            -- mod + shift + j = move window down
    , ((modm .|. shiftMask, xK_k     ), windowSwap U True)            -- mod + shift + k = move window up
    , ((modm .|. shiftMask, xK_l     ), windowSwap R True)            -- mod + shift + l = move window right

    -- Monitor switching (wer)
    , ((modm,               xK_u     ), screenWorkspace 0 >>= flip whenJust (windows . W.view))      -- mod + w = switch to monitor 1
    , ((modm,               xK_i     ), screenWorkspace 1 >>= flip whenJust (windows . W.view))      -- mod + e = switch to monitor 2
    , ((modm,               xK_o     ), screenWorkspace 2 >>= flip whenJust (windows . W.view))      -- mod + r = switch to monitor 3

    -- Move windows to monitors (shift + wer)
    , ((modm .|. shiftMask, xK_u     ), screenWorkspace 0 >>= flip whenJust (windows . W.shift))     -- mod + shift + w = move window to monitor 1
    , ((modm .|. shiftMask, xK_i     ), screenWorkspace 1 >>= flip whenJust (windows . W.shift))     -- mod + shift + e = move window to monitor 2
    , ((modm .|. shiftMask, xK_o     ), screenWorkspace 2 >>= flip whenJust (windows . W.shift))     -- mod + shift + r = move window to monitor 3

    -- Window management
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)                               -- mod + t = toggle floating/tiling
    , ((modm,               xK_Tab   ), sendMessage NextLayout)                                       -- mod + tab = cycle layouts
    , ((modm,               xK_f     ), toggleFullscreen)                                             -- mod + f = toggle fullscreen

    -- XMonad management
    , ((modm,               xK_c     ), spawn "xmonad --recompile; xmonad --restart")                -- mod + q = restart xmonad
    , ((modm .|. shiftMask, xK_c     ), io (exitWith ExitSuccess))                                   -- mod + shift + q = quit xmonad
    ]
    ++
    -- Workspace switching (mod + 1-9)
    [((modm, k), windows $ W.greedyView i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]
    ++
    -- Move windows to workspaces (mod + shift + 1-9)
    [((modm .|. shiftMask, k), windows $ W.shift i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]

------------------------------------------------------------------------
-- Mouse Bindings
------------------------------------------------------------------------
myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]

------------------------------------------------------------------------
-- Layouts
------------------------------------------------------------------------
myLayout = configurableNavigation noNavigateBorders $
           avoidStruts $
           smartBorders $
           (tiled ||| Mirror tiled ||| noBorders Full)
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

------------------------------------------------------------------------
-- Window Rules
------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ] <+> manageDocks

------------------------------------------------------------------------
-- Event Handling
------------------------------------------------------------------------
-- myEventHook = ewmhFullscreen

------------------------------------------------------------------------
-- Startup Hook
------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook = do
    spawnOnce "xrandr --output HDMI-1-0 --mode 1600x900 --right-of eDP-1"
    spawnOnce "feh --randomize --bg-fill /home/xrhahelry/Pictures/wallpapers/*"
    spawnOnce "picom"

------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------
main :: IO ()
main = do
    xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc"
    xmonad $ withNavigation2DConfig myNavConf $ docks $ ewmh defaults

------------------------------------------------------------------------
-- Configuration
------------------------------------------------------------------------
defaults = def
    { terminal           = myTerminal
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    -- , handleEventHook    = fullscreenEventHook
    , startupHook        = myStartupHook
    }
