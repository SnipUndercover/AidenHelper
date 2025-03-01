local drawableNinePatch = require("structs.drawable_nine_patch")
local drawableRectangle = require("structs.drawable_rectangle")
local drawableSprite = require("structs.drawable_sprite")

local dashKevin = {}

local axesOptions = {
    Both = "both",
    Vertical = "vertical",
    Horizontal = "horizontal"
}

dashKevin.name = "AidenHelper/DashKevin"
dashKevin.depth = 0
dashKevin.minimumSize = {24, 24}
dashKevin.fieldInformation = {
    axes = {
        options = axesOptions,
        editable = false
    }
}
dashKevin.placements = {}

for _, axis in pairs(axesOptions) do
    table.insert(dashKevin.placements, {
        name = axis,
        data = {
            width = 24,
            height = 24,
            axes = axis,
            chillout = false
        }
    })
end

local frameTextures = {
    none = "objects/crushblock/block00",
    horizontal = "objects/crushblock/block01",
    vertical = "objects/crushblock/block02",
    both = "objects/crushblock/block03"
}

local ninePatchOptions = {
    mode = "border",
    borderMode = "repeat"
}

local dashKevinColor = {98 / 255, 34 / 255, 43 / 255}
local smallFaceTexture = "objects/crushblock/idle_face"
local giantFaceTexture = "objects/crushblock/giant_block00"

function dashKevin.sprite(room, entity)
    local x, y = entity.x or 0, entity.y or 0
    local width, height = entity.width or 24, entity.height or 24

    local axes = entity.axes or "both"
    local chillout = entity.chillout

    local giant = height >= 48 and width >= 48 and chillout
    local faceTexture = giant and giantFaceTexture or smallFaceTexture

    local frameTexture = frameTextures[axes] or frameTextures["both"]
    local ninePatch = drawableNinePatch.fromTexture(frameTexture, ninePatchOptions, x, y, width, height)

    local rectangle = drawableRectangle.fromRectangle("fill", x + 2, y + 2, width - 4, height - 4, dashKevinColor)
    local faceSprite = drawableSprite.fromTexture(faceTexture, entity)

    faceSprite:addPosition(math.floor(width / 2), math.floor(height / 2))

    local sprites = ninePatch:getDrawableSprite()

    table.insert(sprites, 1, rectangle:getDrawableSprite())
    table.insert(sprites, 2, faceSprite)

    return sprites
end

return dashKevin