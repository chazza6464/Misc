<#
    .SYNOPSIS
    Simulates opening a pack of Pokemon TCG cards.

    .NOTES
    I made this just to mess around with weighted probability.
    All card weights are made up and are probably not accurate. I'd be shocked if they are.

    .NOTES
    If a duplicate pull happens the first time a card is obtained, it does not display as NEW.
    I'm working on a way to save and load progress. Just need to decide on how to format the file.
#>


[CmdletBinding()]
param (
    [ValidateSet("BaseSet", "JungleSet", "FossilSet")]
    [string]$CurrentCollection = "BaseSet"
)
class Card {
    [string]    $Name
    [string]    $Rarity
    [int]       $Number
    [int]       $Weight
    [int]       $Count

    Card([string]$Name, [string]$Rarity, [int]$Number, [int]$Weight) {
        $this.Name      = $Name
        $this.Rarity    = $Rarity
        $this.Number    = $Number
        $this.Weight    = $Weight
        $this.Count     = 0
    }
}

$BaseSetPacksOpened = 0
$BaseSetCards = @(
    #           Name                                Rarity          Number  Weight
    [Card]::new("Alakazam",                         "Holo Rare",    1,      1)
    [Card]::new("Blastoise",                        "Holo Rare",    2,      1)
    [Card]::new("Chansey",                          "Holo Rare",    3,      1)
    [Card]::new("Charizard",                        "Holo Rare",    4,      1)
    [Card]::new("Clefairy",                         "Holo Rare",    5,      1)
    [Card]::new("Gyarados",                         "Holo Rare",    6,      1)
    [Card]::new("Hitmonchan",                       "Holo Rare",    7,      1)
    [Card]::new("Machamp",                          "Holo Rare",    8,      1)
    [Card]::new("Magneton",                         "Holo Rare",    9,      1)
    [Card]::new("Mewtwo",                           "Holo Rare",    10,     1)
    [Card]::new("Nidoking",                         "Holo Rare",    11,     1)
    [Card]::new("Ninetales",                        "Holo Rare",    12,     1)
    [Card]::new("Poliwrath",                        "Holo Rare",    13,     1)
    [Card]::new("Raichu",                           "Holo Rare",    14,     1)
    [Card]::new("Venusaur",                         "Holo Rare",    15,     1)
    [Card]::new("Zapdos",                           "Holo Rare",    16,     1)
    [Card]::new("Beedrill",                         "Rare",         17,     10)
    [Card]::new("Dragonair",                        "Rare",         18,     10)
    [Card]::new("Dugtrio",                          "Rare",         19,     10)
    [Card]::new("Electabuzz",                       "Rare",         20,     10)
    [Card]::new("Electrode",                        "Rare",         21,     10)
    [Card]::new("Pidgeotto",                        "Rare",         22,     10)
    [Card]::new("Arcanine",                         "Uncommon",     23,     25)
    [Card]::new("Charmeleon",                       "Uncommon",     24,     25)
    [Card]::new("Dewgong",                          "Uncommon",     25,     25)
    [Card]::new("Dratini",                          "Uncommon",     26,     25)
    [Card]::new("Farfetch'd",                       "Uncommon",     27,     25)
    [Card]::new("Growlithe",                        "Uncommon",     28,     25)
    [Card]::new("Haunter",                          "Uncommon",     29,     25)
    [Card]::new("Ivysaur",                          "Uncommon",     30,     25)
    [Card]::new("Jynx",                             "Uncommon",     31,     25)
    [Card]::new("Kadabra",                          "Uncommon",     32,     25)
    [Card]::new("Kakuna",                           "Uncommon",     33,     25)
    [Card]::new("Machoke",                          "Uncommon",     34,     25)
    [Card]::new("Magikarp",                         "Uncommon",     35,     25)
    [Card]::new("Magmar",                           "Uncommon",     36,     25)
    [Card]::new("Nidorino",                         "Uncommon",     37,     25)
    [Card]::new("Poliwhirl",                        "Uncommon",     38,     25)
    [Card]::new("Porygon",                          "Uncommon",     39,     25)
    [Card]::new("Raticate",                         "Uncommon",     40,     25)
    [Card]::new("Seel",                             "Uncommon",     41,     25)
    [Card]::new("Wartortle",                        "Uncommon",     42,     25)
    [Card]::new("Abra",                             "Common",       43,     75)
    [Card]::new("Bulbasaur",                        "Common",       44,     75)
    [Card]::new("Caterpie",                         "Common",       45,     75)
    [Card]::new("Charmander",                       "Common",       46,     75)
    [Card]::new("Diglett",                          "Common",       47,     75)
    [Card]::new("Doduo",                            "Common",       48,     75)
    [Card]::new("Drowzee",                          "Common",       49,     75)
    [Card]::new("Gastly",                           "Common",       50,     75)
    [Card]::new("Koffing",                          "Common",       51,     75)
    [Card]::new("Machop",                           "Common",       52,     75)
    [Card]::new("Magnemite",                        "Common",       53,     75)
    [Card]::new("Metapod",                          "Common",       54,     75)
    [Card]::new("Nidoran ♂",                        "Common",       55,     75)
    [Card]::new("Onix",                             "Common",       56,     75)
    [Card]::new("Pidgey",                           "Common",       57,     75)
    [Card]::new("Pikachu",                          "Common",       58,     75)
    [Card]::new("Poliwag",                          "Common",       59,     75)
    [Card]::new("Ponyta",                           "Common",       60,     75)
    [Card]::new("Rattata",                          "Common",       61,     75)
    [Card]::new("Sandshrew",                        "Common",       62,     75)
    [Card]::new("Squirtle",                         "Common",       63,     75)
    [Card]::new("Starmie",                          "Common",       64,     75)
    [Card]::new("Staryu",                           "Common",       65,     75)
    [Card]::new("Tangela",                          "Common",       66,     75)
    [Card]::new("Voltorb",                          "Common",       67,     75)
    [Card]::new("Vulpix",                           "Common",       68,     75)
    [Card]::new("Weedle",                           "Common",       69,     75)
    [Card]::new("Trainer - Clefairy Doll",          "Rare",         70,     10)
    [Card]::new("Trainer - Computer Search",        "Rare",         71,     10)
    [Card]::new("Trainer - Devolution Spray",       "Rare",         72,     10)
    [Card]::new("Trainer - Impostor Professor Oak", "Rare",         73,     10)
    [Card]::new("Trainer - Item Finder",            "Rare",         74,     10)
    [Card]::new("Trainer - Lass",                   "Rare",         75,     10)
    [Card]::new("Trainer - Pokemon Breeder",        "Rare",         76,     10)
    [Card]::new("Trainer - Pokemon Trader",         "Rare",         77,     10)
    [Card]::new("Trainer - Scoop Up",               "Rare",         78,     10)
    [Card]::new("Trainer - Super Energy Removal",   "Rare",         79,     10)
    [Card]::new("Trainer - Defender",               "Uncommon",     80,     25)
    [Card]::new("Trainer - Energy Retrieval",       "Uncommon",     81,     25)
    [Card]::new("Trainer - Full Heal",              "Uncommon",     82,     25)
    [Card]::new("Trainer - Maintenance",            "Uncommon",     83,     25)
    [Card]::new("Trainer - PlusPower",              "Uncommon",     84,     25)
    [Card]::new("Trainer - Pokemon Center",         "Uncommon",     85,     25)
    [Card]::new("Trainer - Pokemon Flute",          "Uncommon",     86,     25)
    [Card]::new("Trainer - Pokedex",                "Uncommon",     87,     25)
    [Card]::new("Trainer - Professor Oak",          "Uncommon",     88,     25)
    [Card]::new("Trainer - Revive",                 "Uncommon",     89,     25)
    [Card]::new("Trainer - Super Potion",           "Uncommon",     90,     25)
    [Card]::new("Trainer - Bill",                   "Common",       91,     75)
    [Card]::new("Trainer - Energy Removal",         "Common",       92,     75)
    [Card]::new("Trainer - Gust of Wind",           "Common",       93,     75)
    [Card]::new("Trainer - Potion",                 "Common",       94,     75)
    [Card]::new("Trainer - Switch",                 "Common",       95,     75)
    [Card]::new("Energy - Double Colorless",        "Common",       96,     75)
    [Card]::new("Energy - Fighting",                "Common",       97,     75)
    [Card]::new("Energy - Fire",                    "Common",       98,     75)
    [Card]::new("Energy - Grass",                   "Common",       99,     75)
    [Card]::new("Energy - Electric",                "Common",       100,    75)
    [Card]::new("Energy - Psychic",                 "Common",       101,    75)
    [Card]::new("Energy - Water",                   "Common",       102,    75)
)

$JungleSetPacksOpened = 0
$JungleSetCards = @(
    #           Name                                Rarity          Number  Weight
    [Card]::new("Clefable",                         "Holo Rare",    1,      1)
    [Card]::new("Electrode",                        "Holo Rare",    2,      1)
    [Card]::new("Flareon",                          "Holo Rare",    3,      1)
    [Card]::new("Jolteon",                          "Holo Rare",    4,      1)
    [Card]::new("Kangaskhan",                       "Holo Rare",    5,      1)
    [Card]::new("Mr. Mime",                         "Holo Rare",    6,      1)
    [Card]::new("Nidoqueen",                        "Holo Rare",    7,      1)
    [Card]::new("Pidgeot",                          "Holo Rare",    8,      1)
    [Card]::new("Pinsir",                           "Holo Rare",    9,      1)
    [Card]::new("Scyther",                          "Holo Rare",    10,     1)
    [Card]::new("Snorlax",                          "Holo Rare",    11,     1)
    [Card]::new("Vaporeon",                         "Holo Rare",    12,     1)
    [Card]::new("Venomoth",                         "Holo Rare",    13,     1)
    [Card]::new("Victreebel",                       "Holo Rare",    14,     1)
    [Card]::new("Vileplume",                        "Holo Rare",    15,     1)
    [Card]::new("Wigglytuff",                       "Holo Rare",    16,     1)
    [Card]::new("Clefable",                         "Rare",         17,     10)
    [Card]::new("Electrode",                        "Rare",         18,     10)
    [Card]::new("Flareon",                          "Rare",         19,     10)
    [Card]::new("Jolteon",                          "Rare",         20,     10)
    [Card]::new("Kanghaskhan",                      "Rare",         21,     10)
    [Card]::new("Mr. Mime",                         "Rare",         22,     10)
    [Card]::new("Nidoqueen",                        "Rare",         23,     10)
    [Card]::new("Pidgeot",                          "Rare",         24,     10)
    [Card]::new("Pinsir",                           "Rare",         25,     10)
    [Card]::new("Scyther",                          "Rare",         26,     10)
    [Card]::new("Snorlax",                          "Rare",         27,     10)
    [Card]::new("Vaporeon",                         "Rare",         28,     10)
    [Card]::new("Venomoth",                         "Rare",         29,     10)
    [Card]::new("Victreebel",                       "Rare",         30,     10)
    [Card]::new("Vileplume",                        "Rare",         31,     10)
    [Card]::new("Wigglytuff",                       "Rare",         32,     10)
    [Card]::new("Butterfree",                       "Uncommon",     33,     25)
    [Card]::new("Dodrio",                           "Uncommon",     34,     25)
    [Card]::new("Exeggutor",                        "Uncommon",     35,     25)
    [Card]::new("Fearow",                           "Uncommon",     36,     25)
    [Card]::new("Gloom",                            "Uncommon",     37,     25)
    [Card]::new("Lickitung",                        "Uncommon",     38,     25)
    [Card]::new("Marowak",                          "Uncommon",     39,     25)
    [Card]::new("Nidorina",                         "Uncommon",     40,     25)
    [Card]::new("Parasect",                         "Uncommon",     41,     25)
    [Card]::new("Persian",                          "Uncommon",     42,     25)
    [Card]::new("Primeape",                         "Uncommon",     43,     25)
    [Card]::new("Rapidash",                         "Uncommon",     44,     25)
    [Card]::new("Rhydon",                           "Uncommon",     45,     25)
    [Card]::new("Seaking",                          "Uncommon",     46,     25)
    [Card]::new("Tauros",                           "Uncommon",     47,     25)
    [Card]::new("Weepinbell",                       "Uncommon",     48,     25)
    [Card]::new("Bellsprout",                       "Common",       49,     75)
    [Card]::new("Cubone",                           "Common",       50,     75)
    [Card]::new("Eevee",                            "Common",       51,     75)
    [Card]::new("Exeggute",                         "Common",       52,     75)
    [Card]::new("Goldeen",                          "Common",       53,     75)
    [Card]::new("Jigglypuff",                       "Common",       54,     75)
    [Card]::new("Mankey",                           "Common",       55,     75)
    [Card]::new("Meowth",                           "Common",       56,     75)
    [Card]::new("Nidoran ♀",                        "Common",       57,     75)
    [Card]::new("Oddish",                           "Common",       58,     75)
    [Card]::new("Paras",                            "Common",       59,     75)
    [Card]::new("Pikachu",                          "Common",       60,     75)
    [Card]::new("Rhyhorn",                          "Common",       61,     75)
    [Card]::new("Spearow",                          "Common",       62,     75)
    [Card]::new("Venonat",                          "Common",       63,     75)
    [Card]::new("Trainer - Poke Ball",              "Common",       64,     75)
)

$FossilSetPacksOpened = 0
$FossilSetCards = @(
    #           Name                                Rarity          Number  Weight
    [Card]::new("Aerodactyl",                       "Holo Rare",    1,      1)
    [Card]::new("Articuno",                         "Holo Rare",    2,      1)
    [Card]::new("Ditto",                            "Holo Rare",    3,      1)
    [Card]::new("Dragonite",                        "Holo Rare",    4,      1)
    [Card]::new("Gengar",                           "Holo Rare",    5,      1)
    [Card]::new("Haunter",                          "Holo Rare",    6,      1)
    [Card]::new("Hitmonlee",                        "Holo Rare",    7,      1)
    [Card]::new("Hypno",                            "Holo Rare",    8,      1)
    [Card]::new("Kabutops",                         "Holo Rare",    9,      1)
    [Card]::new("Lapras",                           "Holo Rare",    10,     1)
    [Card]::new("Magneton",                         "Holo Rare",    11,     1)
    [Card]::new("Moltres",                          "Holo Rare",    12,     1)
    [Card]::new("Muk",                              "Holo Rare",    13,     1)
    [Card]::new("Raichu",                           "Holo Rare",    14,     1)
    [Card]::new("Zapdos",                           "Holo Rare",    15,     1)
    [Card]::new("Aerodactyl",                       "Rare",         16,     10)
    [Card]::new("Articuno",                         "Rare",         17,     10)
    [Card]::new("Ditto",                            "Rare",         18,     10)
    [Card]::new("Dragonite",                        "Rare",         19,     10)
    [Card]::new("Gengar",                           "Rare",         20,     10)
    [Card]::new("Haunter",                          "Rare",         21,     10)
    [Card]::new("Hitmonlee",                        "Rare",         22,     10)
    [Card]::new("Hypno",                            "Rare",         23,     10)
    [Card]::new("Kabutops",                         "Rare",         24,     10)
    [Card]::new("Lapras",                           "Rare",         25,     10)
    [Card]::new("Magneton",                         "Rare",         26,     10)
    [Card]::new("Moltres",                          "Rare",         27,     10)
    [Card]::new("Muk",                              "Rare",         28,     10)
    [Card]::new("Raichu",                           "Rare",         29,     10)
    [Card]::new("Zapdos",                           "Rare",         30,     10)
    [Card]::new("Arbok",                            "Uncommon",     31,     25)
    [Card]::new("Cloyster",                         "Uncommon",     32,     25)
    [Card]::new("Gastly",                           "Uncommon",     33,     25)
    [Card]::new("Golbat",                           "Uncommon",     34,     25)
    [Card]::new("Golduck",                          "Uncommon",     35,     25)
    [Card]::new("Golem",                            "Uncommon",     36,     25)
    [Card]::new("Graveler",                         "Uncommon",     37,     25)
    [Card]::new("Kingler",                          "Uncommon",     38,     25)
    [Card]::new("Magmar",                           "Uncommon",     39,     25)
    [Card]::new("Omastar",                          "Uncommon",     40,     25)
    [Card]::new("Sandslash",                        "Uncommon",     41,     25)
    [Card]::new("Seadra",                           "Uncommon",     42,     25)
    [Card]::new("Slowbro",                          "Uncommon",     43,     25)
    [Card]::new("Tentacruel",                       "Uncommon",     44,     25)
    [Card]::new("Weezing",                          "Uncommon",     45,     25)
    [Card]::new("Ekans",                            "Common",       46,     75)
    [Card]::new("Geodude",                          "Common",       47,     75)
    [Card]::new("Grimer",                           "Common",       48,     75)
    [Card]::new("Horsea",                           "Common",       49,     75)
    [Card]::new("Kabuto",                           "Common",       50,     75)
    [Card]::new("Krabby",                           "Common",       51,     75)
    [Card]::new("Omanyte",                          "Common",       52,     75)
    [Card]::new("Psyduck",                          "Common",       53,     75)
    [Card]::new("Shellder",                         "Common",       54,     75)
    [Card]::new("Slowpoke",                         "Common",       55,     75)
    [Card]::new("Tentacool",                        "Common",       56,     75)
    [Card]::new("Zubat",                            "Common",       57,     75)
    [Card]::new("Trainer - Mr. Fuji",               "Uncommon",     58,     25)
    [Card]::new("Trainer - Energy Search",          "Common",       59,     75)
    [Card]::new("Trainer - Gambler",                "Common",       60,     75)
    [Card]::new("Trainer - Recycle",                "Common",       60,     75)
    [Card]::new("Trainer - Mysterious Fossil",      "Common",       60,     75)
)

function Get-RandomCard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [array]$CardPool
    )

    $FullWeight = ($CardPool | Measure-Object -Property Weight -Sum).Sum
    $Random     = Get-Random -Minimum 0 -Maximum $FullWeight
    $Work       = 0

    foreach ($Card in $CardPool) {
        $Work += $Card.Weight
        if ($Random -lt $Work) {
            $Card.Count += 1
            return $Card
        }
    }
}

function Get-BoosterPack {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [array]$CardPool,
        [int]$PackSize = 10
    )

    $Pack = @()
    for ($i = 0; $i -lt $PackSize; $i++) {
        $Pack += Get-RandomCard -CardPool $CardPool
    }

    return ($Pack | Sort-Object -Property {$RarityOrder.IndexOf($_.Rarity)}, {[int]$_.Number})
}





$RarityOrder = "Common", "Uncommon", "Rare", "Holo Rare"
do {
    switch ($CurrentCollection) {
        "BaseSet"   { $DisplayName = "Pokemon TCG Base Set";    $Cards = $BaseSetCards      }
        "JungleSet" { $DisplayName = "Pokemon TCG Jungle Set";  $Cards = $JungleSetCards    }
        "FossilSet" { $DisplayName = "Pokemon TCG Fossil Set";  $Cards = $FossilSetCards    }
    }

    Clear-Host
    Write-Host "===== Booster Pack Simulator ====="
    Write-Host "Selected:  $DisplayName"
    Write-Host "Collected: $(($Cards | Where-Object { $_.Count -gt 0}).Count) / $($Cards.Count)"
    Write-Host ""
    Write-Host "1. Open a booster pack"
    Write-Host "2. Change current collection"
    Write-Host "3. View current collection"
    Write-Host "4. Exit"
    Write-Host "=================================="
    $Choice = Read-Host "Choose an option"

    switch ($Choice) {
        "1" {
            Get-BoosterPack -CardPool $Cards | Select-Object -Property Number, Name, Rarity, @{N="Notes";E={if ($_.Count -eq 1){"NEW"}}} | Out-Host
            switch ($CurrentCollection) {
                "BaseSet"   { $BaseSetPacksOpened += 1      }
                "JungleSet" { $JungleSetPacksOpened += 1    }
                "FossilSet" { $FossilSetPacksOpened += 1    }
            }
            Read-Host
        }
        "2" {
            Clear-Host
            Write-Host "===== Booster Pack Simulator ====="
            Write-Host "1. Base Set"
            Write-Host "2. Jungle Set"
            Write-Host "3. Fossil Set"
            Write-Host "4. Exit"
            Write-Host "=================================="
            $Choice2 = Read-Host "Choose an option"

            $CurrentCollection = switch ($Choice2) {
                "1" { "BaseSet"     }
                "2" { "JungleSet"   }
                "3" { "FossilSet"   }
            }
        }
        "3" {
            switch ($CurrentCollection) {
                "BaseSet"   {
                    Clear-Host
                    Write-Host "===== Booster Pack Simulator ====="
                    Write-Host "Selected:       $DisplayName"
                    Write-Host "Collected:      $(($Cards | Where-Object { $_.Count -gt 0}).Count) / $($Cards.Count)"
                    Write-Host "Packs Opened:   $BaseSetPacksOpened"
                    Write-Host ""
                    $BaseSetCards | Sort-Object -Property Number | Select-Object -Unique -Property Number, @{N="Name";E={if($_.Count -gt 0){$_.Name}else{""}}}, @{N="Rarity";E={if($_.Count -gt 0){$_.Rarity}}}, @{N="Count";E={if($_.Count -gt 0){$_.Count}else{""}}} | Out-Host
                    Write-Host "=================================="
                    Read-Host
                }
                "JungleSet"   {
                    Clear-Host
                    Write-Host "===== Booster Pack Simulator ====="
                    Write-Host "Selected:       $DisplayName"
                    Write-Host "Collected:      $(($Cards | Where-Object { $_.Count -gt 0}).Count) / $($Cards.Count)"
                    Write-Host "Packs Opened:   $JungleSetPacksOpened"
                    Write-Host ""
                    $JungleSetCards | Sort-Object -Property Number | Select-Object -Unique -Property Number, @{N="Name";E={if($_.Count -gt 0){$_.Name}else{""}}}, @{N="Rarity";E={if($_.Count -gt 0){$_.Rarity}}}, @{N="Count";E={if($_.Count -gt 0){$_.Count}else{""}}} | Out-Host
                    Write-Host "=================================="
                    Read-Host
                }
                "FossilSet"   {
                    Clear-Host
                    Write-Host "===== Booster Pack Simulator ====="
                    Write-Host "Selected:       $DisplayName"
                    Write-Host "Collected:      $(($Cards | Where-Object { $_.Count -gt 0}).Count) / $($Cards.Count)"
                    Write-Host "Packs Opened:   $FossilSetPacksOpened"
                    Write-Host ""
                    $FossilSetCards | Sort-Object -Property Number | Select-Object -Unique -Property Number, @{N="Name";E={if($_.Count -gt 0){$_.Name}else{""}}}, @{N="Rarity";E={if($_.Count -gt 0){$_.Rarity}}}, @{N="Count";E={if($_.Count -gt 0){$_.Count}else{""}}} | Out-Host
                    Write-Host "=================================="
                    Read-Host
                }
            }
        }
        "4" {
            Clear-Host
            exit
        }
        default {
            Write-Host "Invalid option."
            Start-Sleep -Milliseconds 500
        }
    }
}
while ($Choice -ne 4)
