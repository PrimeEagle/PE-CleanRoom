if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

pe.cr.path = "__PE-CleanRoom__"

require("prototypes/tile/pe-grid-clean-room")

require("prototypes/technology/pe-semiconductors")

require("prototypes/entity/pe-nano-electric-pole")
require("prototypes/item/pe-nano-electric-pole")
require("prototypes/recipe/pe-nano-electric-pole")

require("prototypes/entity/pe-circuit-pole")
require("prototypes/item/pe-circuit-pole")
require("prototypes/recipe/pe-circuit-pole")

require("prototypes/entity/pe-nano-circuit-pole")
require("prototypes/item/pe-nano-circuit-pole")
require("prototypes/recipe/pe-nano-circuit-pole")

require("prototypes/entity/pe-nano-io-electric-pole")
require("prototypes/item/pe-nano-io-electric-pole")

require("prototypes/entity/pe-nano-io-circuit-pole")
require("prototypes/item/pe-nano-io-circuit-pole")

require("prototypes/entity/pe-underground-electric-pole")

require("prototypes/entity/pe-cleanroom")
require("prototypes/item/pe-cleanroom")
require("prototypes/recipe/pe-cleanroom")