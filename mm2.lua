-- Items Hub | MM2 Clean Edition V1 (Tylko zakładka Start)
local Success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not Success or not Rayfield then
    warn("Błąd krytyczny: Nie udało się załadować biblioteki Rayfield!")
    return
end

local Window = Rayfield:CreateWindow({
   Name = "Items Hub 🌟 | MM2 Pro",
   LoadingTitle = "Inicjalizacja Items Hub...",
   LoadingSubtitle = "Czysta wersja główna",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Tylko zakładka Start
local TabHome = Window:CreateTab("Start", 4483362458)

-------------------------------------------------
-- ZAKŁADKA: START (GŁÓWNA)
-------------------------------------------------
TabHome:CreateParagraph({
   Title = "Witaj w Items Hub!",
   Content = "Witam w Items hub to script do Mm2 życzę miłego grania V1"
})

TabHome:CreateButton({
   Name = "🎉 Pokaż powiadomienie powitalne",
   Callback = function()
      Rayfield:Notify({
         Title = "Items Hub V1",
         Content = "Miłej gry w Murder Mystery 2!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

Rayfield:Notify({
   Title = "Items Hub V1",
   Content = "Skrypt uruchomiony pomyślnie!",
   Duration = 5,
   Image = 4483362458,
})
