script_name('Connect Tool')
script_author('kopnev') -- 3.1 fix by kichiro
script_version('3.1')
script_version_number(300)

local sampev   = require 'lib.samp.events'
local inicfg   = require 'inicfg'
local encoding = require 'encoding'
--local request  = require('lib.requests')
local memory   = require 'memory'
local dlstatus = require('moonloader').download_status
local effil    = require 'effil'
local band     = bit.band

------------------------NEW-----------------
local limgui, imgui 	= pcall(require, 'imgui')
local limadd, imadd 	= pcall(require, 'imgui_addons')
local lrkeys, rkeys 	= pcall(require, 'rkeys')
local lfa, fa 			= pcall(require, 'faIcons')
local lsha1, sha1 		= pcall(require, 'sha1') -- gauth
local lbasexx, basexx 	= pcall(require, 'basexx') -- gauth
----------------------------------------------


encoding.default = 'CP1251'
u8 = encoding.UTF8

local fa_font = nil
dev = false
sampasi = false

local bindmode = 1
local selacc = -1
local gcode = 0
local xuypoimidlyachecgo = 0
local ReconTimer = false
local potok = false
local invisible = {
	v = false
}

local servers = {
    false,
}

local serv = {
	{
		projectname = "Arizona Role Play",
		title = "Arizona RP",
		list = {
			{
				name = "Phoenix",
				ip = "185.169.134.3",
				port = "7777"
			},
			{
				name = "Tucson",
				ip = "185.169.134.4",
				port = "7777"
			},
			{
				name = "Scottdale",
				ip = "185.169.134.43",
				port = "7777"
			},
			{
				name = "Chandler",
				ip = "185.169.134.44",
				port = "7777"
			},
			{
				name = "Brainburg",
			  	ip = "185.169.134.45",
				port = "7777"
			},
			{
				name = "Saint Rose",
			  	ip = "185.169.134.5",
				port = "7777"
			},
			{
				name = "Mesa",
			  	ip = "185.169.134.59",
				port = "7777"
			},
			{
				name = "Red-Rock",
			  	ip = "185.169.134.61",
				port = "7777"
			},
			{
				name = "Yuma",
			  	ip = "185.169.134.107",
				port = "7777"
			},
			{
				name = "Surprise",
			  	ip 	= "185.169.134.109",
				port = "7777"
			},
			{
				name = "Prescott",
			  	ip 	= "185.169.134.166",
				port = "7777"
			},
		},
	},

	{
		projectname = "Advance Role Play",
		title = "Advance RP",
		list = {
			{
				name = "Red",
				ip = "54.37.142.72",
				port = "7777",
			},
			{
				name = "Green",
				ip = "54.37.142.73",
				port = "7777",
			},
			{
				name = "Blue",
				ip = "54.37.142.74",
				port = "7777",
			},
		},
	},

	{
		projectname = "Diamond Role Play", -- �������� �������
		title = "Diamond RP",              -- ����������� ��������
		list = {        									 -- ������� �������
			{
				name = 'Emerald',
				ip = 'emerald.diamondrp.ru',
				port = "7777",
			},
			{
				name = 'Trilliant',
				ip = 'trilliant.diamondrp.ru',
				port = "7777",
			},
			{
				name = 'Crystal',
				ip = 'crystal.diamondrp.ru',
				port = "7777",
			},
			{
				name = 'Sapphire',
				ip = 'sapphire.diamondrp.ru',
				port = "7777",
			},
			{
				name = 'Amber',
				ip = 'amber.diamondrp.ru',
				port = "7777",
			},
			{
				name = 'Ruby',
				ip = 'ruby.diamondrp.ru',
				port = "7777",
			},
		},
	},


	{
 		projectname = "Evolve Role Play", -- �������� �������
 		title = "Evolve RP",              -- ����������� ��������
 		list = {        									 -- ������� �������
				{
					name = 'First',
					ip = '185.169.134.67',
					port = "7777",
				},
				{
					name = 'Second',
					ip = '185.169.134.68',
					port = "7777",
				},
				{
					name = 'Third',
					ip = '185.169.134.91',
					port = "7777",
				}
 		},
	},
	 
	{
		projectname = "Samp Role Play", -- �������� �������
		title = "Samp RP",              -- ����������� ��������
		list = {        									 -- ������� �������
			   {
				   name = '02',
				   ip = '185.169.134.20',
				   port = "7777",
			   },
			   {
				   name = 'Revolution',
				   ip = '185.169.134.11',
				   port = "7777",
			   },
			   {
				   name = 'Reborn',
				   ip = '185.169.134.34',
				   port = "7777",
			   },
			   {
				   name = 'Legacy',
				   ip = '185.169.134.22',
				   port = "7773",
			   }
		},
	},

	{
 		projectname = "Monser DeathMatch", -- �������� �������
 		title = "Monser DM",              -- ����������� ��������
 		list = {        									 -- ������� �������
				{
					name = 'One',
					ip = '176.32.37.37',
					port = "7777",
				},
				{
					name = 'Two',
					ip = '176.32.39.185',
					port = "7777",
				},
				{
					name = 'Three',
					ip = '176.32.36.229',
					port = "7777",
				}
 		},
 	},


	{
 		projectname = "Trinity GTA", -- �������� �������
 		title = "Trinity GTA",              -- ����������� ��������
 		list = {        									 -- ������� �������
				{
					name = 'RPG',
					ip = '185.169.134.83',
					port = "7777",
				},
				{
					name = 'RP1',
					ip = '185.169.134.84',
					port = "7777",
				},
				{
					name = 'RP2',
					ip = '185.169.134.85',
					port = "7777",
				}
		},
	},
	 
	{
		projectname = "Revent Role Play", -- �������� �������
		title = "Revent RP",              -- ����������� ��������
		list = {        									 -- ������� �������
			   {
				   name = 'First',
				   ip = '213.32.112.224',
				   port = "7777",
			   }
		},
	},

  --[[--------------------�������� �� ������ 2.88--------------------------------
  --------------------------------������-----------------------------------------
  -------------------------------------------------------------------------------
  	{
 		projectname = "Advance Role Play", -- �������� �������
 		title = "Advance RP",              -- ����������� ��������
 		list = {        									 -- ������� �������
 			{
 				name = "Red",         -- ��� �������
 				ip = "5.254.104.131", -- �� �������
 				port = "7777",	      -- ���� �������
 			},
 			{
 				name = "Green",
 				ip = "5.254.104.132",
 				port = "7777",
 			},
 		},
 	},
   -------------------------------------------------------------------------------
   -------------------------------------------------------------------------------
   --------------------------------------------------------------------------]]---

   -------------------------------------------------------------------------------
   --��������� ��� ������ 2.9+ :
   --����� ������� ����������� �� ����� ������� ���, ����� � ��� ������� ������
   --��������� ����� � ������ (CTRL+F) �������: " downloadUrlToFile("https://api.kscripts.ru/getlistservers.php", "moonloader/config/KopnevScripts/servers.ctool") "
   --� ������� ��. (��������! ���� ������� 2 �����. ��������� ������� ��� ���)
   --��������! �������������� ������ ��������, ���������� ��������
   --��� ���������� �������� ��������� ��� ��� ���� ������ 
}

local customServ = {}

local chars = {
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
}

local ipserv = {}

function genCode(skey)
	if lbasexx and lsha1 then
		skey = basexx.from_base32(skey)
		value = math.floor(os.time() / 30)
		value = string.char(
		0, 0, 0, 0,
		band(value, 0xFF000000) / 0x1000000,
		band(value, 0xFF0000) / 0x10000,
		band(value, 0xFF00) / 0x100,
		band(value, 0xFF))
		local hash = sha1.hmac_binary(skey, value)
		local offset = band(hash:sub(-1):byte(1, 1), 0xF)
		local function bytesToInt(a,b,c,d)
			return a*0x1000000 + b*0x10000 + c*0x100 + d
		end
		hash = bytesToInt(hash:byte(offset + 1, offset + 4))
		hash = band(hash, 0x7FFFFFFF) % 1000000
		return ('%06d'):format(hash)
	end
end

checkpass = false
checkbank = false
regstape = false
gou = false
recon = false

local accounts = {
	{
		user_name         = 'Nick_Name',
		user_password     = '123456',
		server_ip         = '185.169.134.3',
		server_port       = '7777',
		gauth             = "nil",
		code              = "nil",
	}
}

local def = {
	settings = {
		theme = 7,
		style = 1,
		srvn = 0,
		spass = false,
		fastconnect = true,
		key1 = 120,
		autopass = true,
		autogcode = true,
		autocode = true,
		uahungry = false,
		hungry = false,
		b_loop = false,
		d_loop = 350,
		helptext = true,
		vkladka = 5,
		reload = false,
		reloadR = false,
		bg = false,
		reload = false,
		typeent = 0,
		cmdent = "/log",
		invisible = false,
		redelay = 1000,
		reconifkick = false,
		redelayifkick = 300,
	},
	bind = {
		recon = 0,
		reconcmd = "",
		name = 1,
		namecmd = "name",
		dis = 0,
		discmd = "",
		accOne = 0,
		accOnecmd = "",
		accTwo = 0,
		accTwocmd = "",
		accThree = 0,
		accThreecmd = "",
		accFour = 0,
		accFourcmd = "",
		accFive = 0,
		accFivecmd = "",
	}
}

local directIni = "KopnevScripts\\Connect Tool.ini"

local ini = inicfg.load(def, directIni)

if limgui then 
	fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
	rename = imgui.ImBuffer(64)
	reip = imgui.ImBuffer(128)
	report = imgui.ImBuffer(16)

	reconifkick = imgui.ImBool(ini.settings.reconifkick)
	redelayifkick = imgui.ImInt(ini.settings.redelayifkick)
	redelay = imgui.ImInt(ini.settings.redelay)

	tema = imgui.ImInt(ini.settings.theme)
	style = imgui.ImInt(ini.settings.style)
	srvn = imgui.ImInt(ini.settings.srvn)
	spass = imgui.ImBool(ini.settings.spass)
	fastconnect = imgui.ImBool(ini.settings.fastconnect)

	autopass = imgui.ImBool(ini.settings.autopass)
	autogcode = imgui.ImBool(ini.settings.autogcode)
	autocode = imgui.ImBool(ini.settings.autocode)

	bg = imgui.ImBool(ini.settings.bg)
	typeent = imgui.ImInt(ini.settings.typeent)
	cmdent = imgui.ImBuffer(ini.settings.cmdent, 32)
	invisible = imgui.ImBool(ini.settings.invisible)

	reconb = imgui.ImInt(ini.bind.recon)
	reconcmd = imgui.ImBuffer(ini.bind.reconcmd, 64) 

	nameb = imgui.ImInt(ini.bind.name)
	namecmd = imgui.ImBuffer(ini.bind.namecmd, 64) 

	disb = imgui.ImInt(ini.bind.dis)
	discmd = imgui.ImBuffer(ini.bind.discmd, 64) 

	accOneb = imgui.ImInt(ini.bind.accOne)
	accOnecmd = imgui.ImBuffer(ini.bind.accOnecmd.."", 64) 
	--
	accTwob = imgui.ImInt(ini.bind.accTwo)
	accTwocmd = imgui.ImBuffer(ini.bind.accTwocmd.."", 64) 
	--
	accThreeb = imgui.ImInt(ini.bind.accThree)
	accThreecmd = imgui.ImBuffer(ini.bind.accThreecmd.."", 64) 
	--
	accFourb = imgui.ImInt(ini.bind.accFour)
	accFourcmd = imgui.ImBuffer(ini.bind.accFourcmd.."", 64) 
	--
	accFiveb = imgui.ImInt(ini.bind.accFive)
	accFivecmd = imgui.ImBuffer(ini.bind.accFivecmd.."", 64) 

	informer  = imgui.ImBool(false)
	error_window = imgui.ImBool(false)
	main_windows_state = imgui.ImBool(false)
	autologin_window = imgui.ImBool(false)
	add_window_state  = imgui.ImBool(false)
	edit_window_state  = imgui.ImBool(false)
	delete_window_state  = imgui.ImBool(false)
	pass_window_state  = imgui.ImBool(false)
	code_window_state  = imgui.ImBool(false)
	server_window_state  = imgui.ImBool(false)
	gadd_window = imgui.ImBool(false)
	bind_window = imgui.ImBool(false)
	loop_window = imgui.ImBool(false)
	bindset_window = imgui.ImBool(false)
	changelog_window = imgui.ImBool(false)
	imguiDemo = imgui.ImBool(false)
	savepass = imgui.ImBuffer(64)
	savecode = imgui.ImBuffer(64)
	showpass = imgui.ImBool(false)
	showcode = imgui.ImBool(false)
	gauthcode = imgui.ImBuffer(64)
	selaccbind = imgui.ImInt(0)
	sel = imgui.ImInt(0)

	customServ_window = imgui.ImBool(false)
	customServ_AddServToProject_Name = imgui.ImBuffer(64)
	customServ_AddServToProject_IP = imgui.ImBuffer(64) 
	customServ_AddServToProject_Port = imgui.ImBuffer(64) 

	customServ_AddProject_projectname = imgui.ImBuffer(64)
	customServ_AddProject_title = imgui.ImBuffer(64)
	---------------------
	---------------------
	customServ_Orient_Auth_INT = imgui.ImInt(0)
	customServ_Orient_Auth_ID = imgui.ImInt(0)
	customServ_Orient_Auth_text = imgui.ImBuffer(264)
	customServ_Orient_Auth_title = imgui.ImBuffer(128)
	---------------------
	customServ_Orient_GAuth_INT = imgui.ImInt(0)
	customServ_Orient_GAuth_ID = imgui.ImInt(0)
	customServ_Orient_GAuth_text = imgui.ImBuffer(264)
	customServ_Orient_GAuth_title = imgui.ImBuffer(128)
	---------------------
	customServ_Orient_Pin_INT = imgui.ImInt(0)
	customServ_Orient_Pin_ID = imgui.ImInt(0)
	customServ_Orient_Pin_text = imgui.ImBuffer(264)
	customServ_Orient_Pin_title = imgui.ImBuffer(128)
	---------------------
	---------------------
end


local sync_done = false 

local jhg = false

local ActiveMenu = {
	v = {ini.settings.key1,ini.settings.key2}
}
local ReconB = {
	v = {ini.bind.recon1,ini.bind.recon2}
}
local DisB = {
	v = {ini.bind.dis1,ini.bind.dis2}
}
--
local AccOneB = {
	v = {ini.bind.accOne1,ini.bind.accOne2}
}
--
local AccTwoB = {
	v = {ini.bind.accTwo1,ini.bind.accTwo2}
}
--
local AccThreeB = {
	v = {ini.bind.accThree1,ini.bind.accThree2}
}
--
local AccFourB = {
	v = {ini.bind.accFour1,ini.bind.accFour2}
}
--
local AccFiveB = {
	v = {ini.bind.accFive1,ini.bind.accFive2}
}
--
local tLastKeys = {

}

local bindID = 0
local reconID = 1
local disID = 2
local accOneID = 3
local accTwoID = 4
local accThreeID = 5
local accFourID = 6
local accFiveID = 7

local vkladki = {
    false,
		false,
		false,
		false,
		false,
		false,
}

vkladki[ini.settings.vkladka] = true


local items = {
	u8"Ҹ���� ����",
	u8"����� ����",
	u8"������� ����",
	u8"������� ����",
	u8"������ ����",
	u8"��������� ����",
	u8"���������� ����",
	u8"Ҹ���-������� ����",
	u8"������� ���� (new)"
}

local styles = {
	u8'�������',
	u8'������'
}

local activ = {
	u8"��� ���������",
	u8"��������� ��������",
	u8"��������� �������"
}

local srv = {
	u8"��� �������", 
	u8"Arizona RP",
	u8"Advance RP",
	u8"Diamond RP",
	u8"Evolve RP",
	u8"Samp RP",
	u8"Trinity GTA",
	u8"Monser DM",
}

local enter = {
	u8"� ������", 
	u8"� ���",
}

local accsel = {
	"1","2","3","4","5"
}

local customServ_Orient = {
	u8"ID �������",
	u8"��������� �������",
	u8"����� �������"
}


local accounts_buffs = {}
local account_info = nil

function alogin(id, title, text)
	---------------------------------------------Revent RP---------------------------------------------------------
	if id == 2 and account_info == nil and getServTitle(ip, port.."") == "Revent RP" then
		checkpass = true
	end
	if id == 3 and account_info == nil and getServTitle(ip, port.."") == "Revent RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
	end
	if id == 14660 and account_info == nil and getServTitle(ip, port.."") == "Revent RP" then
		pass_window_state.v = true
	end
	if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Revent RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 22100 and account_info ~= nil and getServTitle(ip, port.."") == "Revent RP" then
		if text:find("� ���� ����:") then
			gauthcode.v = string.match(text, '� ���� ����: {ffff00}(.-){ffffff}')
			gadd_window.v = true
		end
	end
	if id == 22101 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Revent RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	---------------------------------------------Arizona RP--------------------------------------------------------
	if account_info ~= nil and checkpass then checkpass = false end
	if id == 8929 and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if id == 8928 and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if id == 1 and title:match("1") and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = true
	end
	if id == 1 and title:match("2") and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		regstape = true
		--pass_window_state.v = true
	end
	
	if id == 8921 and account_info ~= nil and getServTitle(ip, port.."") == "Arizona RP" then
		findcode = true
	end
	if id == 8929 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 991 and account_info ~= nil and account_info['code'] ~= "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		if autocode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['code'] )
				return false
			else sampSendChat(cmdent.v.." "..account_info['code']) end
		else
			SCM('���� ���� ���� �� ����� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 991 and account_info ~= nil and account_info['code'] == "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		checkbank = true
	end
	if id == 33 and account_info['code'] == "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		checkbank = false
		savecode = savecodee
		code_window_state.v = true
	end
	if id == 2 and account_info == nil and (getServTitle(ip, port.."") == "Arizona RP") then
		checkpass = true
	end
	if id == 2 and account_info ~= nil and (getServTitle(ip, port.."") == "Arizona RP") then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	---------------------------------------------Diamond RP--------------------------------------------------------
	if title:match("������ ������") and account_info == nil and getServTitle(ip, port.."") == "Diamond RP" then
		checkpass = true
	end
	if id == 11 and account_info == nil and getServTitle(ip, port.."") == "Diamond RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
	end
	if id == 2 and account_info ~= nil and (getServTitle(ip, port.."") == "Diamond RP") then
			if autopass.v == true then
				if getServTitle(ip, port.."") == "Diamond RP" then 
					lua_thread.create(function ()
						wait(100)
						if typeent.v == 0 then
							sampSetCurrentDialogEditboxText(account_info['user_password'])
							sampCloseCurrentDialogWithButton(1)
						else sampSendChat(cmdent.v.." "..account_info['user_password']) end
						wait(300)
					end)
				else
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['user_password'])
						return false
					else sampSendChat(cmdent.v.." "..account_info['user_password']) end
				end
			else
				SCM('���� ���� ������ ��������.')
				SCM('����� ��������, ��������� � ���������.')
			end
	end
	if id == 2 and account_info == nil and (getServTitle(ip, port.."") == "Diamond RP" or getServTitle(ip, port.."") == "Advance RP" or getServTitle(ip, port.."") == "Evolve RP") then
		checkpass = true
	end
	if id == 6 and account_info ~= nil and account_info['code'] ~= "nil" and getServTitle(ip, port.."") == "Diamond RP" then
		if autocode.v == true then
			lua_thread.create(function ()
				wait(150)
				if typeent.v == 0 then
					sampSetCurrentDialogEditboxText(account_info['code'])
					sampCloseCurrentDialogWithButton(1)
				else sampSendChat(cmdent.v.." "..account_info['code']) end
			end)
		else
			SCM('���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	
	if id == 337 and account_info ~= nil and account_info['code'] == "nil" and getServTitle(ip, port.."") == "Diamond RP" then
		checkbank = true
	end
	if id == 3 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Diamond RP" then
		if autogcode.v == true then
			lua_thread.create(function ()
				wait(150)
				if typeent.v == 0 then
					sampSetCurrentDialogEditboxText(genCode( account_info['gauth'] ))
					sampCloseCurrentDialogWithButton(1)
				else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
			end)
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	----------------------------------------------Advance RP---------------------------------------------------------------
	if id == 1 and account_info == nil and getServTitle(ip, port.."") == "Advance RP" then
		checkpass = true
	end
	if id == 3 and account_info == nil and getServTitle(ip, port.."") == "Advance RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
	end
	if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Advance RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 88 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Advance RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end 
	----------------------------------------------Evolve RP---------------------------------------------------------------2 pass next 12, 1 auth [PIN code �����������]:{FFFFFF} ������ �������������:{ae433d} 538969
	-- {FFFFFF}����������� | {ae433d}�������� ������
	-- {FFFFFF}����������� | {ae433d}���� ������

	-- if title == "{FFFFFF}����������� | {ae433d}�������� ������" then
	-- 	print("aaa")
	-- end
	if title == "{FFFFFF}����������� | {ae433d}�������� ������" and account_info == nil and getServTitle(ip, port.."") == "Evolve RP" then
		checkpass = true
	end
	if title == "{FFFFFF}����������� | {ae433d}������� ������� (1/2)" and account_info == nil and getServTitle(ip, port.."") == "Evolve RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if title == "{FFFFFF}����������� | {ae433d}���� ������" and account_info ~= nil and getServTitle(ip, port.."") == "Evolve RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end	
	-- if id == 1 and account_info == nil and getServTitle(ip, port.."") == "Evolve RP" then
	-- 	checkpass = true
	-- end
	-- if id == 12 and account_info == nil and getServTitle(ip, port.."") == "Evolve RP" and checkpass then
	-- 	checkpass = false
	-- 	savepass = savepas
	-- 	savepas = nil
	-- 	pass_window_state.v = true
	-- end
	-- if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Evolve RP" then
	-- 	if autopass.v == true then
	-- 		if typeent.v == 0 then
	-- 			sampSendDialogResponse(id, 1, 0, account_info['user_password'])
	-- 			return false
	-- 		else sampSendChat(cmdent.v.." "..account_info['user_password']) end
	-- 	else
	-- 		SCM('���� ���� ������ ��������.')
	-- 		SCM('����� ��������, ��������� � ���������.')
	-- 	end
	-- end
	if id == 16 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Evolve RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end 
	----------------------------------------------------Samp RP-------------------------------------------------------------2 next 3 code 22
	if (id == 1 or id == 2) and account_info == nil and getServTitle(ip, port.."") == "Samp RP" then -- ID 2 - "�����������"
		checkpass = true
	end
	if id == 3 and account_info == nil and getServTitle(ip, port.."") == "Samp RP" and checkpass then -- ������� �������
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 22 and title:match("���� ���������") and text:match("������� ���� �������� ������") and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 22 and title:match("���� ���������") and text:find('������� ����� ���� ��� ������ ��������') and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		checkbank = true
	end
	if id == 22 and title:match("���� ���������") and text:find('��� ��������� ����') and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		gauthcode.v = string.match(text, '��� ��������� ����: (.-)\n')
		gadd_window.v = true
	end
	if id == 281 and account_info ~= nil and title:match("������� ���� ������������") and account_info['code'] ~= "nil" and getServTitle(ip, port.."") == "Samp RP" then
		if autocode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['code'] )
				return false
			else sampSendChat(cmdent.v.." "..account_info['code']) end
		else
			SCM('���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 281 and account_info ~= nil and title:match("������� ����") and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Samp RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
end

function sampev.onShowDialog(id, style, title, b1,b2,text)
	---------------------------------------------Arizona RP--------------------------------------------------------
	if account_info ~= nil and checkpass then checkpass = false end
	if id == 8929 and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if id == 8928 and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if id == 1 and title:match("1") and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = true
	end
	if id == 1 and title:match("2") and account_info == nil and getServTitle(ip, port.."") == "Arizona RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		regstape = true
		--pass_window_state.v = true
	end
	
	if id == 8921 and account_info ~= nil and getServTitle(ip, port.."") == "Arizona RP" then
		findcode = true
	end
	if id == 8929 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 991 and account_info ~= nil and account_info['code'] ~= "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		if autocode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['code'] )
				return false
			else sampSendChat(cmdent.v.." "..account_info['code']) end
		else
			SCM('���� ���� ���� �� ����� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 991 and account_info ~= nil and account_info['code'] == "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		checkbank = true
	end
	if id == 33 and account_info['code'] == "nil" and getServTitle(ip, port.."") == "Arizona RP" then
		checkbank = false
		savecode = savecodee
		code_window_state.v = true
	end
	if id == 2 and account_info == nil and (getServTitle(ip, port.."") == "Arizona RP") then
		checkpass = true
	end
	if id == 2 and account_info ~= nil and (getServTitle(ip, port.."") == "Arizona RP") then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	---------------------------------------------Diamond RP--------------------------------------------------------
	if title:match("������ ������") and account_info == nil and getServTitle(ip, port.."") == "Diamond RP" then
		checkpass = true
	end
	if id == 11 and account_info == nil and getServTitle(ip, port.."") == "Diamond RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
	end
	if id == 2 and account_info ~= nil and (getServTitle(ip, port.."") == "Diamond RP") then
			if autopass.v == true then
				if getServTitle(ip, port.."") == "Diamond RP" then 
					lua_thread.create(function ()
						wait(100)
						if typeent.v == 0 then
							sampSetCurrentDialogEditboxText(account_info['user_password'])
							sampCloseCurrentDialogWithButton(1)
						else sampSendChat(cmdent.v.." "..account_info['user_password']) end
						wait(300)
					end)
				else
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['user_password'])
						return false
					else sampSendChat(cmdent.v.." "..account_info['user_password']) end
				end
			else
				SCM('���� ���� ������ ��������.')
				SCM('����� ��������, ��������� � ���������.')
			end
	end
	if id == 2 and account_info == nil and (getServTitle(ip, port.."") == "Diamond RP" or getServTitle(ip, port.."") == "Advance RP" or getServTitle(ip, port.."") == "Evolve RP") then
		checkpass = true
	end
	if id == 6 and account_info ~= nil and account_info['code'] ~= "nil" and getServTitle(ip, port.."") == "Diamond RP" then
		if autocode.v == true then
			lua_thread.create(function ()
				wait(150)
				if typeent.v == 0 then
					sampSetCurrentDialogEditboxText(account_info['code'])
					sampCloseCurrentDialogWithButton(1)
				else sampSendChat(cmdent.v.." "..account_info['code']) end
			end)
		else
			SCM('���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	
	if id == 337 and account_info ~= nil and account_info['code'] == "nil" and getServTitle(ip, port.."") == "Diamond RP" then
		checkbank = true
	end
	if id == 3 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Diamond RP" then
		if autogcode.v == true then
			lua_thread.create(function ()
				wait(150)
				if typeent.v == 0 then
					sampSetCurrentDialogEditboxText(genCode( account_info['gauth'] ))
					sampCloseCurrentDialogWithButton(1)
				else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
			end)
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	----------------------------------------------Advance RP---------------------------------------------------------------
	if id == 1 and account_info == nil and getServTitle(ip, port.."") == "Advance RP" then
		checkpass = true
	end
	if id == 3 and account_info == nil and getServTitle(ip, port.."") == "Advance RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
	end
	if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Advance RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 88 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Advance RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end 
	----------------------------------------------Evolve RP---------------------------------------------------------------2 pass next 12, 1 auth [PIN code �����������]:{FFFFFF} ������ �������������:{ae433d} 538969
	if title == "{FFFFFF}����������� | {ae433d}�������� ������" and account_info == nil and getServTitle(ip, port.."") == "Evolve RP" then
		checkpass = true
	end
	if title == "{FFFFFF}����������� | {ae433d}������� ������� (1/2)" and account_info == nil and getServTitle(ip, port.."") == "Evolve RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if title == "{FFFFFF}����������� | {ae433d}���� ������" and account_info ~= nil and getServTitle(ip, port.."") == "Evolve RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end	
	if title == "{FFFFFF}���� | {ae433d}Google Auth" and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Evolve RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end 
	---------------------------------------------Revent RP---------------------------------------------------------
	if id == 2 and account_info == nil and getServTitle(ip, port.."") == "Revent RP" then
		checkpass = true
	end
	if id == 3 and account_info == nil and getServTitle(ip, port.."") == "Revent RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
	end
	if id == 14660 and account_info == nil and getServTitle(ip, port.."") == "Revent RP" then
		pass_window_state.v = true
	end
	if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Revent RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 22100 and account_info ~= nil and getServTitle(ip, port.."") == "Revent RP" then
		if text:find("� ���� ����:") then
			gauthcode.v = string.match(text, '� ���� ����: {ffff00}(.-){ffffff}')
			gadd_window.v = true
		end
	end
	if id == 22101 and account_info ~= nil and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Revent RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	----------------------------------------------------Samp RP-------------------------------------------------------------2 next 3 code 22
	if (id == 1 or id == 2) and account_info == nil and getServTitle(ip, port.."") == "Samp RP" then
		checkpass = true
	end
	if id == 3 and account_info == nil and getServTitle(ip, port.."") == "Samp RP" and checkpass then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = true
	end
	if id == 1 and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 22 and title:match("���� ���������") and text:match("������� ���� �������� ������") and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		if autopass.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['user_password'])
				return false
			else sampSendChat(cmdent.v.." "..account_info['user_password']) end
		else
			SCM('���� ���� ������ ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 22 and title:match("���� ���������") and text:find('������� ����� ���� ��� ������ ��������') and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		checkbank = true
	end
	if id == 22 and title:match("���� ���������") and text:find('��� ��������� ����') and account_info ~= nil and getServTitle(ip, port.."") == "Samp RP" then
		gauthcode.v = string.match(text, '��� ��������� ����: (.-)\n')
		gadd_window.v = true
	end
	if id == 281 and account_info ~= nil and title:match("������� ���� ������������") and account_info['code'] ~= "nil" and getServTitle(ip, port.."") == "Samp RP" then
		if autocode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, account_info['code'] )
				return false
			else sampSendChat(cmdent.v.." "..account_info['code']) end
		else
			SCM('���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	if id == 281 and account_info ~= nil and title:match("������� ����") and account_info['gauth'] ~= "nil" and getServTitle(ip, port.."") == "Samp RP" then
		if autogcode.v == true then
			if typeent.v == 0 then
				sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
				return false
			else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
		else
			SCM('���� ���� ���� ���� ��������.')
			SCM('����� ��������, ��������� � ���������.')
		end
	end
	---------------------------------------------------------------------------------------------------------------
	-----------------------------------------Custom Servers--------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------
	local result, t = getCustomServTitle(ip, port.."")
	if result then
		if t['Orient_Auth_INT'] == 0 then
			if id == t['Orient_Auth_ID'] and account_info ~= nil then 
				if autopass.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['user_password'])
						return false
					else sampSendChat(cmdent.v.." "..account_info['user_password']) end
				else
					SCM('���� ���� ������ ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_Auth_INT'] == 1 then
			if title:find(t['Orient_Auth_title']) and account_info ~= nil then 
				if autopass.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['user_password'])
						return false
					else sampSendChat(cmdent.v.." "..account_info['user_password']) end
				else
					SCM('���� ���� ������ ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_Auth_INT'] == 2 then
			if text:find(t['Orient_Auth_text']) and account_info ~= nil then 
				if autopass.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['user_password'])
						return false
					else sampSendChat(cmdent.v.." "..account_info['user_password']) end
				else
					SCM('���� ���� ������ ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_GAuth_INT'] == 0 then
			if id == t['Orient_GAuth_ID'] and account_info ~= nil and account_info['gauth'] ~= "nil" then 
				if autogcode.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
						return false
					else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
				else
					SCM('���� ���� ���� ���� ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_GAuth_INT'] == 1 then
			if title:find(t['Orient_GAuth_title']) and account_info ~= nil and account_info['gauth'] ~= "nil" then 
				if autogcode.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
						return false
					else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
				else
					SCM('���� ���� ���� ���� ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_GAuth_INT'] == 2 then
			if text:find(t['Orient_GAuth_text']) and account_info ~= nil and account_info['gauth'] ~= "nil" then 
				if autogcode.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, genCode(account_info['gauth']))
						return false
					else sampSendChat(cmdent.v.." "..genCode(account_info['gauth'])) end
				else
					SCM('���� ���� ���� ���� ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_Pin_INT'] == 0 then
			if id == t['Orient_Pin_ID'] and account_info ~= nil and account_info['code'] ~= "nil" then 
				if autocode.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['code'] )
						return false
					else sampSendChat(cmdent.v.." "..account_info['code']) end
				else
					SCM('���� ���� ���� �� ����� ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_Pin_INT'] == 1 then
			if id == t['Orient_Pin_title'] and account_info ~= nil and account_info['code'] ~= "nil" then 
				if autocode.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['code'] )
						return false
					else sampSendChat(cmdent.v.." "..account_info['code']) end
				else
					SCM('���� ���� ���� �� ����� ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
		if t['Orient_Pin_INT'] == 2 then
			if id == t['Orient_Pin_text'] and account_info ~= nil and account_info['code'] ~= "nil" then 
				if autocode.v == true then
					if typeent.v == 0 then
						sampSendDialogResponse(id, 1, 0, account_info['code'] )
						return false
					else sampSendChat(cmdent.v.." "..account_info['code']) end
				else
					SCM('���� ���� ���� �� ����� ��������.')
					SCM('����� ��������, ��������� � ���������.')
				end
			end
		end
	end
end

function sampev.onSetSpawnInfo()
	ip, port = sampGetCurrentServerAddress()
	if checkpass == true and getServTitle(ip, port.."") == "Arizona RP" and account_info == nil then
		if not regstape then
			checkpass = false
			savepass = savepas
			savepas = nil
		end
		pass_window_state.v = not pass_window_state.v
	end
end


function sampev.onSetPlayerPos()
	if checkpass == true and getServTitle(ip, port.."") == "Samp RP" then
		checkpass = false
		savepass = savepas
		savepas = nil
		pass_window_state.v = not pass_window_state.v
	end
	if savepas ~= nil and getServTitle(ip, port.."") == "Diamond RP" then
		if checkpass == true then
			checkpass = false
			savepass = savepas
			savepas = nil
			pass_window_state.v = not pass_window_state.v
		end
	end
end



function sampev.onServerMessage(color,text)
	if text:find('�� �������� ������� ��������, �.�. ������������ ��� ��� ����� ����� ����������') and getServTitle(ip, port.."") == "Arizona RP" then
		checkbank = false
		savecode = savecodee
		code_window_state.v = true
	end
	if text:find('�� ������� ������� ����. ��� �����') and getServTitle(ip, port.."") == "Samp RP" then
		checkbank = false
		savecode = savecodee
		code_window_state.v = true
	end
	if text:find('������� ���������������') and getServTitle(ip, port.."") == "Diamond RP"  and savepass ~= "" then
		pass_window_state.v = true
	end
	if text:find('����������� ���������!') and getServTitle(ip, port.."") == "Advance RP"  and savepass ~= "" then
		pass_window_state.v = true
	end
end
-----------------------------------------------------------------------------------------------------------
if lrkeys then
	function rkeys.onHotKey(id, keys)
		if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
			return false
		end
	end
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	if lrkeys then  
		SCM('������ ��������. ���������: {F1CB09}'..table.concat(rkeys.getKeysName(ActiveMenu.v), " + "))
	else 
		SCM('������ �������� � �������.') 
	end

	if doesFileExist(thisScript().path) then
		os.rename(thisScript().path, 'moonloader/Connect Tool v'..thisScript().version..'.lua')
	end

	sampRegisterChatCommand("rRSetup", function()
		if not doesFileExist('resetRemove.asi') then -- ��������������� ��� �����. https://blast.hk/threads/18967/
			downloadUrlToFile("https://github.com/danil8515/Connect-Tool/blob/master/resetRemove.asi?raw=true", "resetRemove.asi", function(id, status, p1, p2) 
				if status == dlstatus.STATUS_DOWNLOADINGDATA then
					libs_dwn_status = 'proccess'
					SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
				elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
					libs_dwn_status = 'succ'
					SCM('resetRemove.asi ������� ��������')
					SCM('��� ���������� ������, ��������� ������������ ����')
				elseif status == 64 then
					libs_dwn_status = 'failed'
				end
			end)
		else 
			SCM('resetRemove.asi ��� ����������.')
		end
	end)

	if not doesFileExist('resetRemove.asi') then
		SCM('�� ��� ��������� resetRemove.asi, ����� ���������� - "/rRSetup"')
	end

	if doesFileExist('samp.asi') then
		sampasi = true
		print('��������� samp.asi, ������������� ��� ������� ��� ���������� ������.')
	end
	
	if not doesFileExist('moonloader/config/KopnevScripts/servers.ctool') then
		if not doesDirectoryExist('moonloader/config/KopnevScripts/') then createDirectory('moonloader/config/KopnevScripts/') end
		-- downloadUrlToFile("https://raw.githubusercontent.com/trashlll/Connection-TOOL/main/servers.json", "moonloader/config/KopnevScripts/servers.ctool")
		downloadUrlToFile("https://pastebin.com/raw/E3i0w6W8", "moonloader/config/KopnevScripts/servers.ctool")		
		
		lua_thread.create(function()
			wait(5000)
			if not doesFileExist('moonloader/config/KopnevScripts/servers.ctool') then
				local fpath = "moonloader/config/KopnevScripts/servers.ctool"
				local tJSON = encodeJson(serv)
				if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
					local f = io.open(fpath, "w")
					f:write(tJSON)
					f:close()
				else
					SCM("������ ������ JSON �������. ���������� ��� ���")
				end
			else
				local fpath = "moonloader/config/KopnevScripts/servers.ctool"
				local f = io.open(fpath, "r")
				serv = decodeJson(f:read"*a")
				f:close()
				SCM()
			end
		end)
	else 
		local fpath = "moonloader/config/KopnevScripts/servers.ctool"
		local f = io.open(fpath, "r")
		serv = decodeJson(f:read"*a")
		f:close()
	end

	if doesFileExist('moonloader/ConnectToolHelper.lua') then
		os.remove('moonloader/ConnectToolHelper.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.0.lua') then
		os.remove('moonloader/Connect-Tool v2.0.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.1.lua') then
		os.remove('moonloader/Connect-Tool v2.1.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.2.lua') then
		os.remove('moonloader/Connect-Tool v2.2.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.3.lua') then
		os.remove('moonloader/Connect-Tool v2.3.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.4.lua') then
		os.remove('moonloader/Connect-Tool v2.4.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.5.lua') then
		os.remove('moonloader/Connect-Tool v2.5.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.6.lua') then
		os.remove('moonloader/Connect-Tool v2.6.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.7.lua') then
		os.remove('moonloader/Connect-Tool v2.7.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.8.lua') then
		os.remove('moonloader/Connect-Tool v2.8.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.85.lua') then
		os.remove('moonloader/Connect-Tool v2.85.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.86.lua') then
		os.remove('moonloader/Connect-Tool v2.86.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.87.lua') then
		os.remove('moonloader/Connect-Tool v2.87.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.88.lua') then
		os.remove('moonloader/Connect-Tool v2.88.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.9.lua') then
		os.remove('moonloader/Connect-Tool v2.9.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.95.lua') then
		os.remove('moonloader/Connect-Tool v2.95.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.96.lua') then
		os.remove('moonloader/Connect-Tool v2.96.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.97.lua') then
		os.remove('moonloader/Connect-Tool v2.97.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.98.lua') then
		os.remove('moonloader/Connect-Tool v2.98.lua')
	end
	if doesFileExist('moonloader/Connect-Tool v2.99.lua') then
		os.remove('moonloader/Connect-Tool v2.99.lua')
	end

	if not doesDirectoryExist('moonloader/config/KopnevScripts/') then
		createDirectory('moonloader/config/KopnevScripts/')
	end

	if not limgui then
        SCM('������ imgui �� ��� ���������')
        sampShowDialog(128, '{ff0000}Connect Tool | ���������� ������', '{FFFFFF}������ ImGui �� ��� ���������!\n���������� ������ ������� �� ��������\n��������� ��� �������� ���� ������', '���������', '���������', 0)
        lua_thread.create(function() 
            if sampIsDialogActive() then
                while sampIsDialogActive() do
                    wait(0)
                    local result, button, list, input = sampHasDialogRespond(128)
					if result then
						if button == 1 then
							if not doesFileExist("moonloader/lib/MoonImGui.dll") then
								downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/MoonImGui.dll", "moonloader/lib/MoonImGui.dll", function(id, status, p1, p2) 
									if status == dlstatus.STATUS_ENDDOWNLOADDATA then
										if status == dlstatus.STATUS_DOWNLOADINGDATA then
											SCM(string.format('��������� %d ���� �� %d ����', p1, p2))
										elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
											SCM(string.format('��������� %d ���� �� %d ����', p1, p2))
											SCM('���� MoonImGui.dll ������� ��������!')
										end
									end
								end)
							end
							downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/imgui.lua", "moonloader/lib/imgui.lua", function(id, status, p1, p2) 
								if status == dlstatus.STATUS_ENDDOWNLOADDATA then
									if status == dlstatus.STATUS_DOWNLOADINGDATA then
										SCM(string.format('��������� %d ���� �� %d ����', p1, p2))
									elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
										SCM(string.format('��������� %d ���� �� %d ����', p1, p2))
										SCM('���� imgui.lua ������� ��������!')
										thisScript():reload()
									end
								end
							end)
						else 
							thisScript():unload() 
						end
                    end
                end
            end
        end)
	else
		if not limadd or not lrkeys or not lfa or not lsha1 or not lbasexx then
			error_window.v = true
		end
		sampRegisterChatCommand("ctool", function()
			main_windows_state.v = not main_windows_state.v end)
		local acti = ""
		if ini.bind.recon == 1 then
			acti = acti.." ���������"
			sampRegisterChatCommand(ini.bind.reconcmd, function(param) 
				param = param:match('%d[%d.,]*')
				if param == nil then recon = true else redelay.v = param*1000 recon = true end
			end) 
		end
		if ini.bind.dis == 1 then
			acti = acti.." ����������"
			sampRegisterChatCommand(ini.bind.discmd, function() 
				sampDisconnectWithReason(-1)
			end) 
		end 
		if ini.bind.name == 1 then
			acti = acti.." ��������� ����"
			sampRegisterChatCommand(ini.bind.namecmd, name) 
		end 

		if ini.bind.accOne == 1 then
			acti = acti.." ����������� � ��������"
			sampRegisterChatCommand(ini.bind.accOnecmd, function() 
				rename.v = accounts[1]['user_name']
				reip.v = accounts[1]['server_ip']
				report.v = accounts[1]['server_port']
				recon = true
			end) 
		end 
		if ini.bind.accTwo == 1 then
			if ini.bind.accOne ~= 1 then
			acti = acti.." ����������� � ��������" end
			sampRegisterChatCommand(ini.bind.accTwocmd, function() 
				rename.v = accounts[2]['user_name']
				reip.v = accounts[2]['server_ip']
				report.v = accounts[2]['server_port']
				recon = true
			end) 
		end 
		if ini.bind.accThree == 1 then
			if ini.bind.accOne ~= 1 and ini.bind.accTwo ~= 1 then
				acti = acti.." ����������� � ��������" end
			sampRegisterChatCommand(ini.bind.accThreecmd, function() 
				rename.v = accounts[3]['user_name']
				reip.v = accounts[3]['server_ip']
				report.v = accounts[3]['server_port']
				recon = true
			end) 
		end 
		if ini.bind.accFour == 1 then
			if ini.bind.accOne ~= 1 and ini.bind.accTwo ~= 1 and ini.bind.accThree ~= 1 then
				acti = acti.." ����������� � ��������" end
			sampRegisterChatCommand(ini.bind.accFourcmd, function() 
				rename.v = accounts[4]['user_name']
				reip.v = accounts[4]['server_ip']
				report.v = accounts[4]['server_port']
				recon = true
			end) 
		end 
		if ini.bind.accFive == 1 then
			if ini.bind.accOne ~= 1 and ini.bind.accTwo ~= 1 and ini.bind.accThree ~= 1 and ini.bind.accFive ~= 1  then
				acti = acti.." ����������� � ��������" end
			sampRegisterChatCommand(ini.bind.accFivecmd, function() 
				rename.v = accounts[5]['user_name']
				reip.v = accounts[5]['server_ip']
				report.v = accounts[5]['server_port']
				recon = true
			end) 
		end 
		if acti ~= "" then SCM('��������� ������� ��{F1CB09}'..acti) end
		if lrkeys then
			bindID = rkeys.registerHotKey(ActiveMenu.v, true, function ()
				main_windows_state.v = not main_windows_state.v
			end)
			if ini.bind.recon == 2 then
				reconID = rkeys.registerHotKey(ReconB.v, true, function ()
					recon = true
				end)
			end
			if ini.bind.dis == 2 then
				disID = rkeys.registerHotKey(DisB.v, true, function ()
					sampDisconnectWithReason(-1)
				end)
			end
			if ini.bind.accOne == 2 then
				accOneID = rkeys.registerHotKey(AccOneB.v, true, function ()
					rename.v = accounts[1]['user_name']
					reip.v = accounts[1]['server_ip']
					report.v = accounts[1]['server_port']
					recon = true
				end)
			end
			if ini.bind.accTwo == 2 then
				accTwoID = rkeys.registerHotKey(AccTwoB.v, true, function ()
					rename.v = accounts[2]['user_name']
					reip.v = accounts[2]['server_ip']
					report.v = accounts[2]['server_port']
					recon = true
				end)
			end
			if ini.bind.accThree == 2 then
				accThreeID = rkeys.registerHotKey(AccThreeB.v, true, function ()
					rename.v = accounts[3]['user_name']
					reip.v = accounts[3]['server_ip']
					report.v = accounts[3]['server_port']
					recon = true
				end)
			end
			if ini.bind.accFour == 2 then
				accFourID = rkeys.registerHotKey(AccFourB.v, true, function ()
					rename.v = accounts[4]['user_name']
					reip.v = accounts[4]['server_ip']
					report.v = accounts[4]['server_port']
					recon = true
				end)
			end
			if ini.bind.accFive == 2 then
				accFiveID = rkeys.registerHotKey(AccFiveB.v, true, function ()
					rename.v = accounts[5]['user_name']
					reip.v = accounts[5]['server_ip']
					report.v = accounts[5]['server_port']
					recon = true
				end)
			end
		end


		if ini.settings.reload == true then
			SCM('������� ��������� � ���������.')
			main_windows_state.v = true
			ini.settings.reload = false
			inicfg.save(def, directIni)
		end

		if ini.settings.reloadR == true then
			ini.settings.reloadR = false
			inicfg.save(def, directIni)
		end

		-- update()
		local result, clientId = sampGetPlayerIdByCharHandle(playerPed)
		savepass = "pass"
		savecode = "code"
		ip, port = sampGetCurrentServerAddress()
		name = sampGetPlayerNickname(clientId)

		rename.v = name
		reip.v = ip
		report.v = port..""

		if ini.settings.fastconnect == true then
			fastconnect()
		end

		local fpath = getWorkingDirectory()..'\\config\\KopnevScripts\\customServ.json'
		if doesFileExist(fpath) then
			local f = io.open(fpath, 'r')
			if f then
				customServ = decodeJson(f:read('*a'))
				f:close()
			end
		end

		local fpath = getWorkingDirectory()..'\\config\\KopnevScripts\\accounts.json'
		if doesFileExist(fpath) then
			local f = io.open(fpath, 'r')
			if f then
				accounts = decodeJson(f:read('*a'))
				f:close()
				accounts_buffs = {}
				for i, v in ipairs(accounts) do
					local temptable = {
						user_name         = imgui.ImBuffer(64),
						user_password     = imgui.ImBuffer(64),
						server_ip         = imgui.ImBuffer(128),
						server_port       = imgui.ImBuffer(16),
						gauth             = imgui.ImBuffer(64),
						code              = imgui.ImBuffer(16),
					}
					temptable['user_name'].v         = v['user_name']
					temptable['user_password'].v     = v['user_password']
					temptable['server_ip'].v         = v['server_ip']
					temptable['server_port'].v       = v['server_port']
					temptable['gauth'].v             = v['gauth']
					temptable['code'].v             = v['code']
					table.insert(accounts_buffs, temptable)
				end
			end
		else
			SCM('����������� ���� �� ������� ������� �� ���� {2980b0}'..fpath..'{FFFFFF}.')
			SCM('������ ������������� ������� ��������� ����.')
			local f = io.open(fpath, 'w+')
			if f then
				f:write(encodeJson({
					{
						user_name         = 'Nick_Name',
						user_password     = '123456',
						server_ip         = ip,
						server_port       = port.."",
						gauth             = "nil",
						code             = "nil",
					}
				})):close()
				local temptable = {
					user_name         = imgui.ImBuffer(64),
					user_password     = imgui.ImBuffer(64),
					server_ip         = imgui.ImBuffer(128),
					server_port       = imgui.ImBuffer(16),
					gauth             = imgui.ImBuffer(64),
					code              = imgui.ImBuffer(16),
				}
				accounts_buffs = {}
				temptable['user_name'].v         = 'Nick_Name'
				temptable['user_password'].v     = '123456'
				temptable['server_ip'].v        = ip
				temptable['server_port'].v      = port..""
				temptable['gauth'].v            = "nil"
				temptable['code'].v            = "nil"
				table.insert(accounts_buffs, temptable)
			else
				SCM('���-�� ����� �� ��� :(')
			end
		end
		loadacc()
	end
		
	while true do
		wait(350)
		if limgui then
			imgui.Process = main_windows_state.v or pass_window_state.v or informer.v or gadd_window.v or code_window_state.v or changelog_window.v or error_window.v or customServ_window.v
			if bg.v == true then
				WorkInBackground(true)
			else 
				WorkInBackground(false) 
			end
		end

		--if memory.read(0x8E4CB4, 4, true) > 419430400 then cleanStreamMemoryBuffer() end

		-- if checkpass == true then
		-- 	savepas = sampGetCurrentDialogEditboxText()
		-- end

		if sampasi and sampIsDialogActive() then 
			alogin(sampGetCurrentDialogId(), sampGetDialogCaption(), sampGetDialogText()) 
		end
		

		if checkbank == true then
			savecodee = sampGetCurrentDialogEditboxText(991)
		end

		-- if gou == true then
		-- 	goupdate()
		-- end

		if findcode == true then
			for i = 99, 1 do
				text, prefix, color, pcolor = sampGetChatString(i)
				if color == 4294967295 then
					gauthcode.v = text
					gadd_window.v = true
					break
				end
			end
			findcode = false
		end

		if recon == true then
			SCM("��������������� �����: "..redelay.v.." ms", 0x00ac35)
			SCM("��������� ������ ����� ���� ����������", 0x00ac35)
			if getServTitle(reip.v, report.v.."") == "Diamond RP" then
				lua_thread.create(function()
					pinganut(reip.v, report.v)
				end)
			end
			sampDisconnectWithReason(-1)
			wait(redelay.v)
			sampSetLocalPlayerName(rename.v)
			sampConnectToServer(reip.v, report.v)
			ReconTimer = false
			local result, clientId = sampGetPlayerIdByCharHandle(playerPed)
			if result then name = sampGetPlayerNickname(clientId) end
			ip, port = sampGetCurrentServerAddress()
			recon = false
			checkpass = false
			account_info = nil
			for i, v in ipairs(accounts) do
				local ip2 = ""
				for i4 in ipairs(ipserv) do
					--print(ipserv[i4]['domen'])
					if reip.v == ipserv[i4]['ip'] then ip2 = ipserv[i4]['domen'] break end
				end
				if (v['server_ip'] == ip2 or v['server_ip'] == reip.v) and v['server_port'] == report.v.."" and v['user_name'] == rename.v then
					print('{00FF00}�������{FFFFFF} �������� ������� {2980b9}'..v['user_name']..'{FFFFFF}.')
					account_info = v
					break
				end
			end
		end

		if jhg == false then
			if key then
				loop_async_http_request(server .. '?act=a_check&key=' .. key .. '&ts=' .. ts .. '&wait=25', '')
				jhg = true
			end
		end
	end
end

function pinganut(ip,port)
	-- change here to the host an port you want to contact
    local host, port = ip, port
    -- load namespace
    local socket = require("socket")
    -- convert host name to ip address
    local ip = assert(socket.dns.toip(host))
    -- create a new UDP object
    local udp = assert(socket.udp())
    -- contact daytime host
    udp:sendto("SAMP3K!�ai", ip, port)
end

function getIpAddress(domain)
    local ip, err = socket.dns.toip(domain)
    if ip then
        return ip
    else
        return nil, err
    end
end

function threadHandle(runner, url, args, resolve, reject) -- ��������� effil ������ ��� ����������
    local t = runner(url, args)
    local r = t:get(0)
    while not r do
        r = t:get(0)
        wait(0)
    end
    local status = t:status()
    if status == 'completed' then
        local ok, result = r[1], r[2]
        if ok then resolve(result) else reject(result) end
    elseif err then
        reject(err)
    elseif status == 'canceled' then
        reject(status)
    end
    t:cancel(0)
end

function requestRunner() -- �������� effil ������ � �������� https �������
    return effil.thread(function(u, a)
        local https = require 'ssl.https'
        local ok, result = pcall(https.request, u, a)
        if ok then
            return {true, result}
        else
            return {false, result}
        end
    end)
end

function async_http_request(url, args, resolve, reject)
    local runner = requestRunner()
    if not reject then reject = function() end end
    lua_thread.create(function()
        url = url.."?"..args
        threadHandle(runner, url, args, resolve, reject)
    end)
end

function toSendGet(msg)
	return urlencode(u8:encode(msg, "CP1251"))
end

function urlencode(arg)
	return arg and string.gsub(string.gsub(string.gsub(arg, "\n", "\r\n"), "([^%w ])", function (arg)
		return string.format("%%%02X", string.byte(arg))
	end), " ", "+")
end

----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------������ �� ������ ������------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

lua_thread.create(function() 
	while true do
		wait(30)
		if isKeyDown(17) and isKeyDown(82) then -- CTRL+R
			ini.settings.reloadR = true
			inicfg.save(def, directIni)
		end
	  end
end)

function name(nick)
	rename.v = nick
	recon = true
end

if limgui then
	----------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------����� ���� ���----------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------
	function onReceivePacket(id)
		if reconifkick.v == true and (id == 32 or id == 33 or id == 37) then
			lua_thread.create(function()
				red = redelayifkick.v * 1000
				SCM("����������� � ������� �����: "..redelayifkick.v.." ������", 0x19600e)
				ReconTimer = true
				wait(red)
				if reconifkick.v == true and ReconTimer then
					sampConnectToServer(ip, port)
					ReconTimer = false
				end
			end)
		end
		if reconifkick.v == true and id == 36 then
			for i = 99, 95, -1 do
				text, _, _, _ = sampGetChatString(i)
				if text:find("You are banned from this server") then
					lua_thread.create(function()
						red = redelayifkick.v * 1000
						SCM("����������� � ������� �����: "..redelayifkick.v.." ������", 0x19600e)
						ReconTimer = true
						wait(red)
						if reconifkick.v == true and ReconTimer then
							sampConnectToServer(ip, port)
							ReconTimer = false
						end
					end)
				end
			end
		end
	end

	function sampev.onConnectionRejected()
		if reconifkick.v == true then
			lua_thread.create(function()
				red = redelayifkick.v * 1000
				SCM("����������� � ������� �����: "..redelayifkick.v.." ������", 0x19600e)
				ReconTimer = true
				wait(red)
				if reconifkick.v == true and ReconTimer then
					sampConnectToServer(ip, port)
					ReconTimer = false
				end
			end)
		end
	end
	----------------------------------------------------------------------------------------------------------------------

	function drawImguiDemo()
		if imguiDemo.v then
			imgui.ShowTestWindow(imguiDemo)
		end
	end

	ips = imgui.ImBuffer(16)
	name = imgui.ImBuffer(64)
	pass = imgui.ImBuffer(64)

	function ShowHelpMarker(desc)
		imgui.TextDisabled(fa.ICON_QUESTION_CIRCLE)
		if imgui.IsItemHovered() then
			imgui.BeginTooltip()
			imgui.PushTextWrapPos(450.0)
			imgui.TextUnformatted(desc)
			imgui.PopTextWrapPos()
			imgui.EndTooltip()
		end
	end

	function ShowCOPYRIGHT(desc)
		imgui.TextDisabled(fa.ICON_COPYRIGHT)
		if imgui.IsItemHovered() then
			imgui.BeginTooltip()
			imgui.PushTextWrapPos(450.0)
			imgui.TextUnformatted(desc)
			imgui.PopTextWrapPos()
			imgui.EndTooltip()
		end
	end

	if lfa then
		function imgui.BeforeDrawFrame()
			if fa_font == nil then
				local font_config = imgui.ImFontConfig()
				font_config.MergeMode = true

					fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 11.0, font_config, fa_glyph_ranges)
			end
		end
	end

	function imgui.OnDrawFrame()
		local result, clientId = sampGetPlayerIdByCharHandle(playerPed)

		if ini.settings.style == 0 then strong_style() end
		if ini.settings.style == 1 then easy_style() end
		if ini.settings.theme == 0 then theme1() end
		if ini.settings.theme == 1 then theme2() end
		if ini.settings.theme == 2 then theme3() end
		if ini.settings.theme == 3 then theme4() end
		if ini.settings.theme == 4 then theme5() end
		if ini.settings.theme == 5 then theme6() end
		if ini.settings.theme == 6 then theme7() end
		if ini.settings.theme == 7 then theme8() end
		if ini.settings.theme == 8 then theme9() end


		drawImguiDemo()

		if informer.v then
			imgui.ShowCursor = false
			imgui.Begin('Informer')
			imgui.Text(u8'�������� ������:   '..sampGetCurrentDialogId())
			imgui.End()
		end

		if main_windows_state.v then
			mainwindow()
		end

		if customServ_window.v then
			customServWindow()
		end

		if edit_window_state.v then
			imgui.ShowCursor = true
			if selacc == -1 then selacc = 1 end
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 5, imgui.GetIO().DisplaySize.y / 7), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(u8'��������� ������ ��������', edit_window_state, 64)
			imgui.Text(u8'������� ������ ��������: '..selacc)
			imgui.InputText(u8'������� TOTP code (gauth)', accounts_buffs[selacc]['gauth']) imgui.SameLine()
			ShowHelpMarker(u8'����� ������� ���� ��������������, ������� nil')
			imgui.InputText(u8'������� ��� �� �����', accounts_buffs[selacc]['code']) imgui.SameLine()
			ShowHelpMarker(u8'����� ������� ��� �� �����, ������� nil\n- �� �������� ������������ ��� ���-���') imgui.SameLine()
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(350) if imgui.Button(u8'���������') then
				if accounts_buffs[selacc]['gauth'].v == "" then xuypoimidlyachecgo['gauth'] = "nil" else
				accounts[selacc]['gauth'] = accounts_buffs[selacc]['gauth'].v end
				if accounts_buffs[selacc]['code'].v == "" then xuypoimidlyachecgo['code'] = "nil" else
				accounts[selacc]['code'] = accounts_buffs[selacc]['code'].v end
				edit_window_state.v = false
				autosave()
				loadacc()
			end
			imgui.End()
		end

		if add_window_state.v then
			imgui.ShowCursor = true
			
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 5, imgui.GetIO().DisplaySize.y / 7), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

			imgui.Begin(u8'��������� ������ �������� ', add_window_state, 64)
			ip, port = sampGetCurrentServerAddress()
			imgui.Text(u8'������� ������ ��������: '..selacc)
			imgui.Text(u8'������� ���-����: ') imgui.SameLine(150)
			imgui.InputText('##Nick', accounts_buffs[selacc]['user_name']) imgui.SameLine()
			if imgui.Button(u8' �������') then
				accounts_buffs[selacc]['user_name'].v = sampGetPlayerNickname(clientId)
			end
			imgui.Text(u8'������� ������: ') imgui.SameLine(150)
			imgui.InputText('##pass', accounts_buffs[selacc]['user_password'])
			imgui.Text(u8'������� �� �������: ') imgui.SameLine(150)
			imgui.InputText('##ip', accounts_buffs[selacc]['server_ip']) imgui.SameLine()
			if imgui.Button(u8'�������') then
				accounts_buffs[selacc]['server_ip'].v = ip
				accounts_buffs[selacc]['server_port'].v = port..""
			end imgui.SameLine()
			if imgui.Button(u8'�������')  then
				server_window_state.v = not server_window_state.v
			end
			imgui.Text(u8'������� ���� �������: ') imgui.SameLine(150)
			imgui.InputText('##Port', accounts_buffs[selacc]['server_port'])
			imgui.NewLine()
			imgui.SameLine(305) if imgui.Button(u8'���������') then
				accounts[selacc]['user_name'] = accounts_buffs[selacc]['user_name'].v
				accounts[selacc]['user_password'] = accounts_buffs[selacc]['user_password'].v
				accounts[selacc]['server_ip'] = accounts_buffs[selacc]['server_ip'].v
				accounts[selacc]['server_port'] = accounts_buffs[selacc]['server_port'].v
				autosave()
				add_window_state.v = not add_window_state.v
			end

			imgui.End()

		end

		if pass_window_state.v then
			imgui.ShowCursor = true
			if savepass == "" then
				pass_window_state.v = false
			end
			ip, port = sampGetCurrentServerAddress()
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x - 185, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(255, 292), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'���������� ������', main_windows_state, 2)
			imgui.NewLine() imgui.NewLine() imgui.SameLine(25)
			imgui.Text(u8'�������: '..sampGetPlayerNickname(clientId))
			imgui.NewLine() imgui.NewLine() imgui.SameLine(25)
			imgui.Text(u8'������: ') imgui.SameLine()
			if showpass.v == false then imgui.Text(u8'******') else imgui.Text(savepass) end
			imgui.SameLine() imgui.Checkbox('##22', showpass) imgui.SameLine() ShowHelpMarker(u8'�������� ��� ������ ������.')
			imgui.NewLine() imgui.NewLine() imgui.SameLine(25)
			--imgui.Text(u8'������: '..ip..":"..port)
			vv = false
			for i2, v2 in ipairs(serv) do
				for i3, v3 in ipairs(v2['list']) do
					if reip.v == v3['ip'] and report.v == v3['port'] then
					imgui.Text(u8'������: '..v2['title'].." | "..v3['name']..'.')
					vv = true
					break
				end
				end
			end -- ����� ������ �� ������, � ���� ���� �����
			if vv == false then
				imgui.Text(u8'������: '..ip..":"..port)
			end
			imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.SameLine(125)
			if imgui.Button(u8'������') then pass_window_state.v = not pass_window_state.v savepass = "" regstape = false end
			imgui.SameLine()
			if imgui.Button(u8'��������') then
					local fpath = getWorkingDirectory()..'\\config\\KopnevScripts\\accounts.json'
					if doesFileExist(fpath) then
						local f = io.open(fpath, 'w+')
						if f then
							ip, port = sampGetCurrentServerAddress()
							local temptable = {
								user_name         = imgui.ImBuffer(64),
								user_password     = imgui.ImBuffer(64),
								server_ip         = imgui.ImBuffer(128),
								server_port       = imgui.ImBuffer(16),
								gauth             = imgui.ImBuffer(64),
								code              = imgui.ImBuffer(16),
							}
							temptable['user_name'].v         = sampGetPlayerNickname(clientId)
							temptable['user_password'].v     = savepass
							temptable['server_ip'].v         = ip
							temptable['server_port'].v       = port..""
							temptable['gauth'].v         			= "nil"
							temptable['gauth'].v         			= "code"
							table.insert(accounts_buffs, temptable)
							table.insert(accounts, {
								user_name         = sampGetPlayerNickname(clientId),
								user_password     = savepass,
								server_ip         = ip,
								server_port       = port.."",
								gauth             = "nil",
								code              = "nil",
							})
							local tJSON = encodeJson(accounts)
							if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
								f:write(tJSON)
								f:close()
							else
								SCM("������ ������ JSON �������. ���������� ��� ���")
							end
							selacc = #accounts
						else
							SCM(u8'���-�� ����� �� ��� :(')
						end
					else
						SCM(u8'���-�� ����� �� ��� :(')
					end
				loadacc()

				pass_window_state.v = not pass_window_state.v
				savepass = ""
				regstape = false
			end
			imgui.End()
		end

		if code_window_state.v then
			imgui.ShowCursor = true
			ip, port = sampGetCurrentServerAddress()
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x - 185, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(255, 292), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'���������� ����', main_windows_state, 2)
			imgui.NewLine() imgui.NewLine() imgui.SameLine(25)
			imgui.Text(u8'�������: '..sampGetPlayerNickname(clientId))
			imgui.NewLine() imgui.NewLine() imgui.SameLine(25)
			imgui.Text(u8'���: ') imgui.SameLine()
			if showcode.v == false then imgui.Text(u8'******') else imgui.Text(savecode) end
			imgui.SameLine() imgui.Checkbox('##223', showcode) imgui.SameLine() ShowHelpMarker(u8'�������� ��� ������ ���.')
			imgui.NewLine() imgui.NewLine() imgui.SameLine(25)
			--imgui.Text(u8'������: '..ip..":"..port)
			vv = false
			for i2, v2 in ipairs(serv) do
				for i3, v3 in ipairs(v2['list']) do
					if reip.v == v3['ip'] and report.v == v3['port'] then
					imgui.Text(u8'������: '..v2['title'].." | "..v3['name']..'.')
					vv = true
					break
				end
				end
			end -- ����� ������ �� ������, � ���� ���� �����
			if vv == false then
				imgui.Text(u8'������: '..ip..":"..port)
			end
			imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.SameLine(125)
			if imgui.Button(u8'������') then code_window_state.v = false end
			imgui.SameLine()
			if imgui.Button(u8'��������') then
					account_info['code'] =  savecode
					autosave()
					loadacc()
					code_window_state.v = false
			end
			imgui.End()
		end

		if gadd_window.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 9, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(170, 210), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'���� ��������������', gadd_window, 2)
			imgui.Text(u8'��� ��������� TOTP ���:')
			imgui.PushItemWidth(150)   imgui.InputText(u8'##ga', gauthcode) imgui.PopItemWidth()
			imgui.NewLine()
			if imgui.Button(u8'������������� ���') then gen = true end
			if gen == true then
				imgui.NewLine()
				imgui.Text(u8"��� ���:  "..genCode(gauthcode.v))
				imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.SameLine(100)
				if imgui.Button(u8'��������') then
					account_info['gauth'] = gauthcode.v
					SCM('��� ������� ��������')
					autosave()
				end
				else
				imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.SameLine(100)
				if imgui.Button(u8'��������') then
					account_info['gauth'] = gauthcode.v
					SCM('��� ������� ��������')
					autosave()
				end
				end
			imgui.End()
		end

		if server_window_state.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 1.55, imgui.GetIO().DisplaySize.y / 13), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(u8'����� �������', server_window_state, 64)
			imgui.BeginGroup()
				imgui.BeginChild('Server', imgui.ImVec2(140, 200), true)
				for i, v in ipairs(serv) do
					if imgui.Button(v['projectname'], imgui.ImVec2(120, 20)) then
						mq()
						servers[1] = true
						ss = i
					end
				end
				imgui.EndChild()
			imgui.EndGroup()

			imgui.SameLine(165)

			if servers[1] == true then
				imgui.BeginGroup()
					for i, v in ipairs(serv[ss]['list']) do
						if imgui.Button(serv[ss]['title'].." | "..v['name'], imgui.ImVec2(150, 20)) then
								if add_window_state.v == true then
									accounts_buffs[selacc]['server_ip'].v = v['ip']
									accounts_buffs[selacc]['server_port'].v = v['port']
								end
								if vkladki[2] == true then
									reip.v = v['ip']
									report.v = v['port']
								end
						end
					end

				imgui.EndGroup()
			end
			imgui.End()
		end

		if bind_window.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(400, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(' ', bind_window, 2)
			
			imgui.SameLine(150)
			imgui.Text(u8'����� / �������')
			imgui.NewLine()
			--imgui.NewLine()
			--imgui.SameLine(25)
			imgui.BeginGroup()
				
				imgcombo()
				
			imgui.EndGroup()
			imgui.End()
		end

		if bindset_window.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowSize(imgui.ImVec2(350, 150), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin('  ', bindset_window, 2)
			imgui.SameLine(110)
			imgui.Text(u8'��������� ��������')
				setbind()
			imgui.End()
		end

		if loop_window.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowSize(imgui.ImVec2(350, 140), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(u8'��������� ��������', loop_window, 2)
			imgui.NewLine()
			imgui.NewLine()
			imgui.SameLine(15) imgui.Text(u8'��������� ��������:') imgui.SameLine(150) 
			imgui.PushItemWidth(190) 
			if imgui.InputInt('sec ', d_loop, 1) then
				ini.settings.d_loop = d_loop.v
				inicfg.save(def, directIni)
			end
			imgui.PopItemWidth()
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(15) imgui.Text(u8'��������������� �����:') imgui.SameLine(170) 
			if imadd.ToggleButton("##helptext", helptext) then
				ini.settings.helptext = helptext.v
				inicfg.save(def, directIni)
			end
			imgui.SameLine() ShowHelpMarker(u8'����� �� ��� ����� ������ �������� ������������ ���: "�������, ������ ����� � ������" ��� "�����, ������ ����� � �������"')
			imgui.SetCursorPos(imgui.ImVec2(260, 110))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				loop_window.v = false
			end
			imgui.End()
		end

		if autologin_window.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(400, 350), imgui.Cond.FirstUseEver)
			imgui.Begin('##autologin', autologin_window, 2)
			
			imgui.SameLine(130)
			imgui.Text(u8'��������� ����-������')
			imgui.NewLine()
			imgui.NewLine()
			--imgui.SameLine(25)
			imgui.BeginGroup()
				imgui.Separator() imgui.NewLine() imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������������� ������� ������:') imgui.SameLine(250)
				if imadd.ToggleButton(u8'##autopass', autopass) then
					ini.settings.autopass = autopass.v
					inicfg.save(def, directIni)
				end imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������������� ������� GAuth:') imgui.SameLine(250)
				if imadd.ToggleButton(u8'##autogcode', autogcode) then
					ini.settings.autogcode = autogcode.v
					inicfg.save(def, directIni)
				end imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������������� ������� ���:') imgui.SameLine(250)
				if imadd.ToggleButton(u8'##autocode', autocode) then
					ini.settings.autocode = autocode.v
					inicfg.save(def, directIni)
				end
				imgui.NewLine() imgui.Separator() imgui.NewLine() imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������� ������ �:') imgui.SameLine(195)
				imgui.PushItemWidth(120)
				if imgui.Combo('##ent', typeent, enter) then
					ini.settings.typeent = typeent.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				if typeent.v == 1 then
					--imgui.InputText(u8'������� TOTP code (gauth)', accounts_buffs[selacc]['gauth'])
					imgui.NewLine()
					imgui.SameLine(25) imgui.Text(u8'����� ������� �������:') imgui.SameLine(195)
					imgui.PushItemWidth(120)
					imgui.InputText(u8'##typecmd', cmdent)
					imgui.PopItemWidth()
					imgui.SameLine() ShowHelpMarker(u8'����� ��������� � ���: '..cmdent.v..u8" supersecretpass. ��� ������� ��� ����-��������")
				end
				imgui.SetCursorPos(imgui.ImVec2(300, 310))
			if imgui.Button(u8"�������", imgui.ImVec2(80, 25)) then 
				autologin_window.v = false
			end
			imgui.EndGroup()
			imgui.End()
		end

		if error_window.v then
            imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(300, 200), imgui.Cond.FirstUseEver)
            imgui.Begin(u8'Connect Tool | error', error_window, 2)
            imgui.Text(u8'��� ���������� ������, ��������� ��������� ')
            imgui.Text(u8'��������� ����������:')
			imgui.NewLine()
			
			if not limadd then imgui.Text(u8'Imgui Addons') end
            if not lrkeys then imgui.Text(u8'RKeys') end
            if not lfa then imgui.Text(u8'Font Awesome Icons') end
			if not lsha1 then imgui.Text(u8'sha1') end
			if not lbasexx then imgui.Text(u8'basexx') end

            imgui.SetCursorPos(imgui.ImVec2(220, 170))
			if imgui.Button(u8'����������', imgui.ImVec2(75, 25)) then
                lua_thread.create(function() 
                    libs_dwn_status = "proccess"
                    succ1 = false
                    succ2 = false
                    succ3 = false
					succ4 = false
					succ5 = false
					succ6 = false
					succ7 = false
                    if not lrkeys then
                        libs_dwn = downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/rkeys.lua", "moonloader/lib/rkeys.lua", function(id, status, p1, p2) 
                            if status == dlstatus.STATUS_DOWNLOADINGDATA then
                                libs_dwn_status = 'proccess'
                                SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
                            elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                libs_dwn_status = 'succ'
                                succ1 = true
                                SCM('rkeys.lua ������� ��������')
                            elseif status == 64 then
                                libs_dwn_status = 'failed'
                            end
                        end)    
                    end
                    if not lfa then
                        if not lrkeys then
                            repeat
                                wait(0)
                            until libs_dwn_status ~= 'proccess'
                        end
                        if libs_dwn_status == "failed" then SCM('��������� ������ ��� �������� ����������.') thisScript():unload() end -- https://raw.githubusercontent.com/danil8515/Script-Manager/master/resource/fonts/fa-solid-900.ttf
                        libs_dwn = downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/faIcons.lua", "moonloader/lib/faIcons.lua", function(id, status, p1, p2) 
                            if status == dlstatus.STATUS_DOWNLOADINGDATA then
                                libs_dwn_status = 'proccess'
                                SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
                            elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                libs_dwn_status = 'succ'
                                succ2 = true
                                SCM('faIcons.lua ������� ��������')
                            elseif status == 64 then
                                libs_dwn_status = 'failed'
                            end
                        end)
                        if libs_dwn_status == "failed" then SCM('��������� ������ ��� �������� ����������.') thisScript():unload() end
                        repeat
                            wait(0)
                        until libs_dwn_status ~= 'proccess' and succ2
                        if not doesDirectoryExist('moonloader/resource/fonts/') then 
                            res = createDirectory('moonloader/resource/fonts/')
                            if not res then SCM('������ ��� �������� ����������.') thisScript():unload() end
                        end
                        if not doesFileExist('moonloader/resource/fonts/fontawesome-webfont.ttf') then
                            libs_dwn = downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/resource/fonts/fontawesome-webfont.ttf", "moonloader/resource/fonts/fontawesome-webfont.ttf", function(id, status, p1, p2) 
                                if status == dlstatus.STATUS_DOWNLOADINGDATA then
                                    libs_dwn_status = 'proccess'
                                    SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
                                elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                    libs_dwn_status = 'succ'
                                    succ3 = true
                                    SCM('fontawesome-webfont.ttf ������� ��������')
                                elseif status == 64 then
                                    libs_dwn_status = 'failed'
                                    print('fail')
                                end
                            end)
                        else succ3 = true end
                    end
                    if not limadd then
                        if not lrkeys or not lfa then
                            repeat
                                wait(0)
                            until libs_dwn_status ~= 'proccess'
                        end
                        if libs_dwn_status == "failed" then SCM('��������� ������ ��� �������� ����������.') thisScript():unload() end
                        libs_dwn = downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/imgui_addons.lua", "moonloader/imgui_addons.lua", function(id, status, p1, p2) 
                            if status == dlstatus.STATUS_DOWNLOADINGDATA then
                                libs_dwn_status = 'proccess'
                                SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
                            elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                libs_dwn_status = 'succ'
                                succ4 = true
                                SCM('imgui_addons.lua ������� ��������')
                            elseif status == 64 then
                                libs_dwn_status = 'failed'
                            end
                        end)
					end
					if not lsha1 then
                        if not lrkeys or not lfa or not limadd then
                            repeat
                                wait(0)
                            until libs_dwn_status ~= 'proccess'
                        end
                        if libs_dwn_status == "failed" then SCM('��������� ������ ��� �������� ����������.') thisScript():unload() end
                        libs_dwn = downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/sha1.lua", "moonloader/lib/sha1.lua", function(id, status, p1, p2) 
                            if status == dlstatus.STATUS_DOWNLOADINGDATA then
                                libs_dwn_status = 'proccess'
                                SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
                            elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                libs_dwn_status = 'succ'
                                succ5 = true
                                SCM('sha1.lua ������� ��������')
                            elseif status == 64 then
                                libs_dwn_status = 'failed'
                            end
                        end)
					end
					if not lbasexx then
                        if not lrkeys or not lfa or not limadd or not lsha1 then
                            repeat
                                wait(0)
                            until libs_dwn_status ~= 'proccess'
                        end
                        if libs_dwn_status == "failed" then SCM('��������� ������ ��� �������� ����������.') thisScript():unload() end
                        libs_dwn = downloadUrlToFile("https://raw.githubusercontent.com/danil8515/Connect-Tool/master/lib/basexx.lua", "moonloader/lib/basexx.lua", function(id, status, p1, p2) 
                            if status == dlstatus.STATUS_DOWNLOADINGDATA then
                                libs_dwn_status = 'proccess'
                                SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
                            elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                libs_dwn_status = 'succ'
                                succ6 = true
                                SCM('basexx.lua ������� ��������')
                            elseif status == 64 then
                                libs_dwn_status = 'failed'
                            end
                        end)
					end
					if not doesFileExist('resetRemove.asi') then -- ��������������� ��� �����. https://blast.hk/threads/18967/
						if not lrkeys or not lfa or not limadd or not lsha1 or not lbasexx then
                            repeat
                                wait(0)
                            until libs_dwn_status ~= 'proccess'
                        end
						downloadUrlToFile("https://github.com/danil8515/Connect-Tool/blob/master/resetRemove.asi?raw=true", "resetRemove.asi", function(id, status, p1, p2) 
							if status == dlstatus.STATUS_DOWNLOADINGDATA then
								libs_dwn_status = 'proccess'
								SCM(string.format('��������� %d �������� �� %d ��������.', p1, p2))
							elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
								libs_dwn_status = 'succ'
								SCM('resetRemove.asi ������� ��������')
								SCM('��� ���������� ������, ��������� ������������ ����')
								succ7 = true
							elseif status == 64 then
								libs_dwn_status = 'failed'
							end
						end)
					end
                    repeat
                        wait(0)
                    until libs_dwn_status ~= 'proccess'
                    if libs_dwn_status == "failed" then SCM('��������� ������ ��� �������� ����������.') thisScript():unload() end
                    if not lrkeys and not succ1 then
                        while not succ1 do wait(0) end
                    end
                    if not lfa and not succ2 then
                        while not succ2 do wait(0) end
                    end
                    if not lfa and not succ3 then
                        while not succ3 do wait(0) end
                    end
                    if not limadd and not succ4 then
                        while not succ4 do wait(0) end
					end
					if not lsha1 and not succ5 then
                        while not succ5 do wait(0) end
					end
					if not lbasexx and not succ6 then
                        while not succ6 do wait(0) end
					end
					if not doesFileExist('resetRemove.asi') and not succ7 then
						while not succ7 do wait(0) end
					end
					SCM('���������� ������� ���������. ������������...')
					ini.settings.reload = true
					inicfg.save(def, directIni)
					thisScript():reload()
                end)
            end

            imgui.SetCursorPos(imgui.ImVec2(142, 170))
            if imgui.Button(u8'������', imgui.ImVec2(75, 25)) then thisScript():unload() end
            imgui.End()
        end
	end

	function customServWindow()
		imgui.ShowCursor = true
		imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(550, 800), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'�������������� �������', customServ_window, 2)
			imgui.BeginChild('##serverslistedit', imgui.ImVec2(535, 760), true) 
				imgui.Text(u8"��������� �������������� �������:") imgui.SameLine(409) 
				if imgui.Button(u8"����������������") then
					if not doesDirectoryExist('moonloader/config/KopnevScripts/') then createDirectory('moonloader/config/KopnevScripts/') end
					if doesFileExist("moonloader/config/KopnevScripts/servers.ctool") then os.remove("moonloader/config/KopnevScripts/servers.ctool") end

					lua_thread.create(function()
						downloadUrlToFile("https://pastebin.com/raw/E3i0w6W8", "moonloader/config/KopnevScripts/servers.ctool", function(id, status, p1, p2)
							if status == dlstatus.STATUS_ENDDOWNLOADDATA then
								if status == dlstatus.STATUS_DOWNLOADINGDATA then
									SCM(string.format('��������� %d ���� �� %d ����', p1, p2))
								elseif status == dlstatus.STATUS_ENDDOWNLOADDATA then
									if not doesFileExist('moonloader/config/KopnevScripts/servers.ctool') then
										local fpath = "moonloader/config/KopnevScripts/servers.ctool"
										local tJSON = encodeJson(serv)
										if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
											local f = io.open(fpath, "w")
											f:write(tJSON)
											f:close()
											SCM("������ �������������. ���������� ��� ���. ���: Error sync")
										else
											SCM("������ �������������. ���������� ��� ���. ���: Error JSON")
										end
									else
										local fpath = "moonloader/config/KopnevScripts/servers.ctool"
										local f = io.open(fpath, "r")
										serv = decodeJson(f:read"*a")
										f:close()
										SCM("������� ������� ����������������")
									end
								end
							end
						end)
						return
					end)
				end
				for i, v in ipairs(serv) do
					if imgui.CollapsingHeader(u8(v['projectname'])) then
						local sizeY = 60 + ( #serv[i]["list"] * 26 )
						imgui.BeginChild('child'..i, imgui.ImVec2(515, sizeY), true)
							if imgui.Button(u8"�������� ������ � �������: "..v['projectname'], imgui.ImVec2(495, 20)) then
								imgui.OpenPopup(u8'���������� ������� � ������� '..v['projectname'])	
							end
							if imgui.BeginPopupModal(u8'���������� ������� � ������� '..v['projectname'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
								imgui.Text(u8"������� ������ ������ �������:")
								imgui.NewLine()
								imgui.Text(u8"�������� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##nameserv"..i, customServ_AddServToProject_Name) imgui.PopItemWidth()
								imgui.Text(u8"�� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##ipserv"..i, customServ_AddServToProject_IP) imgui.PopItemWidth()
								imgui.Text(u8"���� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##portserv"..i, customServ_AddServToProject_Port) imgui.PopItemWidth()
								imgui.NewLine()
								if imgui.Button(u8"�������", imgui.ImVec2(200,20)) then
									imgui.CloseCurrentPopup()
								end
								imgui.SameLine() 
								if imgui.Button(u8"���������", imgui.ImVec2(200,20)) then
									local t = {
										name = customServ_AddServToProject_Name.v,
										ip = customServ_AddServToProject_IP.v,
										port = customServ_AddServToProject_Port.v
									}
									table.insert(v['list'], t)
									imgui.CloseCurrentPopup()
								end
								imgui.EndPopup()
							end
							imgui.Columns(3, 'ofserv'..i)
							imgui.Separator()
							imgui.Text(u8'��� �������') imgui.NextColumn()
							imgui.Text(u8'��:����') imgui.NextColumn()
							imgui.Text(u8'��������') imgui.NextColumn()
							imgui.Separator()
							for i2, v2 in ipairs(v['list']) do
								imgui.Text(v2['name']) imgui.NextColumn()
								imgui.Text(v2['ip']..":"..v2['port']) imgui.NextColumn()
								if imgui.Button(u8"��������##"..v2['name']..v['projectname']) then
									imgui.OpenPopup(u8'��������� �������: '..v['projectname'].." | "..v2['name'])
									customServ_AddServToProject_Name.v = v2['name']
									customServ_AddServToProject_IP.v = v2['ip']
									customServ_AddServToProject_Port.v = v2['port']
								end
								if imgui.BeginPopupModal(u8'��������� �������: '..v['projectname'].." | "..v2['name'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
									imgui.Text(u8"������� ������ �������:")
									imgui.NewLine()
									imgui.Text(u8"�������� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##nameserv"..i, customServ_AddServToProject_Name) imgui.PopItemWidth()
									imgui.Text(u8"�� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##ipserv"..i, customServ_AddServToProject_IP) imgui.PopItemWidth()
									imgui.Text(u8"���� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##portserv"..i, customServ_AddServToProject_Port) imgui.PopItemWidth()
									imgui.NewLine()
									if imgui.Button(u8"�������", imgui.ImVec2(200,20)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine() 
									if imgui.Button(u8"���������", imgui.ImVec2(200,20)) then
										v2['name'] = customServ_AddServToProject_Name.v
										v2['ip'] = customServ_AddServToProject_IP.v
										v2['port'] = customServ_AddServToProject_Port.v
										imgui.CloseCurrentPopup()
									end
									imgui.EndPopup()
								end
								imgui.SameLine()
								if imgui.Button(u8"�������##"..v2['name']..v['projectname']) then
									imgui.OpenPopup(u8'�������� �������: '..v['projectname'].." | "..v2['name'])
								end
								if imgui.BeginPopupModal(u8'�������� �������: '..v['projectname'].." | "..v2['name'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
									imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8'��������!')
									imgui.Text(u8'���� �� ������� ������, �� ��������� �� ������ ������ �������� �� �����')
									imgui.Text(u8'�� ������������� ������ ������� ������?')
									imgui.NewLine()
									if imgui.Button(u8'������', imgui.ImVec2(250, 25)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(u8'�������', imgui.ImVec2(250, 25)) then
										table.remove(v['list'], i2)
									end
									imgui.EndPopup()
								end
								imgui.Separator()
								imgui.NextColumn()
							end
						imgui.EndChild()
					end
				end
				imgui.Separator()
				imgui.NewLine()

				imgui.Text(u8"���������������� �������:") 
				imgui.SameLine(409) 
				if imgui.Button(u8" �������� ������  ") then
					imgui.OpenPopup(u8"���������� ������ �������")
					customServ_AddProject_projectname.v = ""
					customServ_AddProject_title.v = ""
					customServ_Orient_Auth_INT.v = 0
					customServ_Orient_Auth_ID.v = 0
					customServ_Orient_Auth_title.v = ""
					customServ_Orient_Auth_text.v = ""

					customServ_Orient_GAuth_INT.v = 0
					customServ_Orient_GAuth_ID.v = 0
					customServ_Orient_GAuth_title.v = ""
					customServ_Orient_GAuth_text.v = ""

					customServ_Orient_Pin_INT.v = 0
					customServ_Orient_Pin_ID.v = 0
					customServ_Orient_Pin_title.v = ""
					customServ_Orient_Pin_text.v = ""
				end
				if imgui.BeginPopupModal(u8'���������� ������ �������', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
					imgui.Text(u8"������� ������ ������ �������:")
					imgui.NewLine()
					imgui.Text(u8"������ ��������:  ") imgui.SameLine(160) imgui.PushItemWidth(240)  imgui.InputText("##namepr", customServ_AddProject_projectname) imgui.PopItemWidth() 
					imgui.SameLine() ShowHelpMarker(u8"������: Arizona Role Play")
					imgui.Text(u8"�������� ��������:  ") imgui.SameLine(160) imgui.PushItemWidth(240)  imgui.InputText("##ippr", customServ_AddProject_title) imgui.PopItemWidth()
					imgui.SameLine() ShowHelpMarker(u8"������: Arizona RP")
					imgui.NewLine()
					-------------------------------------------------------------------------------------------------
					imgui.Separator()
					imgui.NewLine()
					imgui.Text(u8"������ ������� �����������: ")
					imgui.NewLine()
					imgui.Text(u8"��������������� ��:") imgui.SameLine(160)
					imgui.PushItemWidth(260)
					imgui.Combo('##orient', customServ_Orient_Auth_INT, customServ_Orient)
					imgui.PopItemWidth()
					if customServ_Orient_Auth_INT.v == 0 then
						imgui.Text(u8"������� ID �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputInt("##customServ_Orient_Auth_ID", customServ_Orient_Auth_ID,0) imgui.PopItemWidth()
					end
					if customServ_Orient_Auth_INT.v == 1 then
						imgui.Text(u8"��������� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Auth_title", customServ_Orient_Auth_title) imgui.PopItemWidth()
					end
					if customServ_Orient_Auth_INT.v == 2 then
						imgui.Text(u8"������� ����� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Auth_text", customServ_Orient_Auth_text) imgui.PopItemWidth()
					end
					imgui.NewLine()
					-------------------------------------------------------------------------------------------------
					imgui.Separator()
					imgui.NewLine()
					imgui.Text(u8"������ ������� GAuth: ")
					imgui.NewLine()
					imgui.Text(u8"��������������� ��:") imgui.SameLine(160)
					imgui.PushItemWidth(260)
					imgui.Combo('##orient2', customServ_Orient_GAuth_INT, customServ_Orient)
					imgui.PopItemWidth()
					if customServ_Orient_GAuth_INT.v == 0 then
						imgui.Text(u8"������� ID �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputInt("##customServ_Orient_GAuth_ID", customServ_Orient_GAuth_ID,0) imgui.PopItemWidth()
					end
					if customServ_Orient_GAuth_INT.v == 1 then
						imgui.Text(u8"��������� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_GAuth_title", customServ_Orient_GAuth_title) imgui.PopItemWidth()
					end
					if customServ_Orient_GAuth_INT.v == 2 then
						imgui.Text(u8"������� ����� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_GAuth_text", customServ_Orient_GAuth_text) imgui.PopItemWidth()
					end
					imgui.NewLine()
					-------------------------------------------------------------------------------------------------
					imgui.Separator()
					imgui.NewLine()
					imgui.Text(u8"������ ������� ���-���: ")
					imgui.NewLine()
					imgui.Text(u8"��������������� ��:") imgui.SameLine(160)
					imgui.PushItemWidth(260)
					imgui.Combo('##orient3', customServ_Orient_Pin_INT, customServ_Orient)
					imgui.PopItemWidth()
					if customServ_Orient_Pin_INT.v == 0 then
						imgui.Text(u8"������� ID �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputInt("##customServ_Orient_Pin_ID", customServ_Orient_Pin_ID,0) imgui.PopItemWidth()
					end
					if customServ_Orient_Pin_INT.v == 1 then
						imgui.Text(u8"��������� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Pin_title", customServ_Orient_Pin_title) imgui.PopItemWidth()
					end
					if customServ_Orient_Pin_INT.v == 2 then
						imgui.Text(u8"������� ����� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Pin_text", customServ_Orient_Pin_text) imgui.PopItemWidth()
					end
					imgui.NewLine()
					-------------------------------------------------------------------------------------------------
					if imgui.Button(u8"�������", imgui.ImVec2(200,20)) then
						imgui.CloseCurrentPopup()
					end
					imgui.SameLine() 
					if imgui.Button(u8"���������", imgui.ImVec2(200,20)) then
						local t = {
							projectname = customServ_AddProject_projectname.v,
							title = customServ_AddProject_title.v,
							-------------------------------------------------
							-------------------------------------------------
							Orient_Auth_INT = customServ_Orient_Auth_INT.v,
							Orient_Auth_ID = customServ_Orient_Auth_ID.v,
							Orient_Auth_title = customServ_Orient_Auth_title.v,
							Orient_Auth_text = customServ_Orient_Auth_text.v,
							-------------------------------------------------
							Orient_GAuth_INT = customServ_Orient_GAuth_INT.v,
							Orient_GAuth_ID = customServ_Orient_GAuth_ID.v,
							Orient_GAuth_title = customServ_Orient_GAuth_title.v,
							Orient_GAuth_text = customServ_Orient_GAuth_text.v,
							-------------------------------------------------
							Orient_Pin_INT = customServ_Orient_Pin_INT.v,
							Orient_Pin_ID = customServ_Orient_Pin_ID.v,
							Orient_Pin_title = customServ_Orient_Pin_title.v,
							Orient_Pin_text = customServ_Orient_Pin_text.v,
							-------------------------------------------------
							-------------------------------------------------
							list = {}
						}
						table.insert(customServ, t)
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
				for i, v in ipairs(customServ) do
					if imgui.CollapsingHeader(v['projectname']) then
						local sizeY = 60 + ( #customServ[i]["list"] * 26 )
						imgui.BeginChild('child2'..i, imgui.ImVec2(515, sizeY), true)
							if imgui.Button(u8"�������� ������ � �������", imgui.ImVec2(240, 20)) then
								imgui.OpenPopup(u8'���������� ������� � ������� '..v['projectname'])	
								customServ_AddServToProject_Name.v = ""
								customServ_AddServToProject_IP.v = ""
								customServ_AddServToProject_Port.v = ""
							end
							imgui.SameLine()
							if imgui.Button(u8"������������� ������", imgui.ImVec2(240, 20)) then
								imgui.OpenPopup(u8'�������������� �������: '..v['projectname'])	
								customServ_AddProject_projectname.v = v['projectname']
								customServ_AddProject_title.v = v['title']
								customServ_Orient_Auth_INT.v = v['Orient_Auth_INT']
								customServ_Orient_Auth_ID.v = v['Orient_Auth_ID']
								customServ_Orient_Auth_title.v = v['Orient_Auth_title']
								customServ_Orient_Auth_text.v = v['Orient_Auth_text']

								customServ_Orient_GAuth_INT.v = v['Orient_GAuth_INT']
								customServ_Orient_GAuth_ID.v = v['Orient_GAuth_ID']
								customServ_Orient_GAuth_title.v = v['Orient_GAuth_title']
								customServ_Orient_GAuth_text.v = v['Orient_GAuth_text']

								customServ_Orient_Pin_INT.v = v['Orient_Pin_INT']
								customServ_Orient_Pin_ID.v = v['Orient_Pin_ID']
								customServ_Orient_Pin_title.v = v['Orient_Pin_title']
								customServ_Orient_Pin_text.v = v['Orient_Pin_text']
							end
							if imgui.BeginPopupModal(u8'���������� ������� � ������� '..v['projectname'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
								imgui.Text(u8"������� ������ ������ �������:")
								imgui.NewLine()
								imgui.Text(u8"�������� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##nameserv"..i, customServ_AddServToProject_Name) imgui.PopItemWidth()
								imgui.Text(u8"�� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##ipserv"..i, customServ_AddServToProject_IP) imgui.PopItemWidth()
								imgui.Text(u8"���� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##portserv"..i, customServ_AddServToProject_Port) imgui.PopItemWidth()
								imgui.NewLine()
								if imgui.Button(u8"�������", imgui.ImVec2(200,20)) then
									imgui.CloseCurrentPopup()
								end
								imgui.SameLine() 
								if imgui.Button(u8"���������", imgui.ImVec2(200,20)) then
									local t = {
										name = customServ_AddServToProject_Name.v,
										ip = customServ_AddServToProject_IP.v,
										port = customServ_AddServToProject_Port.v
									}
									table.insert(v['list'], t)
									imgui.CloseCurrentPopup()
								end
								imgui.EndPopup()
							end
							if imgui.BeginPopupModal(u8'�������������� �������: '..v['projectname'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
								imgui.Text(u8"������� ������ �������:")
								imgui.NewLine()
								imgui.Text(u8"������ ��������:  ") imgui.SameLine(160) imgui.PushItemWidth(240)  imgui.InputText("##namepr", customServ_AddProject_projectname) imgui.PopItemWidth() 
								imgui.SameLine() ShowHelpMarker(u8"������: Arizona Role Play")
								imgui.Text(u8"�������� ��������:  ") imgui.SameLine(160) imgui.PushItemWidth(240)  imgui.InputText("##ippr", customServ_AddProject_title) imgui.PopItemWidth()
								imgui.SameLine() ShowHelpMarker(u8"������: Arizona RP")
								imgui.NewLine()
								-------------------------------------------------------------------------------------------------
								imgui.Separator()
								imgui.NewLine()
								imgui.Text(u8"������ ������� �����������: ")
								imgui.NewLine()
								imgui.Text(u8"��������������� ��:") imgui.SameLine(160)
								imgui.PushItemWidth(260)
								imgui.Combo('##orient', customServ_Orient_Auth_INT, customServ_Orient)
								imgui.PopItemWidth()
								if customServ_Orient_Auth_INT.v == 0 then
									imgui.Text(u8"������� ID �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputInt("##customServ_Orient_Auth_ID", customServ_Orient_Auth_ID,0) imgui.PopItemWidth()
								end
								if customServ_Orient_Auth_INT.v == 1 then
									imgui.Text(u8"��������� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Auth_title", customServ_Orient_Auth_title) imgui.PopItemWidth()
								end
								if customServ_Orient_Auth_INT.v == 2 then
									imgui.Text(u8"������� ����� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Auth_text", customServ_Orient_Auth_text) imgui.PopItemWidth()
								end
								imgui.NewLine()
								-------------------------------------------------------------------------------------------------
								imgui.Separator()
								imgui.NewLine()
								imgui.Text(u8"������ ������� GAuth: ")
								imgui.NewLine()
								imgui.Text(u8"��������������� ��:") imgui.SameLine(160)
								imgui.PushItemWidth(260)
								imgui.Combo('##orient2', customServ_Orient_GAuth_INT, customServ_Orient)
								imgui.PopItemWidth()
								if customServ_Orient_GAuth_INT.v == 0 then
									imgui.Text(u8"������� ID �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputInt("##customServ_Orient_GAuth_ID", customServ_Orient_GAuth_ID,0) imgui.PopItemWidth()
								end
								if customServ_Orient_GAuth_INT.v == 1 then
									imgui.Text(u8"��������� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_GAuth_title", customServ_Orient_GAuth_title) imgui.PopItemWidth()
								end
								if customServ_Orient_GAuth_INT.v == 2 then
									imgui.Text(u8"������� ����� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_GAuth_text", customServ_Orient_GAuth_text) imgui.PopItemWidth()
								end
								imgui.NewLine()
								-------------------------------------------------------------------------------------------------
								imgui.Separator()
								imgui.NewLine()
								imgui.Text(u8"������ ������� ���-���: ")
								imgui.NewLine()
								imgui.Text(u8"��������������� ��:") imgui.SameLine(160)
								imgui.PushItemWidth(260)
								imgui.Combo('##orient3', customServ_Orient_Pin_INT, customServ_Orient)
								imgui.PopItemWidth()
								if customServ_Orient_Pin_INT.v == 0 then
									imgui.Text(u8"������� ID �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputInt("##customServ_Orient_Pin_ID", customServ_Orient_Pin_ID,0) imgui.PopItemWidth()
								end
								if customServ_Orient_Pin_INT.v == 1 then
									imgui.Text(u8"��������� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Pin_title", customServ_Orient_Pin_title) imgui.PopItemWidth()
								end
								if customServ_Orient_Pin_INT.v == 2 then
									imgui.Text(u8"������� ����� �������:") imgui.SameLine(160) imgui.PushItemWidth(260)  imgui.InputText("##customServ_Orient_Pin_text", customServ_Orient_Pin_text) imgui.PopItemWidth()
								end
								imgui.NewLine()
								-------------------------------------------------------------------------------------------------
								if imgui.Button(u8"�������", imgui.ImVec2(200,20)) then
									imgui.CloseCurrentPopup()
								end
								imgui.SameLine() 
								if imgui.Button(u8"���������", imgui.ImVec2(200,20)) then
									customServ[i]["projectname"] = customServ_AddProject_projectname.v
									customServ[i]["title"] = customServ_AddProject_title.v
									-------------------------------------------------
									-------------------------------------------------
									customServ[i]["Orient_Auth_INT"] = customServ_Orient_Auth_INT.v
									customServ[i]["Orient_Auth_ID"] = customServ_Orient_Auth_ID.v
									customServ[i]["Orient_Auth_title"] = customServ_Orient_Auth_title.v
									customServ[i]["Orient_Auth_text"] = customServ_Orient_Auth_text.v
									-------------------------------------------------
									customServ[i]["Orient_GAuth_INT"] = customServ_Orient_GAuth_INT.v
									customServ[i]["Orient_GAuth_ID"] = customServ_Orient_GAuth_ID.v
									customServ[i]["Orient_GAuth_title"] = customServ_Orient_GAuth_title.v
									customServ[i]["Orient_GAuth_text"] = customServ_Orient_GAuth_text.v
									-------------------------------------------------
									customServ[i]["Orient_Pin_INT"] = customServ_Orient_Pin_INT.v
									customServ[i]["Orient_Pin_ID"] = customServ_Orient_Pin_ID.v
									customServ[i]["Orient_Pin_title"] = customServ_Orient_Pin_title.v
									customServ[i]["Orient_Pin_text"] = customServ_Orient_Pin_text.v
									-------------------------------------------------
									-------------------------------------------------
									imgui.CloseCurrentPopup()
								end
								imgui.EndPopup()
							end
							imgui.Columns(3, 'ofserv'..i)
							imgui.Separator()
							imgui.Text(u8'��� �������') imgui.NextColumn()
							imgui.Text(u8'��:����') imgui.NextColumn()
							imgui.Text(u8'��������') imgui.NextColumn()
							imgui.Separator()
							for i2, v2 in ipairs(v['list']) do
								imgui.Text(v2['name']) imgui.NextColumn()
								imgui.Text(v2['ip']..":"..v2['port']) imgui.NextColumn()
								if imgui.Button(u8"��������##"..v2['name']..v['projectname']) then
									imgui.OpenPopup(u8'��������� �������: '..v['projectname'].." | "..v2['name'])
									customServ_AddServToProject_Name.v = v2['name']
									customServ_AddServToProject_IP.v = v2['ip']
									customServ_AddServToProject_Port.v = v2['port']
								end
								if imgui.BeginPopupModal(u8'��������� �������: '..v['projectname'].." | "..v2['name'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
									imgui.Text(u8"������� ������ �������:")
									imgui.NewLine()
									imgui.Text(u8"�������� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##nameserv"..i, customServ_AddServToProject_Name) imgui.PopItemWidth()
									imgui.Text(u8"�� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##ipserv"..i, customServ_AddServToProject_IP) imgui.PopItemWidth()
									imgui.Text(u8"���� �������:  ") imgui.SameLine(180) imgui.PushItemWidth(240)  imgui.InputText("##portserv"..i, customServ_AddServToProject_Port) imgui.PopItemWidth()
									imgui.NewLine()
									if imgui.Button(u8"�������", imgui.ImVec2(200,20)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine() 
									if imgui.Button(u8"���������", imgui.ImVec2(200,20)) then
										v2['name'] = customServ_AddServToProject_Name.v
										v2['ip'] = customServ_AddServToProject_IP.v
										v2['port'] = customServ_AddServToProject_Port.v
										imgui.CloseCurrentPopup()
									end
									imgui.EndPopup()
								end
								imgui.SameLine()
								if imgui.Button(u8"�������##"..v2['name']..v['projectname']) then
									imgui.OpenPopup(u8'�������� �������: '..v['projectname'].." | "..v2['name'])
								end
								if imgui.BeginPopupModal(u8'�������� �������: '..v['projectname'].." | "..v2['name'], _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
									imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8'��������!')
									imgui.Text(u8'���� �� ������� ������, �� ��������� �� ������ ������ �������� �� �����')
									imgui.Text(u8'�� ������������� ������ ������� ������?')
									imgui.NewLine()
									if imgui.Button(u8'������', imgui.ImVec2(250, 25)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(u8'�������', imgui.ImVec2(250, 25)) then
										table.remove(v['list'], i2)
									end
									imgui.EndPopup()
								end
								imgui.Separator()
								imgui.NextColumn()
							end
						imgui.EndChild()
					end
				end
			imgui.EndChild()
		imgui.End()
	end

	

	function mainwindow()
		imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(700, 340), imgui.Cond.FirstUseEver)
		imgui.Begin('Connect Tool | version '..thisScript().version , main_windows_state, 2)
		imgui.ShowCursor = true
		imgui.BeginChild('left pane', imgui.ImVec2(150, 0), true)
			if imgui.Button(u8"�������� ���. "..fa.ICON_USER_CIRCLE, imgui.ImVec2(133, 35)) then
				uu()
				vkladki[1] = true
				ini.settings.vkladka = 1
				inicfg.save(def, directIni)
			end
			if imgui.Button(u8"���. ���� "..fa.ICON_ASTERISK, imgui.ImVec2(133, 35)) then
				uu()
				vkladki[3] = true
				ini.settings.vkladka = 3
				inicfg.save(def, directIni)
			end
			if imgui.Button(u8"��������� "..fa.ICON_REFRESH, imgui.ImVec2(133, 35)) then
				uu()
				vkladki[2] = true
				ini.settings.vkladka = 2
				inicfg.save(def, directIni)
			end
			if imgui.Button(u8"��������� "..fa.ICON_COGS, imgui.ImVec2(133, 35)) then
				uu()
				vkladki[4] = true
				ini.settings.vkladka = 4
				inicfg.save(def, directIni)
			end
			if imgui.Button(u8"���������� "..fa.ICON_INFO_CIRCLE, imgui.ImVec2(133, 35)) then
				uu()
				vkladki[5] = true
				ini.settings.vkladka = 5
				inicfg.save(def, directIni)
			end
		imgui.EndChild()
		
		imgui.SameLine(175)

		if vkladki[1] == true then -- �������� ���������
			imgui.BeginGroup()
			imgui.Text(u8'��������:')
			imgui.BeginChild('acc', imgui.ImVec2(0, 150), true)
				imgui.Columns(3, 'mycolumns')
				imgui.Separator()
				imgui.Text(fa.ICON_ID_CARD.. u8'  �������') imgui.NextColumn()
				imgui.Text(fa.ICON_KEY.. u8'  ������') imgui.NextColumn()
				imgui.Text(fa.ICON_SERVER.. u8'  ������') imgui.NextColumn()
				imgui.Separator()
				local g

				for i, v in ipairs(accounts) do
					if srvn.v == 0 then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end
						for i2, v2 in ipairs(customServ) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end
						if vv == false then
							if getServTitle(v['server_ip'], v['server_port']) == "Diamond RP" then
								for i2, v2 in ipairs(serv) do
									for i3, v3 in ipairs(v2['list']) do
										local ip2 = ""
										for i4 in ipairs(ipserv) do
											if v['server_ip'] == ipserv[i4]['ip'] then ip2 = ipserv[i4]['domen'] break end
										end
										if (v['server_ip'] == v3['ip'] or v3['ip'] == ip2 ) and v['server_port'] == v3['port'] then
											imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
											vv = true
											break
										end
									end
								end 
							end
							if vv == false then 
								imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
							end
						end
					end
					if srvn.v == 1 and getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							if vv == false then
								imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
							end
						end
					end
					if srvn.v == 2 and getServTitle(v['server_ip'], v['server_port']) == "Advance RP" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
						end
					end
					if srvn.v == 3 and getServTitle(v['server_ip'], v['server_port']) == "Diamond RP" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								local ip2 = ""
								for i4 in ipairs(ipserv) do
									if v['server_ip'] == ipserv[i4]['ip'] then ip2 = ipserv[i4]['domen'] break end
								end
								if (v['server_ip'] == v3['ip'] or v3['ip'] == ip2 ) and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							if vv == false then
								imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
							end
						end
					end
					if srvn.v == 4 and getServTitle(v['server_ip'], v['server_port']) == "Evolve RP" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
						end
					end
					if srvn.v == 5 and getServTitle(v['server_ip'], v['server_port']) == "Samp RP" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
						end
					end
					if srvn.v == 6 and getServTitle(v['server_ip'], v['server_port']) == "Trinity GTA" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
						end
					end
					if srvn.v == 7 and getServTitle(v['server_ip'], v['server_port']) == "Monser DM" then
						if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
						imgui.NextColumn()
						if ini.settings.spass == true then 
							imgui.Text(v['user_password'])
							imgui.NextColumn() 
						else
							imgui.Text('******')	
							imgui.NextColumn() 
						end
						vv = false
						for i2, v2 in ipairs(serv) do
							for i3, v3 in ipairs(v2['list']) do
								if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
									imgui.Text(v2['title'].." | "..v3['name']) imgui.NextColumn()
									vv = true
									break
								end
							end
						end -- ����� ������ �� ������, � ���� ���� �����
						if vv == false then
							imgui.Text(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
						end
					end
				end
			imgui.EndChild()
			if imgui.Button(fa.ICON_USER_PLUS.. u8'  ��������', imgui.ImVec2(110, 27)) then
				local fpath = getWorkingDirectory()..'\\config\\KopnevScripts\\accounts.json'
				if doesFileExist(fpath) then
					local f = io.open(fpath, 'w+')
					if f then
						ip, port = sampGetCurrentServerAddress()
						local temptable = {
							user_name         = imgui.ImBuffer(64),
							user_password     = imgui.ImBuffer(64),
							server_ip         = imgui.ImBuffer(128),
							server_port       = imgui.ImBuffer(16),
							gauth             = imgui.ImBuffer(64),
							code              = imgui.ImBuffer(16),
						}
						temptable['user_name'].v         = sampGetPlayerNickname(clientId)
						temptable['user_password'].v     = '123456'
						temptable['server_ip'].v         = ip
						temptable['server_port'].v       = port..""
						temptable['gauth'].v             = "nil"
						temptable['code'].v             = "nil"
						table.insert(accounts_buffs, temptable)
						table.insert(accounts, {
							user_name         = sampGetPlayerNickname(clientId),
							user_password     = '123456',
							server_ip         = ip,
							server_port       = port.."",
							gauth             = "nil",
							code              = "nil",
						})
						local tJSON = encodeJson(accounts)
						if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
							f:write(tJSON)
							f:close()
						else
							SCM("������ ������ JSON �������. ���������� ��� ���")
						end
						selacc = #accounts
					else
						SCM('���-�� ����� �� ��� :(')
					end
				else
					SCM('���-�� ����� �� ��� :(')
				end
				add_window_state.v = not add_window_state.v
			end

			if selacc > -1 then
				imgui.SameLine()
				if imgui.Button(fa.ICON_PENCIL.. u8'  ��������', imgui.ImVec2(110, 27)) then
					add_window_state.v = not add_window_state.v
				end 
				imgui.SameLine()
				if imgui.Button(fa.ICON_TRASH.. u8'  �������', imgui.ImVec2(110, 27)) then imgui.OpenPopup(u8"�������������") end imgui.SameLine()
				if imgui.Button(fa.ICON_PLUG.. u8'  ������������', imgui.ImVec2(110, 27)) then
					rename.v = accounts[selacc]['user_name']
					reip.v = accounts[selacc]['server_ip']
					report.v = accounts[selacc]['server_port']
					recon = true
				end
				if selacc ~= -1 then imgui.Text(u8'��������� �������: '..accounts[selacc]['user_name']) end
				imgui.SameLine()
			end
			imgui.NewLine() imgui.NewLine() 
			imgui.Text(u8'����������: ') imgui.SameLine()
			imgui.PushItemWidth(250)
			if imgui.Combo('##serv', srvn, srv)then
				ini.settings.srvn = srvn.v
				inicfg.save(def, directIni)
			end imgui.PopItemWidth()
			imgui.SetCursorPos(imgui.ImVec2(570, 300))
			if imgui.Button(fa.ICON_WINDOW_CLOSE.. u8' �������', imgui.ImVec2(120, 30)) then autosave() main_windows_state.v = false end
			imgui.EndGroup()
		end

		if vkladki[2] == true then -- ���������
				imgui.BeginGroup() 
				imgui.NewLine() imgui.NewLine()
				imgui.SameLine(200) imgui.Text(u8'���������')
				imgui.NewLine() -- ������ �� ��� ������
				imgui.Text(u8'���-����:  ') imgui.SameLine(130) imgui.PushItemWidth(190) imgui.InputText('##11', rename) imgui.PopItemWidth()
				imgui.NewLine() -- ���� � ����
				imgui.Text(u8'��:���� �������:  ') imgui.SameLine(130) imgui.PushItemWidth(120) imgui.InputText('##12', reip) imgui.PopItemWidth()
				imgui.SameLine() imgui.Text(':') imgui.SameLine() imgui.PushItemWidth(57) imgui.InputText('##13', report) imgui.PopItemWidth() imgui.SameLine()
				vv = false
				for i2, v2 in ipairs(serv) do
					for i3, v3 in ipairs(v2['list']) do
						if reip.v == v3['ip'] and report.v == v3['port'] then
						ShowHelpMarker(v2['title'].." | "..v3['name'])
						vv = true
						break
					end
					end
				end -- ����� ������ �� ������, � ���� ���� �����
				if vv == false then
					ShowHelpMarker(u8'����������� ������')
				end imgui.SameLine()
				if imgui.Button(u8'�������') then
					reip.v = ip
					report.v = port..""
				end imgui.SameLine()
				if imgui.Button(u8'�������') then server_window_state.v = not server_window_state.v end
				imgui.NewLine()
				imgui.Text(u8'��������:  ') imgui.SameLine(130) imgui.PushItemWidth(190) 
				if imgui.InputInt('ms ', redelay, 1000) then 
					ini.settings.redelay = redelay.v
					inicfg.save(def, directIni)
				end	
				imgui.PopItemWidth() imgui.SameLine()
				sec = redelay.v / 1000
				ShowHelpMarker(u8'�������� ������� � ������������ (ms). '..redelay.v..' ms = '..sec..u8' ������')
				imgui.NewLine() imgui.NewLine() imgui.SameLine(120)
				if imgui.Button(fa.ICON_BAN.. u8'  �����������') then
					sampDisconnectWithReason(1)
					SCM('�� ��������� �� �������.')
				end imgui.SameLine()
				if imgui.Button(fa.ICON_PLUG.. u8'  ������������') then
					recon = true
				end imgui.SameLine()
				if imgui.Button(fa.ICON_REFRESH) then
					lua_thread.create(function()
						pinganut(reip.v, report.v)
					end)
				end imgui.SameLine() ShowHelpMarker(u8'"���������" - ���� �� ���������� ������� �������, � ��� �� ������������ � ������� (Server didn\'t resopnse), �� ������� ��� ������') imgui.NewLine()  --fa.ICON_REFRESH
				imgui.Text(u8'����� ���� ���: ') imgui.SameLine(130) 
				if imadd.ToggleButton('##recon', reconifkick) then
					ini.settings.reconifkick = reconifkick.v
					inicfg.save(def, directIni)
				end
				if reconifkick.v == true then
					imgui.NewLine()
					imgui.Text(u8'��������:') imgui.SameLine(130) imgui.PushItemWidth(190) 
					if imgui.InputInt('sec', redelayifkick, 10) then
						ini.settings.redelayifkick = redelayifkick.v
						inicfg.save(def, directIni)
					end
					imgui.PopItemWidth() imgui.SameLine()
					min = redelayifkick.v / 60
					ShowHelpMarker(u8'�������� ������� � �������� (sec). '..redelayifkick.v..u8' ������ = '..min..u8' �����')
				end
				imgui.EndGroup()
		end

		if vkladki[3] == true then -- ��� ����
			imgui.BeginGroup()
			imgui.BeginChild('acc', imgui.ImVec2(0, 150), true)
			imgui.Columns(3, 'mycolumns')
			imgui.Separator()
			imgui.Text(fa.ICON_ID_CARD.. u8'  �������') imgui.NextColumn()
			imgui.Text(fa.ICON_GOOGLE.. u8'  GAuth') imgui.NextColumn()
			if srvn.v == 1 then imgui.Text(fa.ICON_CREDIT_CARD.. u8'  ��� �� �����') imgui.SameLine() ShowHelpMarker('for Arizona RP') imgui.NextColumn() else
				if srvn.v == 0 then imgui.Text(fa.ICON_CREDIT_CARD.. u8'  ���-��� / ��� �����') imgui.SameLine() ShowHelpMarker('for Arizona RP') imgui.NextColumn() else
					imgui.Text(fa.ICON_CREDIT_CARD.. u8'  ���-��� ') imgui.NextColumn() 
				end 
			end
			imgui.Separator()
			for i, v in ipairs(accounts) do
				xuypoimidlyachecgo = v
				if srvn.v == 0 then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							if foracc == i then
								imgui.Text(gcode) imgui.NextColumn()
							else imgui.Text(u8'��� �� ������������') imgui.NextColumn() end
						end

					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 1 and getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 2 and getServTitle(v['server_ip'], v['server_port']) == "Advance RP" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 3 and getServTitle(v['server_ip'], v['server_port']) == "Diamond RP" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 4 and getServTitle(v['server_ip'], v['server_port']) == "Evolve RP" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 5 and getServTitle(v['server_ip'], v['server_port']) == "Samp RP" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 6 and getServTitle(v['server_ip'], v['server_port']) == "Trinity RP" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
				if srvn.v == 7 and getServTitle(v['server_ip'], v['server_port']) == "Monser DM" then
					if imgui.Selectable(i..'. '..v['user_name']..'##'..i, selacc == i, 2) then selacc = i end
					imgui.SameLine()
					vv = false
					for i2, v2 in ipairs(serv) do
						for i3, v3 in ipairs(v2['list']) do
							if v['server_ip'] == v3['ip'] and v['server_port'] == v3['port'] then
								ShowHelpMarker(v2['title'].." | "..v3['name']) imgui.NextColumn()
								vv = true
								break
							end
						end
					end

					if vv == false then
						ShowHelpMarker(v['server_ip']..":"..v['server_port']) imgui.NextColumn()
					end

					if v['gauth'] == "nil" then 
						imgui.Text('No GAuth') 
						imgui.NextColumn() 
					else
						if gcode == 0 then imgui.Text(u8'��� �� ������������') imgui.NextColumn() else
							imgui.Text(gcode) imgui.NextColumn()
						end
					end
					if v['code'] == "nil" then 
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							imgui.Text('No bank') 
							imgui.NextColumn() 
						else 
							imgui.Text('No code') 
							imgui.NextColumn()  
						end
					else
						if getServTitle(v['server_ip'], v['server_port']) == "Arizona RP" then
							if ini.settings.spass == true then imgui.Text(v['code']) imgui.NextColumn() else
								imgui.Text("******") imgui.NextColumn()
							end
						else 
							imgui.Text('for Arizona RP') 
							imgui.NextColumn() 
						end
					end
				end
			end
			imgui.EndChild()
			if imgui.Button(fa.ICON_REFRESH.. u8'  �������������', imgui.ImVec2(120, 30)) then
				gcode = genCode( accounts[selacc]['gauth'] )
				foracc = selacc
			end 
			imgui.SameLine()
			if selacc ~= -1 then
				if imgui.Button(fa.ICON_PENCIL.. u8'  �������� ', imgui.ImVec2(120, 30)) then
					accounts_buffs[selacc]['code'].v = accounts[selacc]['code']
					accounts_buffs[selacc]['gauth'].v = accounts[selacc]['gauth']
					edit_window_state.v = true
				end 
				imgui.SameLine()
				if imgui.Button(fa.ICON_TRASH.. u8'  �������', imgui.ImVec2(120, 30)) then imgui.OpenPopup(u8"�������������") end
				imgui.SameLine()
			end
			imgui.NewLine() imgui.NewLine() 
			imgui.Text(u8'����������: ') imgui.SameLine()
			imgui.PushItemWidth(250)
			if imgui.Combo('##serv', srvn, srv)then
				ini.settings.srvn = srvn.v
				inicfg.save(def, directIni)
			end imgui.PopItemWidth()
			imgui.EndGroup()
		end

		if vkladki[4] == true then -- ���������
			imgui.BeginGroup()
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(200)
			imgui.Text(u8'���������')
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(1) imgui.Text(u8'����� ����: ') imgui.SameLine()
			imgui.PushItemWidth(150)
			if imgui.Combo('##theme', tema, items)then
				ini.settings.theme = tema.v
				inicfg.save(def, directIni)
			end imgui.PopItemWidth()
			imgui.SameLine(260)
			imgui.Text(u8'����� �����: ') imgui.SameLine()
			imgui.PushItemWidth(150)
			if imgui.Combo('##style', style, styles)then
				ini.settings.style = style.v
				inicfg.save(def, directIni)
			end imgui.PopItemWidth()
			imgui.NewLine()
			imgui.Text(u8'���������:      ') imgui.SameLine()
			if not bindset_window.v then
				if imadd.HotKey("##active", ActiveMenu, tLastKeys, 100) then
					rkeys.changeHotKey(bindID, ActiveMenu.v)
					SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(ActiveMenu.v), " + "))
					ini.settings.key1 = ActiveMenu.v[1]
					ini.settings.key2 = ActiveMenu.v[2]
					inicfg.save(def, directIni)
				end
			else imgui.NewLine() end
			imgui.NewLine() 
			imgui.Text(u8'���������� ������ � ���:') imgui.SameLine(250)
			if imadd.ToggleButton(u8'##spass', spass) then
				ini.settings.spass = spass.v
				inicfg.save(def, directIni)
			end 
			
			imgui.Text(u8'������ � �������� ������:') imgui.SameLine(250)
			if imadd.ToggleButton(u8'##bg', bg) then
				ini.settings.bg = bg.v
				inicfg.save(def, directIni)
			end
			imgui.Text(u8'����� ���������:') imgui.SameLine(250)
			if imadd.ToggleButton(u8'##invisible', invisible) then
				ini.settings.invisible = invisible.v
				inicfg.save(def, directIni)
			end imgui.SameLine() ShowHelpMarker(u8'��������� �� CTool\'a ����� ���������� �� � ���, � � �������')

			imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine()
			imgui.SameLine(1) if imgui.Button(fa.ICON_UPLOAD ..  u8'   ��������� ����������') then
				-- update()
				SCM("���������� ����������")
			end
			if new == 1 then
				imgui.SameLine()
				if imgui.Button(u8'��������') then
					gou = true
				end
			end
			imgui.SetCursorPos(imgui.ImVec2(523, 168))
			if imgui.Button(u8'�����', imgui.ImVec2(100, 25)) then 
				bind_window.v = not bind_window.v
			end
			imgui.SetCursorPos(imgui.ImVec2(523, 199))
			if imgui.Button(u8'����-�����', imgui.ImVec2(100, 25)) then 
				imgui.OpenPopup(u8"��������� ����-������")
			end
			imgui.SetCursorPos(imgui.ImVec2(523, 261))
			if imgui.Button(u8'�������', imgui.ImVec2(100, 25)) then 
				customServ_window.v = not customServ_window.v
			end
			imgui.SetCursorPos(imgui.ImVec2(523, 230))
			if imgui.Button(u8'ChangeLog', imgui.ImVec2(100, 25)) then 
				imgui.OpenPopup(u8'������ ���������')
			end
			popup_changelog()
			popup_autologin()
			imgui.EndGroup()
		end

		if vkladki[5] == true then -- ����������
			imgui.BeginGroup()
			imgui.NewLine() imgui.NewLine() imgui.NewLine() imgui.NewLine()
			imgui.SameLine(190)
			imgui.Text(u8'����������')
			imgui.NewLine() imgui.NewLine() imgui.NewLine()
			imgui.SameLine(110) imgui.Text(u8'�����: ������ ������')
			imgui.NewLine()
			imgui.SameLine(110) imgui.Text(u8'���� ������: vk.com/kscripts   ')
			imgui.SameLine(310) if imgui.Button(u8'�������') then os.execute('explorer "https://vk.com/kscripts"') end
			imgui.NewLine() imgui.NewLine()

			imgui.SameLine(110) imgui.Text(u8'������ �������: '..thisScript().version)
			if new == 1 then imgui.SameLine() imgui.Text(u8'( �������� ����� ������: '..ver..' )') else
			imgui.SameLine() imgui.Text(u8'( ��������� ������ )') end
			imgui.EndGroup()
		end

		popup_delete()
		imgui.End()
	end

	function setbind()
		if bindmode == 1 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'���������: ')  imgui.SameLine(120)
			if imadd.HotKey("##active11", ReconB, tLastKeys, 100) then
				rkeys.changeHotKey(reconID, ReconB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(ReconB.v), " + "))
				ini.bind.recon1 = ReconB.v[1]
				ini.bind.recon2 = ReconB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end

		if bindmode == 2 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'����������: ')  imgui.SameLine(120)
			if imadd.HotKey("##active1", DisB, tLastKeys, 100) then
				rkeys.changeHotKey(disID, DisB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(DisB.v), " + "))
				ini.bind.dis1 = DisB.v[1]
				ini.bind.dis2 = DisB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end

		if bindmode == 3 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'����������� � �������� 1: ')  imgui.SameLine(200)
			if imadd.HotKey("##active2", AccOneB, tLastKeys, 100) then
				rkeys.changeHotKey(accOneID, AccOneB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(AccOneB.v), " + "))
				ini.bind.accOne1 = AccOneB.v[1]
				ini.bind.accOne2 = AccOneB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end

		if bindmode == 4 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'����������� � �������� 1: ')  imgui.SameLine(200)
			if imadd.HotKey("##active3", AccTwoB, tLastKeys, 100) then
				rkeys.changeHotKey(accTwoID, AccTwoB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(AccTwoB.v), " + "))
				ini.bind.accTwo1 = AccTwoB.v[1]
				ini.bind.accTwo2 = AccTwoB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end

		if bindmode == 5 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'����������� � �������� 1: ')  imgui.SameLine(200)
			if imadd.HotKey("##active4", AccThreeB, tLastKeys, 100) then
				rkeys.changeHotKey(accThreeID, AccThreeB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(AccThreeB.v), " + "))
				ini.bind.accThree1 = AccThreeB.v[1]
				ini.bind.accThree2 = AccThreeB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end
		
		if bindmode == 6 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'����������� � �������� 1: ')  imgui.SameLine(200)
			if imadd.HotKey("##active5", AccFourB, tLastKeys, 100) then
				rkeys.changeHotKey(accFourID, AccFourB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(AccFourB.v), " + "))
				ini.bind.accFour1 = AccFourB.v[1]
				ini.bind.accFour2 = AccFourB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end

		if bindmode == 7 then
			imgui.NewLine() imgui.NewLine()
			imgui.SameLine(25) imgui.Text(u8'����������� � �������� 1: ')  imgui.SameLine(200)
			if imadd.HotKey("##active6", AccFiveB, tLastKeys, 100) then
				rkeys.changeHotKey(accFiveID, AccFiveB.v)
				SCM("�������! ������ ��������: " .. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. " | �����: " .. table.concat(rkeys.getKeysName(AccFiveB.v), " + "))
				ini.bind.accFive1 = AccFiveB.v[1]
				ini.bind.accFive2 = AccFiveB.v[2]
				inicfg.save(def, directIni)
			end
			imgui.SetCursorPos(imgui.ImVec2(265, 120))
			if imgui.Button(u8'�������', imgui.ImVec2(80, 25)) then
				bindset_window.v = false
			end
		end
	end

	function imgcombo()
		imgui.Separator() imgui.NewLine() imgui.NewLine()
		imgui.SameLine(25) imgui.Text(u8'���������: ')  imgui.SameLine(105)
			imgui.PushItemWidth(250)
			if imgui.Combo('##reconb', reconb, activ) then
				ini.bind.recon = reconb.v
				inicfg.save(def, directIni)
			end 
			imgui.PopItemWidth()
			imgui.NewLine() 
			if ini.bind.recon == 1 then
				imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(105)
				imgui.PushItemWidth(250) 
				if imgui.InputText('##cmd', reconcmd) then
					ini.bind.reconcmd = reconcmd.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth() 
				imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				imgui.NewLine()
			end
			if ini.bind.recon == 2 then
				--rkeys.registerHotKey(ReconB.v, false)
				imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(105)
				if ReconB.v[1] ~= 0 then
					imgui.Text( table.concat(rkeys.getKeysName(ReconB.v), " + ").."    " ) imgui.SameLine()
					if imgui.Button(u8"��������") then 
						bindmode = 1
						bindset_window.v = true
					end
				end
				imgui.NewLine()
			end
		imgui.Separator() imgui.NewLine() imgui.NewLine()

			imgui.SameLine(25) imgui.Text(u8'����������: ')  imgui.SameLine(105)
			imgui.PushItemWidth(250) 
			if imgui.Combo('##disb', disb, activ) then
				ini.bind.dis = disb.v
				inicfg.save(def, directIni)
			end 
			imgui.PopItemWidth()
			imgui.NewLine()
			if ini.bind.dis == 1 then
				imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(105)
				imgui.PushItemWidth(250) 
				if imgui.InputText('##dcmd', discmd) then
					ini.bind.discmd = discmd.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth() 
				imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				imgui.NewLine()
			end
			if ini.bind.dis == 2 then
				--rkeys.registerHotKey(ReconB.v, false)
				imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(105)
				if DisB.v[1] ~= 0 then
					imgui.Text( table.concat(rkeys.getKeysName(DisB.v), " + ").."    " ) imgui.SameLine()
					if imgui.Button(u8"��������##1") then 
						bindmode = 2
						bindset_window.v = true
					end
				end
				imgui.NewLine()
			end


		imgui.Separator() imgui.NewLine() imgui.NewLine()
			local activn = {
				u8"��� ���������",
				u8"��������� ��������"
			}
			imgui.SameLine(25) imgui.Text(u8'�������� ���: ')  imgui.SameLine(120)
			imgui.PushItemWidth(235) 
			if imgui.Combo('##nameb', nameb, activn) then
				ini.bind.name = nameb.v
				inicfg.save(def, directIni)
			end 
			imgui.PopItemWidth()
			imgui.NewLine() 
			if ini.bind.name == 1 then
				imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(120)
				imgui.PushItemWidth(235) 
				if imgui.InputText('##namecmd', namecmd) then
					ini.bind.namecmd = namecmd.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth() 
				imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				imgui.NewLine()
			end
		
		imgui.Separator() imgui.NewLine() imgui.NewLine()

			imgui.SameLine(25) imgui.Text(u8"����������� � ��������:  ") imgui.SameLine()
			imgui.PushItemWidth(50) imgui.Combo('##accsel', selaccbind, accsel) imgui.PopItemWidth()
			imgui.NewLine() 
			if selaccbind.v == 0 then
				imgui.SameLine(25) imgui.Text(u8'����� ���������: ')  imgui.SameLine(145)
				imgui.PushItemWidth(211)
				if imgui.Combo('##daccOne', accOneb, activ) then
					ini.bind.accOne = accOneb.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				imgui.NewLine() 
				if ini.bind.accOne == 1 then
					imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(145)
					imgui.PushItemWidth(211) 
					if imgui.InputText('##accOnecmd', accOnecmd) then
						ini.bind.accOnecmd = accOnecmd.v
						inicfg.save(def, directIni)
					end 
					imgui.PopItemWidth() 
					imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				end
				if ini.bind.accOne == 2 then
					imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(145)
					if AccOneB.v[1] ~= 0 then
						imgui.Text( table.concat(rkeys.getKeysName(AccOneB.v), " + ").."    " ) imgui.SameLine()
						if imgui.Button(u8"��������##2") then 
							bindmode = 3
							bindset_window.v = true
						end
					end
				end
			end

			if selaccbind.v == 1 then
				imgui.SameLine(25)  imgui.Text(u8'����� ���������: ')  imgui.SameLine(145)
				imgui.PushItemWidth(211)
				if imgui.Combo('##daccTwo', accTwob, activ) then
					ini.bind.accTwo = accTwob.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				imgui.NewLine()
				if ini.bind.accTwo == 1 then
					imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(145)
					imgui.PushItemWidth(211) 
					if imgui.InputText('##accTwocmd', accTwocmd) then
						ini.bind.accTwocmd = accTwocmd.v
						inicfg.save(def, directIni)
					end 
					imgui.PopItemWidth() 
					imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				end
				if ini.bind.accTwo == 2 then
					imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(145)
					if AccTwoB.v[1] ~= 0 then
						imgui.Text( table.concat(rkeys.getKeysName(AccTwoB.v), " + ").."    " ) imgui.SameLine()
						if imgui.Button(u8"��������##2") then 
							bindmode = 4
							bindset_window.v = true
						end
					end
				end
			end

			if selaccbind.v == 2 then
				imgui.SameLine(25) imgui.Text(u8'����� ���������: ')  imgui.SameLine(145)
				imgui.PushItemWidth(211)
				if imgui.Combo('##daccThree', accThreeb, activ) then
					ini.bind.accThree = accThreeb.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				imgui.NewLine()
				if ini.bind.accThree == 1 then
					imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(145)
					imgui.PushItemWidth(211) 
					if imgui.InputText('##accThreecmd', accThreecmd) then
						ini.bind.accThreecmd = accThreecmd.v
						inicfg.save(def, directIni)
					end 
					imgui.PopItemWidth() 
					imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				end
				if ini.bind.accThree == 2 then
					imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(145)
					if AccThreeB.v[1] ~= 0 then
						imgui.Text( table.concat(rkeys.getKeysName(AccThreeB.v), " + ").."    " ) imgui.SameLine()
						if imgui.Button(u8"��������##2") then 
							bindmode = 5
							bindset_window.v = true
						end
					end
				end
			end

			if selaccbind.v == 3 then
				imgui.SameLine(25) imgui.Text(u8'����� ���������: ')  imgui.SameLine(145)
				imgui.PushItemWidth(211)
				if imgui.Combo('##daccFour', accFourb, activ) then
					ini.bind.accFour = accFourb.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				imgui.NewLine()
				if ini.bind.accFour == 1 then
					imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(145)
					imgui.PushItemWidth(211) 
					if imgui.InputText('##accFourcmd', accFourcmd) then
						ini.bind.accFourcmd = accFourcmd.v
						inicfg.save(def, directIni)
					end 
					imgui.PopItemWidth() 
					imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				end
				if ini.bind.accFour == 2 then
					imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(145)
					if AccFourB.v[1] ~= 0 then
						imgui.Text( table.concat(rkeys.getKeysName(AccFourB.v), " + ").."    " ) imgui.SameLine()
						if imgui.Button(u8"��������##2") then 
							bindmode = 6
							bindset_window.v = true
						end
					end
				end
			end

			if selaccbind.v == 4 then
				imgui.SameLine(25) imgui.Text(u8'����� ���������: ')  imgui.SameLine(145)
				imgui.PushItemWidth(211)
				if imgui.Combo('##daccFive', accFiveb, activ) then
					ini.bind.accFive = accFiveb.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				imgui.NewLine()
				if ini.bind.accFive == 1 then
					imgui.SameLine(25) imgui.Text(u8'�������: ') imgui.SameLine(145)
					imgui.PushItemWidth(211) 
					if imgui.InputText('##accFivecmd', accFivecmd) then
						ini.bind.accFivecmd = accFivecmd.v
						inicfg.save(def, directIni)
					end 
					imgui.PopItemWidth() 
					imgui.SameLine() ShowHelpMarker(u8'��������� ������� ��� "/". � ������� ������� "/donate", ��������� ����� �������� "donate". ���� �������� "/donate", �� ������� ��������� "//donate".')
				end
				if ini.bind.accFive == 2 then
					imgui.SameLine(25) imgui.Text(u8'���������:      ') imgui.SameLine(145)
					if AccFiveB.v[1] ~= 0 then
						imgui.Text( table.concat(rkeys.getKeysName(AccFiveB.v), " + ").."    " ) imgui.SameLine()
						if imgui.Button(u8"��������##2") then 
							bindmode = 7
							bindset_window.v = true
						end
					end
				end
			end


		---------------------------------------------------	

		imgui.SetCursorPos(imgui.ImVec2(300, 460))
		if imgui.Button(u8"�������", imgui.ImVec2(80, 25)) then 
			if ini.bind.recon == 1 then 
				if reconcmd.v == "" then ini.bind.recon = 0 reconb.v = 0 end
			end
			if ini.bind.dis == 1 then 
				if discmd == "" then ini.bind.dis = 0 disb.v = 0 end
			end
			if ini.bind.accOne == 1 then 
				if accOnecmd.v == "" then ini.bind.accOne = 0 accOneb.v = 0 end
			end
			if ini.bind.accTwo == 1 then 
				if accTwocmd.v == "" then ini.bind.accTwo = 0 accTwob.v = 0 end
			end
			if ini.bind.accThree == 1 then 
				if accThreecmd.v == "" then ini.bind.accThree = 0 accThreeb.v = 0 end
			end
			if ini.bind.accFour == 1 then 
				if accFourcmd.v == "" then ini.bind.accFour = 0 accFourb.v = 0 end
			end
			if ini.bind.accFive == 1 then 
				if accFivecmd.v == "" then ini.bind.accFive = 0 accFiveb.v = 0 end
			end
			ini.settings.reload = true
			inicfg.save(def, directIni)
			thisScript():reload() 
		end
	end

	function popup_changelog()
		if imgui.BeginPopupModal(u8'������ ���������', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + 1) then
			imgui.SameLine(150)
			imgui.Text(u8'������ ���������')
			imgui.NewLine()
			--imgui.NewLine()
			--imgui.SameLine(25)
			imgui.BeginGroup()
				imgui.BeginChild("changelog", imgui.ImVec2(380,400), true)
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Text(u8'V 3.1') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'1. ���������� ����������� ��� ��������� ��������.') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'2. ������� ������ ����� �� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'3. ��������� ���������� ��������� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'4. ��������� ������ ��� ������������� ��������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'����� ���������������� �������������� �������') imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'��������� � ��������� -> ������� -> ����������������') imgui.NewLine() imgui.NewLine()
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)										imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Text(u8'V 3.0 beta') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'1. ��������� ����������� ��������� ���� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'2. ����� ������������� �������������� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'3. ��������� Popup\'�. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'4. ������������� ������� ������ ����������� �� �����. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'����� ���������������� �������������� �������') imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'��������� � ��������� -> ������� -> ����������������') imgui.NewLine() imgui.NewLine()
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Text(u8'V 3.0 beta') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'1. ��������� ����������� ��������� ���� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'2. ����� ������������� �������������� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'3. ��������� Popup\'�. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'4. ������������� ������� ������ ����������� �� �����. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'����� ���������������� �������������� �������') imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'��������� � ��������� -> ������� -> ����������������') imgui.NewLine() imgui.NewLine()
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Text(u8'V 2.99') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'1. ��������� ��� �� ����� �������. ') imgui.NewLine() imgui.NewLine()
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Text(u8'V 2.97') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'1. ��������� ��������� ������� Revent Role Play. ') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'2. ������� Diamond RP ������������ �����.') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'3. ����������� �������� ���.') imgui.NewLine() imgui.NewLine() 
					imgui.SameLine(15) imgui.Text(u8'V2.98 - ����������� ����� � ���.') imgui.NewLine() imgui.NewLine()
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
					imgui.Text(u8'V 2.95') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'1. ����������� "����� ���� ���".') imgui.NewLine() imgui.NewLine()
					imgui.SameLine(15) imgui.Text(u8'2. � �������� Diamond RP - ������������� ����� �����.') imgui.NewLine() 
					imgui.SameLine(15) imgui.Text(u8'(���������� Server didn\'t respond).') imgui.NewLine() imgui.NewLine()
					imgui.Separator() imgui.NewLine() imgui.NewLine() imgui.SameLine(170)
				imgui.EndChild()
			imgui.EndGroup()
			imgui.SetCursorPos(imgui.ImVec2(300, 460))
			if imgui.Button(u8"�������", imgui.ImVec2(80, 25)) then 
				imgui.CloseCurrentPopup()
			end
			imgui.EndPopup()
		end
	end

	function popup_autologin()
		if imgui.BeginPopupModal(u8'��������� ����-������', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + 1) then
			imgui.SameLine(130)
			imgui.Text(u8'��������� ����-������')
			imgui.NewLine()
			imgui.NewLine()
			--imgui.SameLine(25)
			imgui.BeginGroup()
				imgui.Separator() imgui.NewLine() imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������������� ������� ������:') imgui.SameLine(250)
				if imadd.ToggleButton(u8'##autopass', autopass) then
					ini.settings.autopass = autopass.v
					inicfg.save(def, directIni)
				end imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������������� ������� GAuth:') imgui.SameLine(250)
				if imadd.ToggleButton(u8'##autogcode', autogcode) then
					ini.settings.autogcode = autogcode.v
					inicfg.save(def, directIni)
				end imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������������� ������� ���:') imgui.SameLine(250)
				if imadd.ToggleButton(u8'##autocode', autocode) then
					ini.settings.autocode = autocode.v
					inicfg.save(def, directIni)
				end
				imgui.NewLine() imgui.Separator() imgui.NewLine() imgui.NewLine()
				imgui.SameLine(25) imgui.Text(u8'������� ������ �:') imgui.SameLine(195)
				imgui.PushItemWidth(120)
				if imgui.Combo('##ent', typeent, enter) then
					ini.settings.typeent = typeent.v
					inicfg.save(def, directIni)
				end 
				imgui.PopItemWidth()
				if typeent.v == 1 then
					--imgui.InputText(u8'������� TOTP code (gauth)', accounts_buffs[selacc]['gauth'])
					imgui.NewLine()
					imgui.SameLine(25) imgui.Text(u8'����� ������� �������:') imgui.SameLine(195)
					imgui.PushItemWidth(120)
					imgui.InputText(u8'##typecmd', cmdent)
					imgui.PopItemWidth()
					imgui.SameLine() ShowHelpMarker(u8'����� ��������� � ���: '..cmdent.v..u8" supersecretpass. ��� ������� ��� ����-��������")
				end
				imgui.SetCursorPos(imgui.ImVec2(300, 310))
			if imgui.Button(u8"�������", imgui.ImVec2(80, 25)) then 
				imgui.CloseCurrentPopup()
			end
			imgui.EndGroup()
			imgui.EndPopup()
		end
	end

	function popup_delete()
		if imgui.BeginPopupModal(u8'�������������', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + 1) then
			imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8'��������!')
			imgui.Text(u8'���� �� ������� �������, �� ��� ������ �� �������� ��������')
			imgui.Text(u8'� ��� ����� � TOTP ��� � ��� �� �����')
			imgui.Text(u8'���� �� �� �������� ���, �� �� �� ������� ��� ������������')
			imgui.NewLine()
			imgui.SameLine(210) if imgui.Button(u8'������', imgui.ImVec2(100, 25)) then imgui.CloseCurrentPopup() end imgui.SameLine()
			if imgui.Button(u8'�������', imgui.ImVec2(100, 25)) then
				local fpath = getWorkingDirectory()..'\\config\\KopnevScripts\\accounts.json'
				if doesFileExist(fpath) then
					local f = io.open(fpath, 'w+')
					if f then
						local temp = selacc
						table.remove(accounts, temp)
						table.remove(accounts_buffs, temp)
						local tJSON = encodeJson(accounts)
						if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
							f:write(tJSON)
							f:close()
						else
							SCM("������ ������ JSON �������. ���������� ��� ���")
						end
						if selacc ~= 1 then selacc = selacc-1 else selacc = -1 end
					else
						SCM(u8'���-�� ����� �� ��� :(')
					end
				else
					SCM(u8'���-�� ����� �� ��� :(')
				end

				imgui.CloseCurrentPopup()
			end
			imgui.EndPopup()
		end
	end

	function theme1()
		local style = imgui.GetStyle()
		local Colors = style.Colors
		local ImVec4 = imgui.ImVec4
		Colors[imgui.Col.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
		Colors[imgui.Col.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
		Colors[imgui.Col.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
		Colors[imgui.Col.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
		Colors[imgui.Col.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
		Colors[imgui.Col.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
		Colors[imgui.Col.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
		Colors[imgui.Col.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		Colors[imgui.Col.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
		Colors[imgui.Col.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
		Colors[imgui.Col.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		Colors[imgui.Col.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
		Colors[imgui.Col.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
		Colors[imgui.Col.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		Colors[imgui.Col.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		Colors[imgui.Col.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
		Colors[imgui.Col.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
		Colors[imgui.Col.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		Colors[imgui.Col.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
		Colors[imgui.Col.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
		Colors[imgui.Col.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
		Colors[imgui.Col.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		Colors[imgui.Col.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
		Colors[imgui.Col.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
		Colors[imgui.Col.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
		Colors[imgui.Col.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
		Colors[imgui.Col.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
		Colors[imgui.Col.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		Colors[imgui.Col.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
		Colors[imgui.Col.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
		Colors[imgui.Col.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		Colors[imgui.Col.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
		Colors[imgui.Col.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
		Colors[imgui.Col.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
		Colors[imgui.Col.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
		Colors[imgui.Col.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
		Colors[imgui.Col.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
		Colors[imgui.Col.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
		Colors[imgui.Col.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
		Colors[imgui.Col.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
	end

	function theme2()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
		colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
		colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
		colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
		colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.Separator]              = colors[clr.Border]
		colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
		colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
		colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
		colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]                = colors[clr.PopupBg]
		colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	end

	function theme3()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
		colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
		colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
		colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
		colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.Separator]              = colors[clr.Border]
		colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
		colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
		colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
		colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]                = colors[clr.PopupBg]
		colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	end

	function theme4()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
		colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
		colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
		colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
		colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.Separator]              = colors[clr.Border]
		colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
		colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
		colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
		colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]                = colors[clr.PopupBg]
		colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	end

	function theme5()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
		style.Alpha = 1.0
		style.Colors[clr.Text] = ImVec4(1.000, 1.000, 1.000, 1.000)
		style.Colors[clr.TextDisabled] = ImVec4(0.000, 0.543, 0.983, 1.000)
		style.Colors[clr.WindowBg] = ImVec4(0.000, 0.000, 0.000, 0.895)
		style.Colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
		style.Colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
		style.Colors[clr.Border] = ImVec4(0.184, 0.878, 0.000, 0.500)
		style.Colors[clr.BorderShadow] = ImVec4(1.00, 1.00, 1.00, 0.10)
		style.Colors[clr.TitleBg] = ImVec4(0.026, 0.597, 0.000, 1.000)
		style.Colors[clr.TitleBgCollapsed] = ImVec4(0.099, 0.315, 0.000, 0.000)
		style.Colors[clr.TitleBgActive] = ImVec4(0.026, 0.597, 0.000, 1.000)
		style.Colors[clr.MenuBarBg] = ImVec4(0.86, 0.86, 0.86, 1.00)
		style.Colors[clr.ScrollbarBg] = ImVec4(0.000, 0.000, 0.000, 0.801)
		style.Colors[clr.ScrollbarGrab] = ImVec4(0.238, 0.238, 0.238, 1.000)
		style.Colors[clr.ScrollbarGrabHovered] = ImVec4(0.238, 0.238, 0.238, 1.000)
		style.Colors[clr.ScrollbarGrabActive] = ImVec4(0.004, 0.381, 0.000, 1.000)
		style.Colors[clr.CheckMark] = ImVec4(0.009, 0.845, 0.000, 1.000)
		style.Colors[clr.SliderGrab] = ImVec4(0.139, 0.508, 0.000, 1.000)
		style.Colors[clr.SliderGrabActive] = ImVec4(0.139, 0.508, 0.000, 1.000)
		style.Colors[clr.Button] = ImVec4(0.000, 0.000, 0.000, 0.400)
		style.Colors[clr.ButtonHovered] = ImVec4(0.000, 0.619, 0.014, 1.000)
		style.Colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
		style.Colors[clr.Header] = ImVec4(0.26, 0.59, 0.98, 0.31)
		style.Colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
		style.Colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
		style.Colors[clr.ResizeGrip] = ImVec4(0.000, 1.000, 0.221, 0.597)
		style.Colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
		style.Colors[clr.ResizeGripActive] = ImVec4(0.26, 0.59, 0.98, 0.95)
		style.Colors[clr.PlotLines] = ImVec4(0.39, 0.39, 0.39, 1.00)
		style.Colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
		style.Colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
		style.Colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
		style.Colors[clr.TextSelectedBg] = ImVec4(0.26, 0.59, 0.98, 0.35)
		style.Colors[clr.ModalWindowDarkening] = ImVec4(0.20, 0.20, 0.20, 0.35)

		style.ScrollbarSize = 16.0
		style.GrabMinSize = 8.0
		style.WindowRounding = 0.0

		style.AntiAliasedLines = true
	end

	function theme6()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		colors[clr.Text] = ImVec4(0.90, 0.90, 0.90, 1.00)
		colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
		colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
		colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
		colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
		colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
		colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
		colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
		colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
		colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
		colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
		colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
		colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
		colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
		colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
		colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
		colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
		colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
		colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
		colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
		colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
		colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
		colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
		colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
		colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
		colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
		colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
		colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
		colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
		colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
		colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
		colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
		colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
		colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
		colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
	end

	function theme7()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
		colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
		colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
		colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
		colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
		colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
		colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
		colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
		colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
		colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
		colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
		colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
		colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
		colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
		colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
		colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
		colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
		colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
		colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
		colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
		colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
		colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
		colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
		colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
		colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
		colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
		colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
		colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
		colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
		colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
		colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
		colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
	end

	function theme8()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
		colors[clr.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 1.00)
		colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 1.00)
		colors[clr.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
		colors[clr.Border]                 = ImVec4(0.82, 0.77, 0.78, 1.00)
		colors[clr.BorderShadow]           = ImVec4(0.35, 0.35, 0.35, 0.66)
		colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.28)
		colors[clr.FrameBgHovered]         = ImVec4(0.68, 0.68, 0.68, 0.67)
		colors[clr.FrameBgActive]          = ImVec4(0.79, 0.73, 0.73, 0.62)
		colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.46, 0.46, 0.46, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 1.00)
		colors[clr.MenuBarBg]              = ImVec4(0.00, 0.00, 0.00, 0.80)
		colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.60)
		colors[clr.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.87)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.79)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.80, 0.50, 0.50, 0.40)
		colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 0.99)
		colors[clr.CheckMark]              = ImVec4(0.99, 0.99, 0.99, 0.52)
		colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.42)
		colors[clr.SliderGrabActive]       = ImVec4(0.76, 0.76, 0.76, 1.00)
		colors[clr.Button]                 = ImVec4(0.51, 0.51, 0.51, 0.60)
		colors[clr.ButtonHovered]          = ImVec4(0.68, 0.68, 0.68, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.67, 0.67, 0.67, 1.00)
		colors[clr.Header]                 = ImVec4(0.72, 0.72, 0.72, 0.54)
		colors[clr.HeaderHovered]          = ImVec4(0.92, 0.92, 0.95, 0.77)
		colors[clr.HeaderActive]           = ImVec4(0.82, 0.82, 0.82, 0.80)
		colors[clr.Separator]              = ImVec4(0.73, 0.73, 0.73, 1.00)
		colors[clr.SeparatorHovered]       = ImVec4(0.81, 0.81, 0.81, 1.00)
		colors[clr.SeparatorActive]        = ImVec4(0.74, 0.74, 0.74, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.80, 0.80, 0.80, 0.30)
		colors[clr.ResizeGripHovered]      = ImVec4(0.95, 0.95, 0.95, 0.60)
		colors[clr.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90)
		colors[clr.CloseButton]            = ImVec4(0.45, 0.45, 0.45, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.70, 0.70, 0.90, 0.60)
		colors[clr.CloseButtonActive]      = ImVec4(0.70, 0.70, 0.70, 1.00)
		colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.88, 0.88, 0.88, 0.35)
	end

	function theme9()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 0.93)
		colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 0.80)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.09, 0.94)
		colors[clr.Border]                 = ImVec4(0.97, 1.00, 0.00, 0.65)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg]                = ImVec4(1.00, 0.96, 0.00, 0.68)
		colors[clr.FrameBgHovered]         = ImVec4(0.79, 0.93, 0.04, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.96, 0.83, 0.04, 0.45)
		colors[clr.TitleBg]                = ImVec4(0.80, 0.80, 0.12, 0.87)
		colors[clr.TitleBgActive]          = ImVec4(0.95, 0.72, 0.00, 0.87)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.88, 0.90, 0.08, 0.20)
		colors[clr.MenuBarBg]              = ImVec4(0.85, 0.97, 0.04, 0.80)
		colors[clr.ScrollbarBg]            = ImVec4(0.90, 0.67, 0.05, 0.60)
		colors[clr.ScrollbarGrab]          = ImVec4(0.82, 0.87, 0.10, 0.88)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.86, 0.81, 0.13, 0.40)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.92, 0.86, 0.07, 0.40)
		colors[clr.ComboBg]                = ImVec4(0.76, 0.63, 0.03, 0.99)
		colors[clr.CheckMark]              = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.Button]                 = ImVec4(0.97, 1.00, 0.00, 0.66)
		colors[clr.ButtonHovered]          = ImVec4(0.85, 0.90, 0.02, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.92, 0.74, 0.04, 1.00)
		colors[clr.Header]                 = ImVec4(0.80, 0.94, 0.04, 0.45)
		colors[clr.HeaderHovered]          = ImVec4(0.90, 0.79, 0.13, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.87, 0.86, 0.05, 0.80)
		colors[clr.Separator]              = ImVec4(0.91, 0.82, 0.06, 1.00)
		colors[clr.SeparatorHovered]       = ImVec4(0.96, 0.90, 0.08, 1.00)
		colors[clr.SeparatorActive]        = ImVec4(0.97, 0.91, 0.04, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(1.00, 1.00, 1.00, 0.30)
		colors[clr.ResizeGripHovered]      = ImVec4(1.00, 1.00, 1.00, 0.60)
		colors[clr.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90)
		colors[clr.CloseButton]            = ImVec4(0.84, 0.90, 0.50, 0.57)
		colors[clr.CloseButtonHovered]     = ImVec4(0.90, 0.89, 0.70, 0.60)
		colors[clr.CloseButtonActive]      = ImVec4(0.70, 0.70, 0.70, 1.00)
		colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.02, 1.00, 0.35)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35)

	end

	function easy_style()
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		style.WindowPadding = imgui.ImVec2(9, 14)
		style.WindowRounding = 10
		style.ChildWindowRounding = 10
		style.FramePadding = imgui.ImVec2(5, 3)
		style.FrameRounding = 6.0
		style.ItemSpacing = imgui.ImVec2(9.0, 3.0)
		style.ItemInnerSpacing = imgui.ImVec2(9.0, 3.0)
		style.IndentSpacing = 21
		style.ScrollbarSize = 6.0
		style.ScrollbarRounding = 13
		style.GrabMinSize = 17.0
		style.GrabRounding = 16.0

		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
		style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
	end

	function strong_style()
		imgui.SwitchContext()
		local style = imgui.GetStyle()

		style.WindowPadding = imgui.ImVec2(8, 8)
		style.WindowRounding = 2
		style.ChildWindowRounding = 2
		style.FramePadding = imgui.ImVec2(4, 3)
		style.FrameRounding = 2
		style.ItemSpacing = imgui.ImVec2(5, 4)
		style.ItemInnerSpacing = imgui.ImVec2(4, 4)
		style.IndentSpacing = 21
		style.ScrollbarSize = 13
		style.ScrollbarRounding = 0
		style.GrabMinSize = 8
		style.GrabRounding = 1

		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
		style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
	end

end


function autosave()
	local fpath = getWorkingDirectory()..'\\config\\KopnevScripts\\accounts.json'
	if doesFileExist(fpath) then
		local f = io.open(fpath, 'w+')
		if f then
			local tJSON = encodeJson(accounts)
			if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
				f:write(tJSON)
				f:close()
			else
				SCM("������ ������ JSON �������. ���������� ��� ���")
			end
		else
			SCM(u8'���-�� ����� �� ��� :(')
		end
	else
		SCM(u8'���-�� ����� �� ��� :(')
	end
end

function onSendRpc(id, bs)
	if checkpass then
		if id == 62 then
			local dialogId  = raknetBitStreamReadInt16(bs)
			local button    = raknetBitStreamReadInt8(bs)
			local listitem  = raknetBitStreamReadInt16(bs)
			local input_text = raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs))
			savepas = input_text
		end
	end
end


function getIpByDomain(domain)
	local socket = require("socket")
    local ip = socket.dns.toip(domain)
    return ip
end

function loadacc()
    account_info = nil
    local ip, port = sampGetCurrentServerAddress()
    local _, clientId = sampGetPlayerIdByCharHandle(playerPed)
    local name = sampGetPlayerNickname(clientId)

    for i, v in ipairs(accounts) do
        local server_ip = v['server_ip']
        if not server_ip:match("^%d+%.%d+%.%d+%.%d+$") then
            server_ip = getIpByDomain(server_ip)
        end

        local ip2 = ""
        for i4 in ipairs(ipserv) do
            if ip == ipserv[i4]['ip'] then
                ip2 = ipserv[i4]['domen']
                break
            end
        end

        if (server_ip == ip2 or server_ip == ip) and v['server_port'] == port.."" and v['user_name'] == name then
            print('{00FF00}�������{FFFFFF} �������� ������� {2980b9}'..v['user_name']..'{FFFFFF}.')
            account_info = v
            break
        end
    end

    if account_info == nil then
        lua_thread.create(function()
            wait(3500)
            for i, v in ipairs(accounts) do
                ip, port = sampGetCurrentServerAddress()
                local _, clientId = sampGetPlayerIdByCharHandle(playerPed)
                name = sampGetPlayerNickname(clientId)

                local ip2 = ""
                for i4 in ipairs(ipserv) do
                    if ip == ipserv[i4]['ip'] then
                        ip2 = ipserv[i4]['domen']
                        break
                    end
                end

                local server_ip = v['server_ip']
                if not server_ip:match("^%d+%.%d+%.%d+%.%d+$") then
                    server_ip = getIpByDomain(server_ip)
                end

                if (server_ip == ip2 or server_ip == ip) and v['server_port'] == port.."" and v['user_name'] == name then
                    print('{00FF00}�������{FFFFFF} �������� ������� {2980b9}'..v['user_name']..'{FFFFFF}.')
                    SCM('������� �������� �� ������ �������. ���� ������ ������, ������� "enter"')
                    account_info = v
                    break
                end
            end
        end)
    end
end

function readBitstream(bs)
	local data = {}
	data.id = raknetBitStreamReadInt16(bs)
	raknetBitStreamIgnoreBits(bs, 104)
	data.hun = raknetBitStreamReadFloat(bs) - textdraw.numb
	raknetBitStreamIgnoreBits(bs, 32)
	data.color = raknetBitStreamReadInt32(bs)
	raknetBitStreamIgnoreBits(bs, 64)
	data.x = raknetBitStreamReadFloat(bs)
	data.y = raknetBitStreamReadFloat(bs)
	return data
end

function getServTitle(ips, ports)
	for i2, v2 in ipairs(serv) do
		for i3, v3 in ipairs(v2['list']) do
			local ip2 = ""
			for i4 in ipairs(ipserv) do
				--print(ipserv[i4]['domen'])
				if ips == ipserv[i4]['ip'] then ip2 = ipserv[i4]['domen'] break end
			end
			if (ips == v3['ip'] or ip2 == v3['ip']) and ports == v3['port'] then
				--print(v2['title'])
				return v2['title']
			end
		end
	end
end 
function getCustomServTitle(ips, ports)
	for i2, v2 in ipairs(customServ) do
		for i3, v3 in ipairs(v2['list']) do
			if ips == v3['ip'] and ports == v3['port'] then
				--[[print(v2['title'])
				if v2['Orient_Auth_INT'] == 0 then
					return true, v2['Orient_Auth_INT'], v2['Orient_Auth_ID'], v2['list']
				end
				if v2['Orient_Auth_INT'] == 1 then
					return true, v2['Orient_Auth_INT'], v2['Orien_Auth_title'], v2['list']
				end
				if v2['Orient_Auth_INT'] == 2 then
					return true, v2['Orient_Auth_INT'], v2['Orient_Auth_text'], v2['list']
				end]]
				return true, v2
			end
		end
	end
end

function onScriptTerminate(LuaScript, quitGame)
	if LuaScript == thisScript() and not quitGame and not ini.settings.reload and not ini.settings.reloadR and not dev then
		save_customServ()
		sampShowDialog(6405, "                                        {FF0000}��������� ������!", "{FFFFFF}���� ��������� ����� ���� ������, ���� �� \n������������ ������ AutoReboot \n\n� ��������� ������ {F1CB09}Connect-Tool{FFFFFF} ���������� ��������\n���� �� ������ ������ ������������\n�� ������ ������� ��� ����� �������� ��������� ������\n���� ������: {0099CC}vk.com/kscripts", "��", "", DIALOG_STYLE_MSGBOX)
		SCM('��������� ������')
		showCursor(false, false)
	end
end

function onExitScript()
	save_customServ()
	showCursor(false, false)
end

function save_customServ()
	local tJSON = encodeJson(customServ)
	if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
	local fpath =  getWorkingDirectory().."\\config\\KopnevScripts\\customServ.json"
		local f = io.open(fpath, "w")
		f:write(tJSON)
		f:close()
	else
		SCM("������ ������ JSON Config. ���������� ��������� ������� ����������. (Config - customServ.json)")
	end
	local tJSON = encodeJson(serv)
	if tJSON:sub(1,1) == '{' or tJSON:sub(1,1) == '[' then
	local fpath =  getWorkingDirectory().."\\config\\KopnevScripts\\servers.ctool"
		local f = io.open(fpath, "w")
		f:write(tJSON)
		f:close()
	else
		SCM("������ ������ JSON Config. ���������� ��������� ������� ����������. (Config - servers.ctool)")
	end
end

-- function update()
-- 	async_http_request('https://kscripts.ru/scripts/version.php', "script="..toSendGet("CTool"), function(res)
--         if res then
--             if res:sub(1,1) == '{' then
--                 result = decodeJson(res)
--                 if result.num > thisScript().version_num then
--                     new = 1
--                     ver = result.version
--                     SCM('�������� ����������.')
--                     if result.setup then 
--                         goupdate()
--                     end
--                 else SCM("� ��� ����������� ��������� ������") end
--             else sampAddChatMessage("[Connect Tool] ���������� ������. ���������� �����", 0xFF0000) print(res) end
--         end
--     end)
-- end

-- function goupdate()
-- 	gou = false
--     SCM('���������� ����������. AutoReload ����� �������������. ����������...')
--     SCM('������� ������: '..thisScript().version..". ����� ������: "..ver)
--     wait(300)
--     downloadUrlToFile("https://kscripts.ru/scripts/download.php?script=CTool&src=true", thisScript().path, function(id, status, p1, p2)
--     	if status == dlstatus.STATUS_ENDDOWNLOADDATA then
--             thisScript():reload()
--         end
--     end)
-- end

function uu()
    for i = 0,6 do
        vkladki[i] = false
    end
	autosave()
end

function mq()
	for i = 0,5 do
			servers[i] = false
	end
end

function WorkInBackground(work)
    local memory = require 'memory'
    if work then
        memory.setuint8(7634870, 1)
        memory.setuint8(7635034, 1)
        memory.fill(7623723, 144, 8)
        memory.fill(5499528, 144, 6)
    else
        memory.setuint8(7634870, 0)
        memory.setuint8(7635034, 0)
        memory.hex2bin('5051FF1500838500', 7623723, 8)
        memory.hex2bin('0F847B010000', 5499528, 6)
    end
end

function char_to_hex(str)
  return string.format("%%%02X", string.byte(str))
end

function url_encode(str)
  local str = string.gsub(str, "\\", "\\")
  local str = string.gsub(str, "([^%w])", char_to_hex)
  return str
end

function fastconnect()
	memory.fill(sampGetBase() + 0x2D3C45, 0, 2, true)
end

function SCM(arg1)
	if not invisible.v then
		sampAddChatMessage("[Connect-Tool]: {FFFFFF}"..arg1, 0xF1CB09)
	else print(arg1) end
end
