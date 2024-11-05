<#
    .SYNOPSIS
    Simulates opening a pack of the Pokémon TCG's Base Set.

    .NOTES
    I made this just to mess around with weighted probability.
    All card probabilities are made up and are probably not accurate.

    I tried to make this work in PS 5.1, but arrays of hashtables are weird.
#>

#Requires -Version 7.0

$CardsBaseSet = @(
    @{
        Name    = "Alakazam"
        Rarity  = "Holo Rare"
        Number  = 1
        Weight  = 1
    },
    @{
        Name    = "Blastoise"
        Rarity  = "Holo Rare"
        Number  = 2
        Weight  = 1
    },
    @{
        Name    = "Chansey"
        Rarity  = "Holo Rare"
        Number  = 3
        Weight  = 1
    },
    @{
        Name    = "Charizard"
        Rarity  = "Holo Rare"
        Number  = 4
        Weight  = 1
    },
    @{
        Name    = "Clefairy"
        Rarity  = "Holo Rare"
        Number  = 5
        Weight  = 1
    },
    @{
        Name    = "Gyarados"
        Rarity  = "Holo Rare"
        Number  = 6
        Weight  = 1
    },
    @{
        Name    = "Hitmonchan"
        Rarity  = "Holo Rare"
        Number  = 7
        Weight  = 1
    },
    @{
        Name    = "Machamp"
        Rarity  = "Holo Rare"
        Number  = 8
        Weight  = 1
    },
    @{
        Name    = "Magneton"
        Rarity  = "Holo Rare"
        Number  = 9
        Weight  = 1
    },
    @{
        Name    = "Mewtwo"
        Rarity  = "Holo Rare"
        Number  = 10
        Weight  = 1
    },
    @{
        Name    = "Nidoking"
        Rarity  = "Holo Rare"
        Number  = 11
        Weight  = 1
    },
    @{
        Name    = "Ninetales"
        Rarity  = "Holo Rare"
        Number  = 12
        Weight  = 1
    },
    @{
        Name    = "Poliwrath"
        Rarity  = "Holo Rare"
        Number  = 13
        Weight  = 1
    },
    @{
        Name    = "Raichu"
        Rarity  = "Holo Rare"
        Number  = 14
        Weight  = 1
    },
    @{
        Name    = "Venusaur"
        Rarity  = "Holo Rare"
        Number  = 15
        Weight  = 1
    },
    @{
        Name    = "Zapdos"
        Rarity  = "Holo Rare"
        Number  = 16
        Weight  = 1
    },
    @{
        Name    = "Beedrill"
        Rarity  = "Rare"
        Number  = 17
        Weight  = 5
    },
    @{
        Name    = "Dragonair"
        Rarity  = "Rare"
        Number  = 18
        Weight  = 5
    },
    @{
        Name    = "Dugtrio"
        Rarity  = "Rare"
        Number  = 19
        Weight  = 5
    },
    @{
        Name    = "Electabuzz"
        Rarity  = "Rare"
        Number  = 20
        Weight  = 5
    },
    @{
        Name    = "Electrode"
        Rarity  = "Rare"
        Number  = 21
        Weight  = 5
    },
    @{
        Name    = "Pidgeotto"
        Rarity  = "Rare"
        Number  = 22
        Weight  = 5
    },
    @{
        Name    = "Arcanine"
        Rarity  = "Uncommon"
        Number  = 23
        Weight  = 10
    },
    @{
        Name    = "Charmeleon"
        Rarity  = "Uncommon"
        Number  = 24
        Weight  = 10
    },
    @{
        Name    = "Dewgong"
        Rarity  = "Uncommon"
        Number  = 25
        Weight  = 10
    },
    @{
        Name    = "Dratini"
        Rarity  = "Uncommon"
        Number  = 26
        Weight  = 10
    },
    @{
        Name    = "Farfetch'd"
        Rarity  = "Uncommon"
        Number  = 27
        Weight  = 10
    },
    @{
        Name    = "Growlithe"
        Rarity  = "Uncommon"
        Number  = 28
        Weight  = 10
    },
    @{
        Name    = "Haunter"
        Rarity  = "Uncommon"
        Number  = 29
        Weight  = 10
    },
    @{
        Name    = "Ivysaur"
        Rarity  = "Uncommon"
        Number  = 30
        Weight  = 10
    },
    @{
        Name    = "Jynx"
        Rarity  = "Uncommon"
        Number  = 31
        Weight  = 10
    },
    @{
        Name    = "Kadabra"
        Rarity  = "Uncommon"
        Number  = 32
        Weight  = 10
    },
    @{
        Name    = "Kakuna"
        Rarity  = "Uncommon"
        Number  = 33
        Weight  = 10
    },
    @{
        Name    = "Machoke"
        Rarity  = "Uncommon"
        Number  = 34
        Weight  = 10
    },
    @{
        Name    = "Magikarp"
        Rarity  = "Uncommon"
        Number  = 35
        Weight  = 10
    },
    @{
        Name    = "Magmar"
        Rarity  = "Uncommon"
        Number  = 36
        Weight  = 10
    },
    @{
        Name    = "Nidorino"
        Rarity  = "Uncommon"
        Number  = 37
        Weight  = 10
    },
    @{
        Name    = "Poliwhirl"
        Rarity  = "Uncommon"
        Number  = 38
        Weight  = 10
    },
    @{
        Name    = "Porygon"
        Rarity  = "Uncommon"
        Number  = 39
        Weight  = 10
    },
    @{
        Name    = "Raticate"
        Rarity  = "Uncommon"
        Number  = 40
        Weight  = 10
    },
    @{
        Name    = "Seel"
        Rarity  = "Uncommon"
        Number  = 41
        Weight  = 10
    },
    @{
        Name    = "Wartortle"
        Rarity  = "Uncommon"
        Number  = 42
        Weight  = 10
    },
    @{
        Name    = "Abra"
        Rarity  = "Common"
        Number  = 43
        Weight  = 25
    },
    @{
        Name    = "Bulbasaur"
        Rarity  = "Common"
        Number  = 44
        Weight  = 25
    },
    @{
        Name    = "Caterpie"
        Rarity  = "Common"
        Number  = 45
        Weight  = 25
    },
    @{
        Name    = "Charmander"
        Rarity  = "Common"
        Number  = 46
        Weight  = 25
    },
    @{
        Name    = "Diglett"
        Rarity  = "Common"
        Number  = 47
        Weight  = 25
    },
    @{
        Name    = "Doduo"
        Rarity  = "Common"
        Number  = 48
        Weight  = 25
    },
    @{
        Name    = "Drowzee"
        Rarity  = "Common"
        Number  = 49
        Weight  = 25
    },
    @{
        Name    = "Gastly"
        Rarity  = "Common"
        Number  = 50
        Weight  = 25
    },
    @{
        Name    = "Koffing"
        Rarity  = "Common"
        Number  = 51
        Weight  = 25
    },
    @{
        Name    = "Machop"
        Rarity  = "Common"
        Number  = 52
        Weight  = 25
    },
    @{
        Name    = "Magnemite"
        Rarity  = "Common"
        Number  = 53
        Weight  = 25
    },
    @{
        Name    = "Metapod"
        Rarity  = "Common"
        Number  = 54
        Weight  = 25
    },
    @{
        Name    = "Nidoran (Male)"
        Rarity  = "Common"
        Number  = 55
        Weight  = 25
    },
    @{
        Name    = "Onix"
        Rarity  = "Common"
        Number  = 56
        Weight  = 25
    },
    @{
        Name    = "Pidgey"
        Rarity  = "Common"
        Number  = 57
        Weight  = 25
    },
    @{
        Name    = "Pikachu"
        Rarity  = "Common"
        Number  = 58
        Weight  = 25
    },
    @{
        Name    = "Poliwag"
        Rarity  = "Common"
        Number  = 59
        Weight  = 25
    },
    @{
        Name    = "Ponyta"
        Rarity  = "Common"
        Number  = 60
        Weight  = 25
    },
    @{
        Name    = "Rattata"
        Rarity  = "Common"
        Number  = 61
        Weight  = 25
    },
    @{
        Name    = "Sandshrew"
        Rarity  = "Common"
        Number  = 62
        Weight  = 25
    },
    @{
        Name    = "Squirtle"
        Rarity  = "Common"
        Number  = 63
        Weight  = 25
    },
    @{
        Name    = "Starmie"
        Rarity  = "Common"
        Number  = 64
        Weight  = 25
    },
    @{
        Name    = "Staryu"
        Rarity  = "Common"
        Number  = 65
        Weight  = 25
    },
    @{
        Name    = "Tangela"
        Rarity  = "Common"
        Number  = 66
        Weight  = 25
    },
    @{
        Name    = "Voltorb"
        Rarity  = "Common"
        Number  = 67
        Weight  = 25
    },
    @{
        Name    = "Vulpix"
        Rarity  = "Common"
        Number  = 68
        Weight  = 25
    },
    @{
        Name    = "Weedle"
        Number  = 69
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Trainer - Clefairy Doll"
        Number  = 70
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Computer Search"
        Number  = 71
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Devolution Spray"
        Rarity  = "Rare"
        Number  = 72
        Weight  = 5
    },
    @{
        Name    = "Trainer - Impostor Professor Oak"
        Number  = 73
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Item Finder"
        Number  = 74
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Lass"
        Rarity  = "Rare"
        Number  = 75
        Weight  = 5
    },
    @{
        Name    = "Trainer - Pokemon Breeder"
        Rarity  = "Rare"
        Number  = 76
        Weight  = 5
    },
    @{
        Name    = "Trainer - Pokemon Trader"
        Number  = 77
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Scoop Up"
        Number  = 78
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Super Energy Removal"
        Number  = 79
        Rarity  = "Rare"
        Weight  = 5
    },
    @{
        Name    = "Trainer - Defender"
        Number  = 80
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Energy Retrieval"
        Number  = 81
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Full Heal"
        Number  = 82
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Maintenance"
        Number  = 83
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - PlusPower"
        Number  = 84
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Pokemon Center"
        Number  = 85
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Pokemon Flute"
        Number  = 86
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Pokedex"
        Number  = 87
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Professor Oak"
        Number  = 88
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Revive"
        Number  = 89
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Super Potion"
        Number  = 90
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Trainer - Bill"
        Number  = 91
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Trainer - Energy Removal"
        Number  = 92
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Trainer - Gust of Wind"
        Number  = 93
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Trainer - Potion"
        Number  = 94
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Trainer - Switch"
        Number  = 95
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Energy - Double Colorless"
        Number  = 96
        Rarity  = "Uncommon"
        Weight  = 10
    },
    @{
        Name    = "Energy - Fighting"
        Number  = 97
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Energy - Fire"
        Number  = 98
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Energy - Grass"
        Number  = 99
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Energy - Electric"
        Number  = 100
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Energy - Psychic"
        Number  = 101
        Rarity  = "Common"
        Weight  = 25
    },
    @{
        Name    = "Energy - Water"
        Number  = 102
        Rarity  = "Common"
        Weight  = 25
    }
)

function Get-RandomCard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [array]$CardPool,
        [int]$Count = 1
    )

    $TotalWeight = ($CardPool | Measure-Object -Property Weight -Sum).Sum
    $DrawnCards = @()

    for ($i = 0; $i -lt $Count; $i++) {
        $RandomNumber       = Get-Random -Minimum 0 -Maximum $TotalWeight
        $CumulativeWeight   = 0

        foreach ($Card in $CardPool) {
            $CumulativeWeight += $Card.Weight
            if ($RandomNumber -lt $CumulativeWeight) {
                $DrawnCards += $Card
                break
            }
        }
    }

    return $DrawnCards | Sort-Object -Property { $RarityOrder.IndexOf($_.Rarity) }, { [int]$_.Number } | Select-Object -Property Number, Name, Rarity
}

function Get-BoosterPack {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [array]$CardPool,
        [int]$PackSize = 10,
        [int]$NonCommonsAllowed
    )

    if ($null -eq $NonCommonsAllowed) { $NonCommonsAllowed = Get-Random -Minimum 3 -Maximum 5 }
    $BoosterPack = @(
        Get-RandomCard -CardPool $CardPool -Count ($PackSize - $NonCommonsAllowed)
        Get-RandomCard -CardPool ($CardPool | Where-Object { $_.Rarity -eq "Uncommon" }) -Count ($NonCommonsAllowed - 1)
    )

    if ((Get-Random -Minimum 0 -Maximum 5) -eq 1) {
        $BoosterPack += @(
            Get-RandomCard -CardPool ($CardPool | Where-Object { $_.Rarity -eq "Holo Rare" }) -Count 1
        )
    }
    else {
        $BoosterPack += @(
            Get-RandomCard -CardPool ($CardPool | Where-Object { $_.Rarity -eq "Rare" }) -Count 1
        )
    }

    return $BoosterPack | Sort-Object -Property { $RarityOrder.IndexOf($_.Rarity) }, { [int]$_.Number } | Select-Object -Property Number, Name, Rarity
}



$RarityOrder = "Common", "Uncommon", "Rare", "Holo Rare"

Clear-Host
Get-BoosterPack -CardPool $CardsBaseSet
