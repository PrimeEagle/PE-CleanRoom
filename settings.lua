data:extend({
    {
        type = "string-setting",
        name = "clean-room-floor-tile-setting",
        setting_type = "startup",
        default_value = "Clean Room Grid",
		allowed_values = { "Clean Room Grid", "Concrete", "Refined Concrete" }
    }
})

data:extend({
    {
        type = "int-setting",
        name = "pe-clean-room-width",
        setting_type = "startup",
        default_value = 32,
		minimum_value = 1,
		maximum_value = 100
    }
})

data:extend({
    {
        type = "int-setting",
        name = "pe-clean-room-height",
        setting_type = "startup",
        default_value = 16,
		minimum_value = 1,
		maximum_value = 100
    }
})