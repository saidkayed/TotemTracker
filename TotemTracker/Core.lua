local isFire = false
local isEarth = false
local isAir = false
local isWater = false

-- duration for totems
local expirationTimeF
local expirationTimeE
local expirationTimeW
local expirationTimeA

local frame = CreateFrame("Frame")

----------------FRAME----------------------------------------

local f = CreateFrame("Frame", "Totem", UIParent)

f:SetPoint("CENTER")

f:SetFrameStrata("BACKGROUND")
f:SetWidth(200) -- Set these to whatever height/width is needed 
f:SetHeight(80) -- for your Texture

f:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    edgeSize = 16,
    insets = {left = 4, right = 4, top = 4, bottom = 4}
})
f:SetBackdropColor(0, 0, 0, 1)

f:SetMovable(true)
f:EnableMouse(true)

f:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and not self.isMoving then
        self:StartMoving();
        self.isMoving = true;
    end
end)

f:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" and self.isMoving then
        self:StopMovingOrSizing();
        self.isMoving = false;
    end
end)

f:SetPoint("CENTER", 0, 0)

--------------------TEXT-----------------------------------------------

local x = 0
local y = 0
local totem = ""

f.text = f:CreateFontString(nil, "OVERLAY")
f.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
f.text:SetPoint("TOPLEFT", x + 10, y - 10)
f.text:SetText("Fire          Earth         Water        Air")

-- f.text = f:CreateFontString(nil, "OVERLAY")
-- f.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
-- f.text:SetPoint('TOPLEFT', 10, -60)

local t = CreateFrame("Frame", nil, f)
t:SetPoint('CENTER', 0, 0)
t:SetWidth(200) -- Set these to whatever height/width is needed 
t:SetHeight(80) -- for your Texture
t.text = t:CreateFontString(nil, "OVERLAY")
t.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
t.text:SetPoint('TOPLEFT', 10, -60)

local t2 = CreateFrame("Frame", nil, f)
t2:SetPoint('CENTER', 0, 0)
t2:SetWidth(200) -- Set these to whatever height/width is needed 
t2:SetHeight(80) -- for your Texture
t2.text = t:CreateFontString(nil, "OVERLAY")
t2.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
t2.text:SetPoint('TOPLEFT', 65, -60)

local t3 = CreateFrame("Frame", nil, f)
t3:SetPoint('CENTER', 0, 0)
t3:SetWidth(200) -- Set these to whatever height/width is needed 
t3:SetHeight(80) -- for your Texture
t3.text = t:CreateFontString(nil, "OVERLAY")
t3.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
t3.text:SetPoint('TOPLEFT', 120, -60)

local t4 = CreateFrame("Frame", nil, f)
t4:SetPoint('CENTER', 0, 0)
t4:SetWidth(200) -- Set these to whatever height/width is needed 
t4:SetHeight(80) -- for your Texture
t4.text = t:CreateFontString(nil, "OVERLAY")
t4.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
t4.text:SetPoint('TOPLEFT', 168, -60)

----------Buttons-------------------------------------------------

local b = CreateFrame("Button", nil, f)
b:SetPoint('TOPLEFT', 5, -25)
b:SetWidth(32) -- Set these to whatever height/width is needed 
b:SetHeight(32) -- for your Texture
b:SetText("TOTEM")
-- b:SetScript('OnClick', function() DEFAULT_CHAT_FRAME:AddMessage("clicked") end)

-- Add the icon:
local icon = b:CreateTexture(nil, "ARTWORK")
icon:SetAllPoints(true)

local b2 = CreateFrame("Button", nil, f)
b2:SetPoint('TOPLEFT', 60, -25)
b2:SetWidth(32) -- Set these to whatever height/width is needed 
b2:SetHeight(32) -- for your Texture
b2:SetText("TOTEM")
-- b2:SetScript('OnClick', function() DEFAULT_CHAT_FRAME:AddMessage("clicked") end)

-- Add the icon:
local icon2 = b2:CreateTexture(nil, "ARTWORK")
icon2:SetAllPoints(true)

local b3 = CreateFrame("Button", nil, f)
b3:SetPoint('TOPLEFT', 115, -25)
b3:SetWidth(32) -- Set these to whatever height/width is needed 
b3:SetHeight(32) -- for your Texture
b3:SetText("TOTEM")
-- b3:SetScript('OnClick', function() DEFAULT_CHAT_FRAME:AddMessage("clicked") end)

-- Add the icon:
local icon3 = b3:CreateTexture(nil, "ARTWORK")
icon3:SetAllPoints(true)

local b4 = CreateFrame("Button", nil, f)
b4:SetPoint('TOPLEFT', 163, -25)
b4:SetWidth(32) -- Set these to whatever height/width is needed 
b4:SetHeight(32) -- for your Texture
b4:SetText("TOTEM")
-- b4:SetScript('OnClick', function() DEFAULT_CHAT_FRAME:AddMessage("clicked") end)

-- Add the icon:
local icon4 = b4:CreateTexture(nil, "ARTWORK")
icon4:SetAllPoints(true)

--------------------- TOTEMTRACKER LOGIC -----------------------------

f:RegisterEvent("UNIT_SPELLCAST_SENT");
f:RegisterEvent("PLAYER_TOTEM_UPDATE");

f:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4)

    -- if (event == "UNIT_SPELLCAST_SENT" and arg1 == "player") then

    --  if string.find(arg2, "Totem") then totem = arg2 end
    -- end

    if (event == "PLAYER_TOTEM_UPDATE") then TotemChecker() end

end)

function TotemChecker()

    for index = 1, MAX_TOTEMS do
        local arg1, totemName, startTime, duration, icon = GetTotemInfo(index)
        seconds = GetTotemTimeLeft(index)

        ButtonIconPlacer(icon, index, seconds)

    end

end

-- icons = icon path
-- element integer - index of the totem (Fire = 1 Earth = 2 Water = 3 Air = 4)

function ButtonIconPlacer(icons, element, durr)

    if (element == 1) then

        isFire = true
        expirationTimeF = durr

        icon:SetTexture(icons)

    end

    if (element == 2) then
        isEarth = true
        expirationTimeE = durr

        icon2:SetTexture(icons)

    end
    isWater = true
    if (element == 3) then
        expirationTimeW = durr
        icon3:SetTexture(icons)
    end
    isAir = true
    if (element == 4) then
        expirationTimeA = durr
        icon4:SetTexture(icons)
    end

end

-- DURR TIMER

local timeElapsed = 0
frame:SetScript("OnUpdate", function(self, elapsed)

    -- Do stuff

    if (isFire and expirationTimeF ~= 0) then
        expirationTimeF = expirationTimeF - elapsed
        t.text:SetText(math.ceil(expirationTimeF))

        IconFader(expirationTimeF, icon)

    else
        icon:SetTexture("")
        t.text:SetText("")
    end

    if (isEarth and expirationTimeE ~= 0) then
        expirationTimeE = expirationTimeE - elapsed
        t2.text:SetText(math.ceil(expirationTimeE))
        
        IconFader(expirationTimeE, icon2)

    else
        icon2:SetTexture("")
        t2.text:SetText("")
    end

    if (isWater and expirationTimeW ~= 0) then
        expirationTimeW = expirationTimeW - elapsed
        t3.text:SetText(math.ceil(expirationTimeW))

        IconFader(expirationTimeW, icon3)
    else
        icon3:SetTexture("")
        t3.text:SetText("")
    end

    if (isAir and expirationTimeA ~= 0) then
        expirationTimeA = expirationTimeA - elapsed
        t4.text:SetText(math.ceil(expirationTimeA))

        IconFader(expirationTimeA, icon4)
    else
        icon4:SetTexture("")
        t4.text:SetText("")
    end

end)

-- When the frame is shown, reset the update timer
frame:SetScript("OnShow", function(self) timeElapsed = 0 end)





function IconFader(durr, totemIcon)

    if (durr < 10) then

        totemIcon:SetAlpha(0.5)
    else
        totemIcon:SetAlpha(1)
    end

end
