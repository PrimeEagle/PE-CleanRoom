if not pe then pe = {} end
if not pe.lib then pe.lib = {} end
if not pe.lib.biome then pe.lib.biome = {} end

local dectorio = false
local alien_biomes = false

if mods["Dectorio"] then
    dectorio = true
end

if mods["alien-biomes"] then
    alien_biomes = true
end

pe.lib.biome.biomes = { "manmade", "water", "dirt", "grass", "damaged", "desert", "volcanic", "gravel", "ice" }

pe.lib.biome.biome_map = {
    manmade = {
        "acid-refined-concrete",
        "black-refined-concrete",
        "blue-refined-concrete",
        "brown-refined-concrete",
        "concrete",
        "cyan-refined-concrete",
        "green-refined-concrete",
        "hazard-concrete-left",
        "hazard-concrete-right",
        "lab-dark-1",
        "lab-dark-2",
        "lab-white",
        "orange-refined-concrete",
        "pink-refined-concrete",
        "purple-refined-concrete",
        "red-refined-concrete",
        "refined-concrete",
        "refined-hazard-concrete-left",
        "refined-hazard-concrete-right",
        "stone-path",
        "yellow-refined-concrete"
    },
    water = {
        "deepwater",
        "deepwater-green",
        "water",
        "water-green",
        "water-mud",
        "water-shallow",
        "water-wube"
    },
    dirt = {
        "dirt-1",
        "dirt-2",
        "dirt-3",
        "dirt-4",
        "dirt-5",
        "dirt-6",
        "dirt-7",
        "dry-dirt",
        "landfill"
    },
    grass = {
        "grass-1",
        "grass-2",
        "grass-3",
        "grass-4"
    },
    damaged = {
        "nuclear-ground"
    },
    desert = {
        "red-desert-0",
        "red-desert-1",
        "red-desert-2",
        "red-desert-3",
        "sand-1",
        "sand-2",
        "sand-3"
    },
    volcanic = {},
    gravel = {},
    ice = {}
}

if (dectorio and settings.startup["pe-biomes-setting-dectorio"] and settings.startup["pe-biomes-setting-dectorio"].value) then
    if (settings.startup["dectorio-wood"] and settings.startup["dectorio-wood"].value) then
        table.insert(pe.lib.biome.biome_map.manmade, "dect-wood-floor")
    end

    if (settings.startup["dectorio-gravel"] and settings.startup["dectorio-gravel"].value) then
        table.insert(pe.lib.biome.biome_map.manmade, "dect-coal-gravel")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-copper-ore-gravel")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-iron-ore-gravel")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-stone-gravel")
    end

    if (settings.startup["dectorio-concrete"] and settings.startup["dectorio-concrete"].value) then
        table.insert(pe.lib.biome.biome_map.manmade, "dect-concrete-grid")
    end

    if (settings.startup["dectorio-painted-concrete"] and settings.startup["dectorio-painted-concrete"].value) then
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-danger")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-emergency")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-caution")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-radiation")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-defect")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-operations")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-safety")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-danger-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-emergency-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-caution-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-radiation-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-defect-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-operations-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-safety-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-danger-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-emergency-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-caution-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-radiation-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-defect-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-operations-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-safety-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-danger")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-emergency")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-caution")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-radiation")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-defect")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-operations")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-safety")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-danger-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-emergency-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-caution-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-radiation-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-defect-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-operations-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-safety-left")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-danger-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-emergency-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-caution-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-radiation-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-defect-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-operations-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-paint-refined-safety-right")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-red-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-green-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-blue-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-orange-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-yellow-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-pink-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-purple-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-black-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-brown-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-cyan-refined-concrete")
        table.insert(pe.lib.biome.biome_map.manmade, "dect-acid-refined-concrete")
    end
end


if (alien_biomes and settings.startup["pe-biomes-setting-alien-biomes"] and settings.startup["pe-biomes-setting-alien-biomes"].value) then
    if (settings.startup["dirt-aubergine"] and settings.startup["dirt-aubergine"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-aubergine-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-aubergine-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-aubergine-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-aubergine-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-aubergine-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-aubergine-dirt-6")
    end
    if (settings.startup["dirt-beige"] and settings.startup["dirt-beige"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-beige-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-beige-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-beige-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-beige-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-beige-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-beige-dirt-6")
    end
    if (settings.startup["dirt-black"] and settings.startup["dirt-black"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-black-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-black-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-black-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-black-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-black-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-black-dirt-6")
    end
    if (settings.startup["dirt-brown"] and settings.startup["dirt-brown"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-brown-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-brown-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-brown-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-brown-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-brown-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-brown-dirt-6")
    end
    if (settings.startup["dirt-cream"] and settings.startup["dirt-cream"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-cream-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-cream-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-cream-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-cream-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-cream-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-cream-dirt-6")
    end
    if (settings.startup["dirt-dustyrose"] and settings.startup["dirt-dustyrose"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-dustyrose-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-dustyrose-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-dustyrose-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-dustyrose-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-dustyrose-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-dustyrose-dirt-6")
    end
    if (settings.startup["dirt-grey"] and settings.startup["dirt-grey"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-grey-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-grey-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-grey-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-grey-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-grey-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-grey-dirt-6")
    end
    if (settings.startup["dirt-purple"] and settings.startup["dirt-purple"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-purple-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-purple-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-purple-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-purple-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-purple-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-purple-dirt-6")
    end
    if (settings.startup["dirt-red"] and settings.startup["dirt-red"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-red-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-red-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-red-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-red-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-red-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-red-dirt-6")
    end
    if (settings.startup["dirt-tan"] and settings.startup["dirt-tan"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-tan-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-tan-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-tan-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-tan-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-tan-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-tan-dirt-6")
    end
    if (settings.startup["dirt-violet"] and settings.startup["dirt-violet"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-violet-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-violet-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-violet-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-violet-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-violet-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-violet-dirt-6")
    end
    if (settings.startup["dirt-white"] and settings.startup["dirt-white"].value) then
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-white-dirt-1")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-white-dirt-2")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-white-dirt-3")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-white-dirt-4")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-white-dirt-5")
        table.insert(pe.lib.biome.biome_map.dirt, "mineral-white-dirt-6")
    end
    if (settings.startup["frozen"] and settings.startup["frozen"].value) then
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-0")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-1")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-2")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-3")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-4")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-5")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-6")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-7")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-8")
        table.insert(pe.lib.biome.biome_map.ice, "frozen-snow-9")
    end
    if (settings.startup["grass-blue"] and settings.startup["grass-blue"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-blue-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-blue-grass-2")
    end
    if (settings.startup["grass-green"] and settings.startup["grass-green"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-green-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-green-grass-2")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-green-grass-3")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-green-grass-4")
    end
    if (settings.startup["grass-mauve"] and settings.startup["grass-mauve"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-mauve-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-mauve-grass-2")
    end
    if (settings.startup["grass-olive"] and settings.startup["grass-olive"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-olive-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-olive-grass-2")
    end
    if (settings.startup["grass-orange"] and settings.startup["grass-orange"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-orange-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-orange-grass-2")
    end
    if (settings.startup["grass-purple"] and settings.startup["grass-purple"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-purple-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-purple-grass-2")
    end
    if (settings.startup["grass-red"] and settings.startup["grass-red"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-red-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-red-grass-2")
    end
    if (settings.startup["grass-turquoise"] and settings.startup["grass-turquoise"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-turquoise-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-turquoise-grass-2")
    end
    if (settings.startup["grass-violet"] and settings.startup["grass-violet"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-violet-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-violet-grass-2")
    end
    if (settings.startup["grass-yellow"] and settings.startup["grass-yellow"].value) then
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-yellow-grass-1")
        table.insert(pe.lib.biome.biome_map.grass, "vegetation-yellow-grass-2")
    end
    if (settings.startup["sand-aubergine"] and settings.startup["sand-aubergine"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-aubergine-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-aubergine-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-aubergine-sand-3")
    end
    if (settings.startup["sand-beige"] and settings.startup["sand-beige"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-beige-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-beige-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-beige-sand-3")
    end
    if (settings.startup["sand-black"] and settings.startup["sand-black"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-black-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-black-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-black-sand-3")
    end
    if (settings.startup["sand-brown"] and settings.startup["sand-brown"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-brown-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-brown-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-brown-sand-3")
    end
    if (settings.startup["sand-cream"] and settings.startup["sand-cream"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-cream-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-cream-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-cream-sand-3")
    end
    if (settings.startup["sand-dustyrose"] and settings.startup["sand-dustyrose"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-dustyrose-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-dustyrose-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-dustyrose-sand-3")
    end
    if (settings.startup["sand-grey"] and settings.startup["sand-grey"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-grey-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-grey-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-grey-sand-3")
    end
    if (settings.startup["sand-purple"] and settings.startup["sand-purple"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-purple-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-purple-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-purple-sand-3")
    end
    if (settings.startup["sand-red"] and settings.startup["sand-red"].value) then
        table.insert(pe.lib.biome.biome_map.sand, "mineral-red-sand-1")
        table.insert(pe.lib.biome.biome_map.sand, "mineral-red-sand-2")
        table.insert(pe.lib.biome.biome_map.sand, "mineral-red-sand-3")
    end
    if (settings.startup["sand-tan"] and settings.startup["sand-tan"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-tan-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-tan-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-tan-sand-3")
    end
    if (settings.startup["sand-violet"] and settings.startup["sand-violet"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-violet-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-violet-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-violet-sand-3")
    end
    if (settings.startup["sand-white"] and settings.startup["sand-white"].value) then
        table.insert(pe.lib.biome.biome_map.desert, "mineral-white-sand-1")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-white-sand-2")
        table.insert(pe.lib.biome.biome_map.desert, "mineral-white-sand-3")
    end
    if (settings.startup["volcanic-blue"] and settings.startup["volcanic-blue"].value) then
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-blue-heat-1")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-blue-heat-2")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-blue-heat-3")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-blue-heat-4")
    end
    if (settings.startup["volcanic-green"] and settings.startup["volcanic-green"].value) then
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-green-heat-1")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-green-heat-2")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-green-heat-3")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-green-heat-4")
    end
    if (settings.startup["volcanic-orange"] and settings.startup["volcanic-orange"].value) then
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-orange-heat-1")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-orange-heat-2")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-orange-heat-3")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-orange-heat-4")
    end
    if (settings.startup["volcanic-purple"] and settings.startup["volcanic-purple"].value) then
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-purple-heat-1")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-purple-heat-2")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-purple-heat-3")
        table.insert(pe.lib.biome.biome_map.volcanic, "volcanic-purple-heat-4")
    end
end

function pe.lib.biome.get_tiles(biomes)
    local tiles = {}

    if (biomes) then
        for bk, bv in pairs(biomes) do
            for tk, tv in pairs(pe.lib.biomes.biome_map[bv]) do
                table.insert(tiles, bv)
            end
        end
    end

    return tiles
end