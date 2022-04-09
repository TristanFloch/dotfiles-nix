import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import XMonad.Layout.ThreeColumns
-- import XMonad.Layout.Magnifier -- TODO check this out

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

import Control.Monad (when)
import Text.Printf (printf)
import System.FilePath ((</>))
import System.Info (arch,os)
import System.Environment (getArgs)
import System.Posix.Process (executeFile)

myTerminal :: String
myTerminal = "alacritty"

myLayoutHook = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
    ratio    = 1/2    -- Default proportion of screen occupied by master pane

myKeyBindings :: [(String, X ())]
myKeyBindings =
  [ ("M-<Return>", spawn (myTerminal))
  , ("M-d", spawn "rofi -show drun")
  , ("M-<Tab>", sendMessage NextLayout)

  , ("M-<F1>", spawn "emacs")
  , ("M-<F2>", spawn "firefox")
  , ("M-<F3>", spawn "thunar")
  , ("M-<F4>", spawn "pavucontrol")

  -- most of those are rebind to fit my i3 config
  , ("M-S-c", compileRestart True)
  , ("M-S-r", restart "xmonad" True)
  , ("M-S-q", kill)
  , ("M-S-e", spawn "~/.config/rofi/powermenu.sh")

  , ("<XF86MonBrightnessUp>", spawn "brightnessctl -c backlight set +10%")
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl -c backlight set 10%-")
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
  , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
  , ("<XF86AudioMute>", spawn "amixer set Master toggle")
  ]

-- taken from NixOS documentation
-- FIXME fails on my xmonad version
compiledConfig = printf "xmonad-%s-%s" arch os

compileRestart resume =
  whenX (recompile True) $
  when resume writeStateToFile
  *> catchIO
  ( do
      dir <- getXMonadDataDir
      args <- getArgs
      executeFile (dir </> compiledConfig) False args Nothing
  )

-- compileRestart resume =
  -- dirs <- io getDirectories
  -- whenX (recompile dirs True) $ when resume writeStateToFile
  -- *> catchIO
  -- ( do args <- getArgs
  --     executeFile (cacheDir dirs </> compiledConfig) False args Nothing
  -- )

main :: IO ()
main = xmonad . ewmh =<< xmobar (def
    { modMask = mod4Mask
    , terminal = myTerminal
    , layoutHook = myLayoutHook
    , borderWidth = 2
    , normalBorderColor = background
    , focusedBorderColor = comment
    }
    `additionalKeysP` myKeyBindings)

-- Dracula colorscheme
background = "#1e2029";
foreground = "#f8f8f2";
transparent = "#00000000";
comment = "#6272a4";
cyan = "#8be9fd";
green = "#50fa7b";
orange = "#ffb86c";
pink = "#ff79c6";
purple = "#bd93f9";
red = "#ff5555";
yellow = "#f1fa8c";
black = "#000000";
