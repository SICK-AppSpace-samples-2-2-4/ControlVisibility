--[[----------------------------------------------------------------------------

  Application Name:
  ControlVisibility

  Summary:
  Showing/Hiding UI controls from within Lua

  Description:
  This Sample provides the functionality to show or hide controls on the UI
  based on state in Lua script. A timer is used for demonstration to trigger
  an event to which the visible property of the control is bound to.

  How to run:
  Connect to Emulator or device. Start the App and open the device webpage.
  The visibility of some controls is now changed periodically

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

-- luacheck: globals gTmr

-- Variable for holding current visibility state
local visibility = false

-- Creating timer for demonstration
gTmr = Timer.create()
gTmr:setExpirationTime(1000)
gTmr:setPeriodic(true)

-- Serving event where the UI control is bound to
Script.serveEvent('UI.OnVisibilityChanged', 'OnVisibilityChanged')

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  gTmr:start()
end
Script.register('Engine.OnStarted', main)

-- Only called once from the control after reloading the UI page
-- to get initial state
local function getVisibility()
  return visibility
end
Script.serveFunction('UI.getVisibility', getVisibility)

-- Toggling visibility state and notify event to update control
local function handleOnExpired()
  visibility = not visibility
  Script.notifyEvent('OnVisibilityChanged', visibility)
end
Timer.register(gTmr, 'OnExpired', handleOnExpired)

--End of Function and Event Scope-----------------------------------------------
