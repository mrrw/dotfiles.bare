import XMonad
import System.Exit
import Data.Monoid
import Control.Monad (liftM2)
import XMonad.Config.Desktop
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Layout
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.TwoPane (TwoPane(..))
import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.ManageHook
import qualified XMonad.StackSet   as W
import qualified Data.Map          as M

baseConfig = defaultConfig
main = xmonad $ baseConfig
    { terminal              =    myTerm
    , modMask               =    myModMask
    , borderWidth	        =    bW
	, workspaces            =    myWs
	, normalBorderColor     =    myNormalBC
	, focusedBorderColor    =    myFocusedBC

     -- key bindings
--	, keys                  =    myKeys
--	, mouseBindings         =    myMouseBindings

     -- hooks, layouts
	, layoutHook            =    myLayout
	, manageHook            =    myManageHook
--	, logHook               =    myLogHook
	, startupHook           =    myStartupHook
    }

myTerm      =    "urxvt"
myModMask   =    mod1Mask -- left alt
bW          =    3
myNormalBC  =    "#000000"
myFocusedBC =    "#ff8800"

myWs        =    ["SYS","TERM","MEDIA","REAPER","FIREFOX"]


--myLayout    =    smartBorders $ ThreeColMid 1 (3/100) (1/2)
--myLayout = smartBorders $ Tall { tallNMaster :: 2
--					, tallRatioIncrement :: 10/100
--					, tallRatio :: 60/100
--					}

--  myLayout = Tall 2 (3/100) (2/5)	   
myLayout =
  smartBorders $ -- layouts begin below
  Tall 2 (10/100) (60/100)
  ||| TwoPane (15/100) (55/100)
  ||| Mirror (Tall 2 (10/100) (60/100))
  ||| noBorders Full
--  ||| Grid
--  ||| simpleTabbed

focusFollowsMouse :: Bool
focusFollowsMouse = False
clickJustFocuses :: Bool
clickJustFocuses = True

-----------------------------------------------------
-- Startup
--

myStartupHook = do
    { spawnOnce "urxvt -e asciiquarium"
    <+> spawnOnce "urxvt -e htop"
--    <+> spawnOnce "urxvt -e neofetch"
--    <+> spawnOnce "urxvt -e asciiquarium"
--    <+> spawnOnce "urxvt"

    }



-----------------------------------------------------
-- Key bindings.
--
--myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
     -- launch a terminal
--    [ ((modm .|. shiftMask, xK_Return   ), spawn $ XMonad.terminal conf)
--    , ((modm,               xK_h        ), windows W.focusDown)
--    , ((modm,               xK_l        ), windows W.focusUp)
--    , ((modm,               xK_j        ), sendMessage Shrink)
--    , ((modm,               xK_k        ), sendMessage Expand)
--    , ((modm,               xK_d        ), spawn ("dmenu_run"))
--    , ((modm .|. shiftMask, xK_c        ), kill)
--    , ((modm,               xK_Tab      ), (windows W.swapDown),(windows W.focusUp))
 --   , ((modm .|. shiftMask, xK_q        ), io (exitWith ExitSuccess))
 --   ]
 --   ++
 --   [((m .|. modm, k), windows $ f i)
 --   | (i, k) <- zip (XMonad.workspaces conf) [xK_1 // xK_9]
 --   , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
 --   ]

-- mod-shift-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
-- mod-shift{w,,e,r}, move client to screen 1, 2, or 3
-- [((m .|. modMask, key) screenWorkspace sc >>= flip whenJust (windows .f))
-- 	| (key, sc) <-zip [xK_w, xK_e, xK_r] [0..]
-- 	, (f,m) <-[(W.view, 0), (W.shift, shiftMask)]]

-- mod-[1-9], Switch to workspace N
-- mod-shift-[1-9], Move client to workspace N
--[((m .|. modMask,k), windows $ f i)
--	| (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
--	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


------------------------------------------------------
-- Window Rules
--
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window.  You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
-- 
-- To match on the WM_NAME, you can use 'title' in the same way that 
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"    --> doFloat
    , className =? "htop"       --> doShift "SYS"
    , className =? "Reaper"     --> viewShift "REAPER"
    , className =? "firefox"    --> viewShift "FIREFOX"
    ]
    where
viewShift = doF . liftM2 (.) W.greedyView W.shift 

