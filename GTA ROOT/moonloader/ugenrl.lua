__name__	= 'ULTIMATE GENRL'
__version__ = '1.3.2'
__author__	= 'lay3r'

local inicfg = require 'inicfg'
local lfs = require 'lfs'
local imgui = require 'imgui'
local memory = require "memory"
local weaponSoundDelay = {[9] = 200, [37] = 900}

local soundsDir = 'moonloader/resource/ugenrl/'
local settingsFile = 'ugenrl.ini'

settings = inicfg.load({
	main =
		{
			enable = false,
			weapon = true,
			enemyWeapon = true,
			enemyWeaponDist = 70,
			hit = true,
			pain = true,
			notifications = true
		},
	volume =
		{
			weapon = 0.80,
			hit = 0.80,
			pain = 0.80
		},
	sounds =
		{
			[22] = '9mm.mp3',
			[23] = 'Sdpistol.mp3',
			[24] = 'Deagle.1.mp3',
			[25] = 'Shotgun.1.mp3',
			[26] = 'Sawnoff-Shotgun.mp3',
			[27] = 'Combat-Shotgun.mp3',
			[28] = 'Uzi.mp3',
			[29] = 'MP5.mp3',
			[30] = 'AK-47.mp3',
			[31] = 'M4.1.mp3',
			[32] = 'TEC-9.mp3',
			[33] = 'Rifle.mp3',
			[34] = 'Sniper.mp3',
			hit = 'Hit.1.mp3',
			pain = 'Pain.1.mp3'
		}
}, settingsFile)
if not doesFileExist('moonloader/config/'..settingsFile) then inicfg.save(settings, settingsFile) end

function onSystemInitialized()
	memory.setfloat(11926728, 1.0, false) -- Gorskin
 end

function getListOfSounds(name)
	local soundFiles = {}
	for line in lfs.dir(soundsDir) do
		if line:match(name) then
			soundFiles[#soundFiles+1] = line
		end
	end
	return soundFiles
end

function loadSounds()
	deagleSounds = getListOfSounds('Deagle')
	shotgunSounds = getListOfSounds('Shotgun')
	m4Sounds = getListOfSounds('M4')
	hitSounds = getListOfSounds('Hit')
	painSounds = getListOfSounds('Pain')
end


function offSound(bool)
	if bool then 
		callFunction(0x507430, 0, 0)
		writeMemory(0x507750, 1, 0xC3, true)
		local bs = raknetNewBitStream()
		raknetEmulRpcReceiveBitStream(42, bs)
		raknetDeleteBitStream(bs)
	else
		callFunction(0x507440, 0, 0)
		writeMemory(0x507750, 1, 86, true)
	end
end

local show_main_window = imgui.ImBool(false)
local show_main_settings = imgui.ImBool(false)
local check_for_updates = imgui.ImBool(false)
local enable_checkbox = imgui.ImBool(settings.main.enable)
local weapon_checkbox = imgui.ImBool(settings.main.weapon)
local enemyweapon_checkbox = imgui.ImBool(settings.main.enemyWeapon)
local hit_checkbox = imgui.ImBool(settings.main.hit)
local pain_checkbox = imgui.ImBool(settings.main.pain)
local notifications_checkbox = imgui.ImBool(settings.main.notifications)
local weapon_volume_slider = imgui.ImFloat(settings.volume.weapon)
local hit_volume_slider = imgui.ImFloat(settings.volume.hit)
local pain_volume_slider = imgui.ImFloat(settings.volume.pain)
local enemyweapon_dist = imgui.ImInt(settings.main.enemyWeaponDist)
local deagle_selected = imgui.ImInt(-1)
local shotgun_selected = imgui.ImInt(-1)
local m4_selected = imgui.ImInt(-1)
local hit_selected = imgui.ImInt(-1)
local pain_selected = imgui.ImInt(-1)

function switchMainSettings(name)
    settings.main[name] = not settings.main[name]
	if name == 'enable' then offSound(settings.main[name]) end
	inicfg.save(settings, settingsFile)
end

function changeSound(id, name)
	playSound(name, settings.volume.weapon)
	settings.sounds[id] = name
	inicfg.save(settings, settingsFile)
end

function imgui.OnDrawFrame()
	if show_main_window.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(320, 160), imgui.Cond.FirstUseEver)
		imgui.Begin(string.upper(__name__), show_main_window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		if imgui.Checkbox('Enable', enable_checkbox) then
			switchMainSettings('enable')
		end
		if enable_checkbox.v then
			imgui.SameLine()
			imgui.SetCursorPos(imgui.ImVec2(210, 28))
			if imgui.Button('Forum', check_for_updates) then
				os.execute(('explorer.exe "%s"'):format('https://blast.hk/threads/53959/'))
			end
			imgui.SetCursorPos(imgui.ImVec2(260, 28))
			if imgui.Button('Settings', show_main_settings) then
				imgui.OpenPopup('#Settings')
			end
			if imgui.BeginPopup('#Settings') then 
				if imgui.BeginMenu('Sounds') then
					if imgui.BeginMenu('Deagle ('..settings.sounds[24]..')') then
						if imgui.ListBox('##listbox0', deagle_selected, deagleSounds, 20) then
							changeSound(24, deagleSounds[deagle_selected.v+1])
						end
						imgui.EndMenu()
					end
					if imgui.BeginMenu('Shotgun ('..settings.sounds[25]..')') then
						if imgui.ListBox('##listbox1', shotgun_selected, shotgunSounds, 20) then
							changeSound(25, shotgunSounds[shotgun_selected.v+1])
						end
						imgui.EndMenu()
					end
					if imgui.BeginMenu('M4 ('..settings.sounds[31]..')') then
						if imgui.ListBox('##listbox2', m4_selected, m4Sounds, 20) then
							changeSound(31, m4Sounds[m4_selected.v+1])
						end
						imgui.EndMenu()
					end
					if imgui.BeginMenu('Hit ('..settings.sounds.hit..')') then
						if imgui.ListBox('##listbox3', hit_selected, hitSounds, 20) then
							changeSound('hit', hitSounds[hit_selected.v+1])
						end
						imgui.EndMenu()
					end
					if imgui.BeginMenu('Pain ('..settings.sounds.pain..')') then
						if imgui.ListBox('##listbox4', pain_selected, painSounds, 20) then
							changeSound('pain', painSounds[pain_selected.v+1])
						end
						imgui.EndMenu()
					end
					imgui.EndMenu()
				end
				if imgui.BeginMenu('Volume') then
					imgui.Text('Weapon')
					if imgui.SliderFloat('##sliderfloat0', weapon_volume_slider, 0.00, 1.00, '%.2f') then
						settings.volume.weapon = weapon_volume_slider.v
						inicfg.save(settings, settingsFile)
					end
					imgui.Text('Hit')
					if imgui.SliderFloat('##sliderfloat1', hit_volume_slider, 0.00, 1.00, '%.2f') then
						settings.volume.hit = hit_volume_slider.v
						inicfg.save(settings, settingsFile)
					end
					imgui.Text('Pain')
					if imgui.SliderFloat('##sliderfloat2', pain_volume_slider, 0.00, 1.00, '%.2f') then
						settings.volume.pain = pain_volume_slider.v
						inicfg.save(settings, settingsFile)
					end
					imgui.EndMenu()
				end
				if imgui.BeginMenu('Other') then
					imgui.Text('Range of Enemy Weapon')
					if imgui.SliderInt('##sliderint0', enemyweapon_dist, 0, 100) then
						settings.main.enemyWeaponDist = enemyweapon_dist.v
						inicfg.save(settings, settingsFile)
					end
					if imgui.Checkbox('Notifications', notifications_checkbox) then
						switchMainSettings('notifications')
					end
					imgui.EndMenu()
				end
				imgui.EndPopup()
			end
			if imgui.Checkbox('Weapon', weapon_checkbox) then
				switchMainSettings('weapon')
			end
			if weapon_checkbox.v then
				if imgui.Checkbox('Enemy Weapon', enemyweapon_checkbox) then
					switchMainSettings('enemyWeapon')
				end
			end
			if imgui.Checkbox('Hit', hit_checkbox) then
				switchMainSettings('hit')
			end
			if imgui.Checkbox('Pain', pain_checkbox) then
				switchMainSettings('pain')
			end
			imgui.SameLine()
			imgui.SetCursorPos(imgui.ImVec2(285, 125))
			imgui.TextDisabled('Info')
			if imgui.IsItemHovered() then
				imgui.BeginTooltip()
				imgui.PushTextWrapPos(450)
				imgui.TextUnformatted('Author: '..__author__..'\nVersion: '..__version__)
				imgui.PopTextWrapPos()
				imgui.EndTooltip()
			end
		end
		imgui.End()
	end
end

function chatMessage(text)
		sampAddChatMessage('{ff4747}['..string.upper(__name__)..']  {d5dedd}'..text, -1)
end

function printMessage(text)
	if settings.main.notifications then 	
		printStringNow(text, 2000) 
	end
end

function main()
	loadSounds()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
	if settings.main.enable then offSound(true) end
	sampRegisterChatCommand('ugs', function() show_main_window.v = not show_main_window.v end)
	while true do
		wait(0)
		if isKeyDown(18) and isKeyJustPressed(85) and not show_main_window.v then
			switchMainSettings('enable')
			enable_checkbox = imgui.ImBool(settings.main.enable)
			if settings.main.enable then
				printMessage(__name__..' is ~g~ON')
			else
				printMessage(__name__..' is ~r~OFF')
			end
		end	
		imgui.Process = show_main_window.v
		if settings.main.enable and sampIsLocalPlayerSpawned() then
			if settings.main.weapon then
				if isCharShooting(PLAYER_PED) then
					playSound(settings.sounds[getCurrentCharWeapon(PLAYER_PED)], settings.volume.weapon)
				end
				if settings.main.enemyWeapon then
					local myX, myY, myZ = getCharCoordinates(PLAYER_PED)
					repeat
						local hasFoundChars, randomCharHandle = findAllRandomCharsInSphere(myX, myY, myZ, settings.main.enemyWeaponDist, true, true)			
						if hasFoundChars and isCharShooting(randomCharHandle) then
							playSound(settings.sounds[getCurrentCharWeapon(randomCharHandle)], settings.volume.weapon, randomCharHandle)
						end
					until not hasFoundChars
				end
			end
			if playPain then
				playSound(settings.sounds.pain, settings.volume.pain)
				playPain = false
				if weaponSoundDelay[dmgWeaponId] then wait(weaponSoundDelay[dmgWeaponId]) end
			end
			if playHit then
				playSound(settings.sounds.hit, settings.volume.hit)
				playHit = false
				if weaponSoundDelay[dmgWeaponId] then wait(weaponSoundDelay[dmgWeaponId]) end
			end
		end
	end
end

function playSound(soundFile, soundVol, charHandle)
	if not soundFile or not doesFileExist(soundsDir..soundFile) then 
		chatMessage("���� " .. soundFile .. " �� ������, ���� ��������. ({47ff72}{ff4747}'/ugs' {47ff72}��� ��������� �������{d5dedd})")
		return false 
	end
	if audio then collectgarbage() end
	if charHandle == nil then
		audio = loadAudioStream(soundsDir..soundFile)
	else
		audio = load3dAudioStream(soundsDir..soundFile) 
		setPlay3dAudioStreamAtChar(audio, charHandle)
	end
	setAudioStreamVolume(audio, soundVol)
	setAudioStreamState(audio, 1)
	clearSound(audio)
end

function clearSound(audio)
	lua_thread.create(function()
		while getAudioStreamState(audio) == 1 do wait(50) end
		collectgarbage()
	end)
end

function onSendRpc(id, bs, priority, reliability, orderingChannel, shiftTs)
	if settings.main.enable then
		if id == 115 then
			local act = raknetBitStreamReadBool(bs)
			dmgId = raknetBitStreamReadInt16(bs)
			dmgValue = raknetBitStreamReadFloat(bs)
			dmgWeaponId = raknetBitStreamReadInt32(bs)
			dmgBodypart = raknetBitStreamReadInt32(bs)
			if settings.main.pain and act then 
				playPain = true 
			end
			if settings.main.hit and not act then 
				playHit = true 
			end
		end
	end
end

function onReceiveRpc(id, bs)
	if id == 41 then
		if settings.main.enable then
			return false
		end
	end
end

function theme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
theme()

function onScriptTerminate(script, quitGame)
	if script == thisScript() and not quitGame then
		offSound(false)
		printMessage(__name__..' is ~r~OFF')
		chatMessage('{ffaf47}Script is dead.')
	end
end