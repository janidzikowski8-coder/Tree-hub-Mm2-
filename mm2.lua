-- Jasiu Hub V3 | Murder Mystery 2 (Ultra-Safe Loader dla Arceus X)
local success, err = pcall(function()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
       Name = "Jasiu Hub V3 🌲 | MM2 Safe",
       LoadingTitle = "Ładowanie Jasiu Hub V3...",
       LoadingSubtitle = "Zabezpieczone dla Arceus X",
       ConfigurationSaving = { Enabled = false },
       KeySystem = false,
    })

    -- Zakładka testowa i podstawowa, żeby sprawdzić czy menu wstało
    local TabHome = Window:CreateTab("Start", 4483362458)
    
    TabHome:CreateParagraph({Title = "Status skryptu", Content = "Jasiu Hub V3 załadował się pomyślnie!"})

    TabHome:CreateButton({
       Name = "⚡ Szybki Test (Teleport do lobby)",
       Callback = function()
          print("Jasiu Hub działa poprawnie!")
       end,
    })
end)

if not success then
    warn("Jasiu Hub Error: " .. tostring(err))
end
