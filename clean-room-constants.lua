if not pe then pe = {} end
if not pe.cr then pe.cr = {} end

pe.cr.CLEAN_ROOM_SURFACE_PREFIX = "cleanroom_"
pe.cr.BLUEPRINT_TAG_NAME = "cleanroom"
pe.cr.MAX_SURFACE_WIDTH = 100
pe.cr.MAX_SURFACE_HEIGHT = 100
pe.cr.CLEANROOM = "pe-cleanroom"

pe.allowedSubgroups = { 	
						"circuit-network",
						"circuit-combinator",
						"circuit-connection",
						"circuit-auditory" 
					}


pe.excludedItems = { 	
					"pe-cleanroom", 
					"enemy-motion-sensor", 
					"friendly-motion-sensor", 
					"remote-explosive",
					"daylight-sensor",
					"pollution-sensor",
					"pressure-plate",
					"circuit-network-transceiver",
				}
					
pe.additionalAllowedItems = {
							"flying-text",
							"pe-nano-electric-pole",
							"pe-nano-io-electric-pole",
							"pe-nano-circuit-pole",
							"pe-nano-io-circuit-pole",
							"hs_hologram_animated" 
						 }
