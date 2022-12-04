import XMonad
import XMonad.Util.EZConfig 
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.StackSet as W
import XMonad.Layout.Tabbed
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.ManageHelpers (doCenterFloat, isDialog)
import XMonad.Layout.NoBorders
import System.Exit -- io exitSuccess
import XMonad.Hooks.InsertPosition
import XMonad.Actions.CycleSelectedLayouts
import XMonad.Actions.SimpleDate
import XMonad.Actions.WithAll (sinkAll)
import XMonad.Layout.ResizableThreeColumns

main :: IO ()
main = xmonad $ ewmhFullscreen . ewmh $ def
    { modMask = mod4Mask
    , terminal = term 
    , layoutHook = layoutHook'
    , manageHook = manageHook'
    , borderWidth = 3
    , focusedBorderColor = "#c4a4ed"
    , normalBorderColor = "#353548"
    , keys = flip mkKeymap keymap'
    , workspaces = workspaces'
    , focusFollowsMouse = False
    , clickJustFocuses = False
    }

browser = "qutebrowser"
term = "alacritty"
launcher = "dmenu_run"
decreaseV = "volume down"
increaseV = "volume up"
screenArea = "maim -s | xclip -selection clipboard -t image/png"
screenWhole = "maim | xclip -selection clipboard -t image/png"
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
restartXMonad = spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"

layoutHook' =  smartBorders (tiled ||| tC ||| simpleTabbed ||| Full)
    where 
        tiled = Tall nmaster delta ratio
        tC = ResizableThreeColMid nmaster delta ratio []
        nmaster = 1
        ratio = 1/2
        delta = 3/100

manageHook' = composeAll
    [ className =? "mpv" --> doShift "3"
    , className =? "Arandr" --> doCenterFloat
    , className =? "Sxiv" --> doCenterFloat
    , className =? "Xmessage" --> doCenterFloat
    , isDialog            --> doFloat
    , namedScratchpadManageHook scratchpads
    , insertPosition Master Newer
    ]

scratchpads = [
    NS "term" "alacritty --title term" (title =? "term") 
        (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
    ]


-- mod-[1..9] %! Switch to workspace N
-- mod-shift-[1..9] %! Move client to workspace N
workspaceKeymap' = 
    [("M-" ++ m ++ k, windows $ f i)
        | (i, k) <- zip (cycle workspaces') $ map show [1..9] 
        , (f, m) <- [(W.greedyView, ""), (W.shift, "S-")]]

keymap' = 
    workspaceKeymap' ++
    -- spawn
    [ ("M-b" , spawn browser) 
     , ("M-r", spawn launcher)
     , ("M-<Return>" , spawn term)
     , ("M-t", spawn screenArea)
     , ("M-g", spawn screenWhole)
     -- stack
     , ("M-S-<Return>" , windows W.swapMaster)
     , ("M-e", windows W.focusDown)
     , ("M-i", windows W.focusUp)
     , ("M-S-e", windows W.swapDown)
     , ("M-S-i", windows W.swapUp)
     , ("M-m", windows W.focusMaster)
     , ("M-S-w", withFocused $ windows . W.sink) -- float to tiled
     , ("M-w", sinkAll) -- float to tiled all windows
     , ("M-S-c", kill)

     -- change layout
     -- hacky way to get fullscreen with M-f
     , ("M-f", cycleThroughLayouts ["Full", "Tall"])
     , ("M-<Space>", sendMessage NextLayout)
     -- , ("M-S-<Space>", setLayout $ layoutHook' conf)

     -- resize windows
     , ("M-n", sendMessage Shrink)
     , ("M-o", sendMessage Expand)
     , ("M-S-x", refresh) -- ??


     -- scratchpad
     , ("M-s", namedScratchpadAction scratchpads "term")

     -- audio
     , ("<XF86AudioRaiseVolume>", spawn increaseV)
     , ("<XF86AudioLowerVolume>", spawn decreaseV)

     -- restart/quit xmonad
      , ("M-q", restartXMonad)
      , ("M-S-q", io exitSuccess)
      , ("M-z", date)
       ]
