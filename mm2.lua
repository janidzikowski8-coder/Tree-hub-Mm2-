-- Exon Hub V1 | MM2 (Tylko zakładka Start)
local Success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not Success or not Rayfield then
    warn("Błąd: Nie udało się załadować Rayfield UI!")
    return
end

local Window = Rayfield:CreateWindow({
   Name = "Exon Hub V1 ⚡ | MM2",
   LoadingTitle = "Ładowanie Exon Hub...",
   LoadingSubtitle = "Minimalistyczna wersja",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Tylko zakładka Start
local TabHome = Window:CreateTab("Start", 4483362458)

-------------------------------------------------
-- ZAKŁADKA: START
-------------------------------------------------
TabHome:CreateParagraph({
   Title = "Witaj w Exon Hub!",
   Content = "Witam w Exon Hub to skrypt do MM2. Życzę miłego grania V1"
})

TabHome:CreateButton({
   Name = "🎉 Pokaż powiadomienie powitalne",
   Callback = function()
      Rayfield:Notify({
         Title = "Exon Hub V1",
         Content = "Miłej gry w Murder Mystery 2!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

Rayfield:Notify({
   Title = "Exon Hub V1",
   Content = "Załadowano pomyślnie!",
   Duration = 5,
   Image = 4483362458,
})
