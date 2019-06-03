-- ZooKeeper (TBC/WotLK)

local ZooButton = CreateFrame("Button", nil, FriendsFrame)
ZooButton:SetPoint("TOPRIGHT", -95, -38)
ZooButton:SetWidth(32)
ZooButton:SetHeight(32)

local ZooButtonTexture = ZooButton:CreateTexture(nil, "ARTWORK")
ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
ZooButtonTexture:SetAllPoints()

local ZooFrame = CreateFrame("Frame", nil, UIParent)
ZooFrame:SetPoint("CENTER", "FriendsFrame", -12, 4)
ZooFrame:SetWidth(325)
ZooFrame:SetHeight(360)
ZooFrame:SetFrameStrata("HIGH")
ZooFrame:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = false,
	edgeSize = 16
})
ZooFrame:SetBackdropBorderColor(0.5, 0.5, 0.5)
ZooFrame:Hide()

local ZooBackground = ZooFrame:CreateTexture(nil, "BACKGROUND")
ZooBackground:SetAllPoints()
ZooBackground:SetTexture(0.05, 0.05, 0.05)

local ZooListFrame = CreateFrame("Frame", nil, ZooFrame)
ZooListFrame:SetPoint("TOPLEFT", 0, 0)
ZooListFrame:SetWidth(320)
ZooListFrame:SetHeight(330)

local ZooListScrollFrame = CreateFrame("ScrollFrame", "ZooListScrollFrame", ZooListFrame)
ZooListScrollFrame:SetPoint("TOPLEFT", 4, -7)
ZooListScrollFrame:SetPoint("BOTTOMRIGHT", 4, 4)
ZooListScrollFrame:SetWidth(320)
ZooListScrollFrame:SetHeight(330)

local ZooListScrollBar = CreateFrame("Slider", nil, ZooListScrollFrame, "UIPanelScrollBarTemplate")
ZooListScrollBar:SetPoint("TOPRIGHT", ZooListFrame, "TOPRIGHT", 0, -20)
ZooListScrollBar:SetPoint("BOTTOMRIGHT", ZooListFrame, "BOTTOMRIGHT", 0, 19)
ZooListScrollBar:SetMinMaxValues(0, 0)
ZooListScrollBar:SetValueStep(20)
ZooListScrollBar.scrollStep = 1
ZooListScrollBar:SetValue(0)
ZooListScrollBar:SetWidth(16)
ZooListScrollBar:SetScript("OnValueChanged", function(self, value)
	local scrollBarMin, scrollBarMax = ZooListScrollBar:GetMinMaxValues()
	if ZooListScrollBar:GetValue() == scrollBarMin then
		ZooListScrollFrameScrollUpButton:Disable()
	elseif ZooListScrollFrameScrollUpButton:IsEnabled() == 0 then
		ZooListScrollFrameScrollUpButton:Enable()
	end
	if ZooListScrollBar:GetValue() == scrollBarMax then
		ZooListScrollFrameScrollDownButton:Disable()
	elseif ZooListScrollFrameScrollDownButton:IsEnabled() == 0 then
		ZooListScrollFrameScrollDownButton:Enable()
	end
	self:GetParent():SetVerticalScroll(value)
end)
ZooListScrollFrameScrollUpButton:Disable()
ZooListScrollFrameScrollUpButton:SetScript("OnClick", function()
	ZooListScrollBar:SetValue(ZooListScrollBar:GetValue() - 20)
	PlaySound("UChatScrollButton")
end)
ZooListScrollFrameScrollDownButton:Disable()
ZooListScrollFrameScrollDownButton:SetScript("OnClick", function()
	ZooListScrollBar:SetValue(ZooListScrollBar:GetValue() + 20)
	PlaySound("UChatScrollButton")
end)
ZooListScrollFrame:EnableMouseWheel(true)
ZooListScrollFrame:SetScript("OnMouseWheel", function(self, delta)
	local scrollBarMin, scrollBarMax = ZooListScrollBar:GetMinMaxValues()
	if delta < 0 and ZooListScrollBar:GetValue() < scrollBarMax then
		ZooListScrollBar:SetValue(ZooListScrollBar:GetValue() + 20)
	elseif delta > 0 and ZooListScrollBar:GetValue() > scrollBarMin then
		ZooListScrollBar:SetValue(ZooListScrollBar:GetValue() - 20)
	end
end)

local ZooListContentFrame = CreateFrame("Frame", "ZooListContentFrame", ZooListScrollFrame)
ZooListContentFrame:SetWidth(320)
ZooListContentFrame:SetHeight(330)
ZooListScrollFrame:SetScrollChild(ZooListContentFrame)

-- Bottom frames
local ZooBottomLine = ZooFrame:CreateTexture()
ZooBottomLine:SetPoint("BOTTOMLEFT", 4, 28)
ZooBottomLine:SetWidth(318)
ZooBottomLine:SetHeight(3)
ZooBottomLine:SetTexture(0.1, 0.1, 0.1)

local ZooCaptureButton = CreateFrame("Button", "ZooCaptureButton", ZooFrame)
ZooCaptureButton:SetPoint("BOTTOMLEFT", 15, 6)
ZooCaptureButton:SetWidth(110)
ZooCaptureButton:SetHeight(20)
ZooCaptureButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
local ZooCaptureFont = ZooFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
ZooCaptureFont:SetPoint("BOTTOMLEFT", 19, 11)
ZooCaptureFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
ZooCaptureFont:SetText("|cffff4500Capture an ape")

local ZooBananaButton = CreateFrame("Button", "ZooBananaButton", ZooFrame)
ZooBananaButton:SetPoint("BOTTOMLEFT", 130, 6)
ZooBananaButton:SetWidth(110)
ZooBananaButton:SetHeight(20)
ZooBananaButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
local ZooBananaFont = ZooFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
ZooBananaFont:SetPoint("BOTTOMLEFT", 134, 11)
ZooBananaFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
ZooBananaFont:SetText("|cfff0e68cThrow a banana")

local ZooReleaseButton = CreateFrame("Button", "ZooReleaseButton", ZooFrame)
ZooReleaseButton:SetPoint("BOTTOMLEFT", 245, 6)
ZooReleaseButton:SetWidth(60)
ZooReleaseButton:SetHeight(20)
ZooReleaseButton:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
local ZooReleaseFont = ZooFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
ZooReleaseFont:SetPoint("BOTTOMLEFT", 249, 11)
ZooReleaseFont:SetFont("Fonts\\FRIZQT__.TTF", 13)
ZooReleaseFont:SetText("|cffadff2fRelease")

-- Non-matrix rotation function (authored by Maldivia from WoWWiki, 2008)
local s2 = sqrt(2)
local cos, sin, rad = math.cos, math.sin, math.rad
local function CalculateCorner(angle)
	local r = rad(angle)
	return 0.5 + cos(r) / s2, 0.5 + sin(r) / s2
end
local function RotateTexture(texture, angle)
	local LRx, LRy = CalculateCorner(angle + 45)
	local LLx, LLy = CalculateCorner(angle + 135)
	local ULx, ULy = CalculateCorner(angle + 225)
	local URx, URy = CalculateCorner(angle - 45)
	texture:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
end

-- Filtering function
local function ZooFilter(self, event, arg1, ...)
	for i, value in pairs(zooTable) do
		if arg2 == value and arg6 ~= "GM" then
			return true
		end
	end
end

-- Listing function
local zooSelection = 0
local function ZooListing()
	for i,value in pairs(zooTable) do
		if _G["ZooListButton"..i] == nil then
			_G["ZooListButton"..i] = CreateFrame("Button", "ZooListButton"..i, ZooListContentFrame, "FriendsFrameIgnoreButtonTemplate")
			_G["ZooListButton"..i]:SetPoint("TOPLEFT", 0, -20 * (i-1))
			_G["ZooListButton"..i]:SetWidth(300)
			_G["ZooListButton"..i]:SetHeight(20)
			_G["ZooListFont"..i] = ZooListContentFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			_G["ZooListFont"..i]:SetPoint("LEFT", _G["ZooListButton"..i], 20, 0)
			_G["ZooListFont"..i]:SetTextColor(1, 0.82, 0)
			_G["ZooListButton"..i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
			_G["ZooListButton"..i]:SetScript("OnClick", function()
				PlaySound("igMainMenuOptionCheckBoxOn")
				for k=1,#zooTable do
					if k == tonumber(select(3, strfind(_G["ZooListButton"..i]:GetName(), "(%d+)"))) then
						_G["ZooListButton"..i]:LockHighlight()
						zooSelection = i
					else
						_G["ZooListButton"..k]:UnlockHighlight()
					end
				end
			end)
		end
		_G["ZooListFont"..i]:SetText(value)
		_G["ZooListButton"..i]:Show()
		if i == #zooTable then
			ZooListScrollBar:SetMinMaxValues(0, max(0,(i-16)*20))
			if i > 16 then
				ZooListScrollBar:Show()
				ZooListScrollFrameScrollDownButton:Enable()
			else
				ZooListScrollFrameScrollDownButton:Disable()
				ZooListScrollBar:Hide()
			end
		end
	end
end

-- Saved settings
local ZooSavedSettings = CreateFrame("Frame")
ZooSavedSettings:Hide()
ZooSavedSettings:RegisterEvent("ADDON_LOADED")
ZooSavedSettings:RegisterEvent("PLAYER_LOGIN")
ZooSavedSettings:SetScript("OnEvent", function(self, event, arg1, ...)
	if (event == "ADDON_LOADED" and arg1 == "ZooKeeper") or event == "PLAYER_LOGIN" then
		ZooSavedSettings:UnregisterEvent("ADDON_LOADED")
		ZooSavedSettings:UnregisterEvent("PLAYER_LOGIN")
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", ZooFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", ZooFilter)
		if zooTable == nil or #zooTable == 0 then
			zooTable = {}
		else
			ZooListing()
		end
		DEFAULT_CHAT_FRAME:AddMessage("|TInterface\\AddOns\\ZooKeeper\\monkey1:20|t |cfff0e68c[ZooKeeper]: The zoo is ready to welcome filthy animals.|r |TInterface\\AddOns\\ZooKeeper\\monkey2:20|t")
	end
end)

-- PLAYER and FRIEND dropdown menus
local apeCaptured = 0
UnitPopupButtons["ZOO_BUTTON"] = { text = "|cffff4500Capture", dist = 0 }
table.insert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"]-1, "ZOO_BUTTON")
table.insert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"]-1, "ZOO_BUTTON")
hooksecurefunc("UnitPopup_ShowMenu", function(dropdownMenu, which)
	if which == "FRIEND" or which == "PLAYER" then
		for i, v in pairs(zooTable) do
			if v == DropDownList1Button1:GetText() then
				apeCaptured = 1
				break
			elseif i == #zooTable then
				apeCaptured = 0
			end
		end
		for k =2,20 do
			if _G["DropDownList1Button"..k] ~= nil and (_G["DropDownList1Button"..k]:GetText() == "|cffff4500Capture" or _G["DropDownList1Button"..k]:GetText() == "|cffadff2fRelease") then
				if #zooTable == 0 or apeCaptured == 0 then
					_G["DropDownList1Button"..k]:SetText("|cffff4500Capture")
				elseif apeCaptured == 1 then
					_G["DropDownList1Button"..k]:SetText("|cffadff2fRelease")
				end
				break
			end
		end
	end
end)
hooksecurefunc("UnitPopup_OnClick", function()
	if this.value == "ZOO_BUTTON" then
		if apeCaptured == 0 or #zooTable == 0 then
			if #zooTable == 0 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffff4500"..DropDownList1Button1:GetText().." has been captured, our first ape! Throw him a banana!")
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cffff4500"..DropDownList1Button1:GetText().." has been added to your collection.")
			end
			tinsert(zooTable, DropDownList1Button1:GetText())
			sort(zooTable)
			ZooListing()
			PlaySound("GorillaStand3")
		else
			for i, value in pairs(zooTable) do
				if value == DropDownList1Button1:GetText() then
					DEFAULT_CHAT_FRAME:AddMessage("|cffadff2f"..DropDownList1Button1:GetText().." escaped the zoo.")
					for j,k in pairs(zooTable) do
						_G["ZooListButton"..j]:UnlockHighlight()
						_G["ZooListButton"..j]:SetText("")
						_G["ZooListFont"..j]:SetText("")
						_G["ZooListButton"..j]:Hide()
						if j == #zooTable then
							tremove(zooTable, i)
							zooSelection = 0
							sort(zooTable)
							ZooListing()
						end
					end
					break
				end
			end
			PlaySound("GorillaWound")
		end
	end
end)

-- Access button scripts
local friendsCurrentFrame = 0
ZooButton:SetScript("OnEnter", function()
	RotateTexture(ZooButtonTexture, 45)
end)
ZooButton:SetScript("OnLeave", function()
	ZooButtonTexture:SetTexCoord(0, 1, 0, 1)
end)
ZooButton:SetScript("OnMouseDown", function()
	if ZooFrame:IsShown() then
		ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	else
		ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey2")
	end
end)
ZooButton:SetScript("OnMouseUp", function(self, button)
	if ZooFrame:IsShown() then
		ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey2")
	else
		ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	end
end)
ZooButton:SetScript("OnClick", function(self, button)
	if ZooFrame:IsShown() then
		ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
		ZooFrame:Hide()
		if friendsCurrentFrame == 1 then
			FriendsListFrame:Show()
			FriendsFrameTitleText:SetText("Friends List")
		else
			IgnoreListFrame:Show()
			FriendsFrameTitleText:SetText("Ignore List")
		end
		PlaySound("igAbilityClose")
	else
		ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey2")
		FriendsFrameTitleText:SetText("Ape List")
		ZooFrame:Show()
		ZooListing()
		if #zooTable > 16 then
			ZooListScrollBar:Show()
		else
			ZooListScrollBar:Hide()
		end
		if friendsCurrentFrame == 1 then
			FriendsListFrame:Hide()
		else
			IgnoreListFrame:Hide()
		end
		PlaySound("igAbilityOpen")
	end
end)
FriendsFrame:HookScript("OnHide", function()
	ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	ZooFrame:Hide()
end)
FriendsListFrame:SetScript("OnShow", function()
	friendsCurrentFrame = 1
	if not ZooButton:IsShown() then
		ZooButton:Show()
	end
end)
FriendsListFrame:SetScript("OnHide", function()
	if not IgnoreListFrame:IsShown() and not ZooFrame:IsShown() then
		ZooButton:Hide()
	end
end)
IgnoreListFrame:SetScript("OnShow", function()
	friendsCurrentFrame = 2
	if not ZooButton:IsShown() then
		ZooButton:Show()
	end
end)
IgnoreListFrame:SetScript("OnHide", function()
	if not FriendsListFrame:IsShown() and not ZooFrame:IsShown() then
		ZooButton:Hide()
	end
end)
WhoFrame:HookScript("OnShow", function()
	ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	ZooFrame:Hide()
	ZooButton:Hide()
end)
GuildFrame:HookScript("OnShow", function()
	ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	ZooFrame:Hide()
	ZooButton:Hide()
end)
ChannelFrame:HookScript("OnShow", function()
	ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	ZooFrame:Hide()
	ZooButton:Hide()
end)
RaidFrame:HookScript("OnShow", function()
	ZooButtonTexture:SetTexture("Interface\\AddOns\\ZooKeeper\\monkey1")
	ZooFrame:Hide()
	ZooButton:Hide()
end)

-- Bottom buttons scripts
StaticPopupDialogs["ADDMONKEY_POPUP"] = {
	text = "Ape's name:",
	button1 = "Add",
	button2 = "Cancel",
	OnShow = function()
		StaticPopup1EditBox:SetText("")
	end,
	OnAccept = function()
		if StaticPopup1EditBox:GetText() ~= "" then
			if #zooTable == 0 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffff4500"..StaticPopup1EditBox:GetText().." has been captured, our first ape! Throw him a banana!")
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cffff4500"..StaticPopup1EditBox:GetText().." has been added to your collection.")
			end
			tinsert(zooTable, StaticPopup1EditBox:GetText())
			sort(zooTable)
			ZooListing()
			PlaySound("GorillaStand3")
		end
	end,
	EditBoxOnEnterPressed = function()
		if StaticPopup1EditBox:GetText() ~= "" then
			if #zooTable == 0 then
				DEFAULT_CHAT_FRAME:AddMessage("|cffff4500"..StaticPopup1EditBox:GetText().." has been captured, our first ape! Throw him a banana!")
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cffff4500"..StaticPopup1EditBox:GetText().." has been added to your collection.")
			end
			tinsert(zooTable, StaticPopup1EditBox:GetText())
			sort(zooTable)
			ZooListing()
			PlaySound("GorillaStand3")
			StaticPopup_Hide("ADDMONKEY_POPUP")
		end
	end,
	EditBoxOnEscapePressed = function()
		StaticPopup_Hide("ADDMONKEY_POPUP")
	end,
	exclusive = 1,
	hasEditBox = 1,
	hideOnEscape = 1,
	timeout = 0,
	whileDead = 1,
}
ZooCaptureButton:SetScript("OnClick", function()
	StaticPopup_Show ("ADDMONKEY_POPUP")
end)
ZooBananaButton:SetScript("OnClick", function()
	for i,value in pairs(zooTable) do
		if zooSelection ~= 0 and i == zooSelection then
			SendChatMessage("throws a banana at "..value..".", "EMOTE")
			PlaySound("GorillaAggro")
			break
		end
	end
end)
ZooReleaseButton:SetScript("OnClick", function()
	if zooSelection ~= 0 and zooTable[zooSelection] ~= nil then
		DEFAULT_CHAT_FRAME:AddMessage("|cffadff2f"..zooTable[zooSelection].." escaped the zoo.")
		_G["ZooListButton"..zooSelection]:UnlockHighlight()
		for i,value in pairs(zooTable) do
			_G["ZooListButton"..i]:SetText("")
			_G["ZooListFont"..i]:SetText("")
			_G["ZooListButton"..i]:Hide()
		end
		tremove(zooTable, zooSelection)
		zooSelection = 0
		sort(zooTable)
		ZooListing()
		PlaySound("GorillaWound")
	end
end)