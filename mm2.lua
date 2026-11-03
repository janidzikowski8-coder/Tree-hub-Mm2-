-- Tree Hub 🌲 | Murder Mystery 2 (Pełna wersja z God-Mode/Hacks)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tree Hub 🌲 | MM2 Pro",
   LoadingTitle = "Ładowanie potężnego Tree Hub...",
   LoadingSubtitle = "by Tree Hub Team",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TreeHubConfig",
      FileName = "MM2ConfigPro"
   },
   Discord = { Enabled = false, Invite = "noinvitelink", RememberJoins = true },
   KeySystem = false
})

-------------------------------------------------
-- ZMIENNE GLOBALNE
-------------------------------------------------
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

_G.ESP_Roles = false
_G.Noclip = false
_G.SpeedValue = 16
_G.JumpValue = 50
_G.InfJump = false
_G.FlyEnabled = false
_G.FlySpeed = 50
_G.KillAura = false
_G.KillAuraRange = 10
_G.WallShot = false

-------------------------------------------------
-- ZAKŁADKI (TABS)
-------------------------------------------------
local TabMain = Window:CreateTab("Główne / MM2 🌲", 4483362458)
local TabVisuals = Window:CreateTab("ESP Ról 👁️", 4483362458)
local TabPostac = Window:CreateTab("Postać & Fly ⚡", 4483362458)

-------------------------------------------------
-- 1. ZAKŁADKA: GŁÓWNIĘ (KillAura, WallShot, Auto Gun)
-------------------------------------------------
TabMain:CreateSection("Funkcje Bojowe (Szeryf / Morderca)")

TabMain:CreateToggle({
   Name = "Szeryf: Strzelaj przez ściany (WallShot)",
   CurrentValue = false,
   Callback = function(Value)
       _G.WallShot = Value
   end,
})

TabMain:CreateToggle({
   Name = "Morderca: Kill Aura (Automatyczne zabijanie)",
   CurrentValue = false,
   Callback = function(Value)
       _G.KillAura = Value
   end,
})

TabMain:CreateSlider({
   Name = "Kill Aura Zasięg",
   Range = {10, 1000},
   Increment = 5,
   Suffix = "studów",
   CurrentValue = 10,
   Callback = function(Value)
       _G.KillAuraRange = Value
   end,
})

TabMain:CreateButton
