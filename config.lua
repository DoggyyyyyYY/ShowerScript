Config = {}

-- Shower coordinates
Config.ShowerCoords = {
    { x = -633.6021, y = 944.3239, z = 243.9170, heading = 351.5461 }, -- Change these coordinates to the desired shower locations
    { x = -707.4040, y = 990.9075, z = 238.0056, heading = 302.2575 },
    { x = -700.9876, y = 600.1234, z = 100.0000, heading = 270.0 },
    -- Add more coordinates here if needed
}

Config.ShowerControl = 38 -- Change this control value to the desired input for triggering the shower (see https://docs.fivem.net/docs/game-references/controls/)
Config.ShowerDuration = 7000

Config.MarkerType = 2 -- Change this value to the desired marker type (see https://docs.fivem.net/docs/game-references/markers/)
Config.MarkerSize = { x = 1.3, y = 1.3, z = 1.3 } -- Change this value to adjust the size of the marker
Config.MarkerColor = { r = 0, g = 128, b = 255, a = 150 } -- Change this value to adjust the color and opacity of the marker
Config.MarkerDistance = 5.0 -- Change this value to adjust the distance at which the marker becomes visible
