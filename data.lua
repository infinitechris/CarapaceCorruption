data:extend({
  {
    type = "fluid",
    name = "cyber-slurry",
    default_temperature = 25,
    max_temperature = 100,
    base_color = { r = 0.26, g = 0.78, b = 0.55 },
    flow_color = { r = 0.60, g = 1.00, b = 0.80 },
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.4,
    auto_barrel = false,
    order = "a"
  },
  {
    type = "recipe",
    name = "cyber-slurry-production",
    category = "carapace-incubation",
    enabled = true,
    energy_required = 1,
    ingredients = {},
    results = {
      { type = "fluid", name = "cyber-slurry", amount = 50 }
    },
    subgroup = "fluid",
    order = "a"
  },
  {
    type = "item",
    name = "incubator-pen",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    place_result = "incubator-pen",
    stack_size = 10,
    subgroup = "production",
    order = "a"
  },
  {
    type = "assembling-machine",
    name = "incubator-pen",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.3, result = "incubator-pen" },
    max_health = 250,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "medium-explosion",
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    crafting_categories = { "carapace-incubation" },
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 1.5 },
      drain = "20kW"
    },
    energy_usage = "80kW",
    ingredient_count = 0,
    module_specification = { module_slots = 0 },
    allowed_effects = {},
    animation = {
      layers = {
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
          priority = "high",
          width = 108,
          height = 110,
          frame_count = 32,
          line_length = 8,
          shift = { 0.0, -0.1 },
          scale = 0.8,
          tint = { r = 0.40, g = 0.80, b = 0.60, a = 0.90 }
        }
      }
    },
    working_visualisations = {
      {
        animation = {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-working.png",
          priority = "high",
          width = 108,
          height = 110,
          frame_count = 32,
          line_length = 8,
          shift = { 0.0, -0.1 },
          scale = 0.8,
          tint = { r = 0.40, g = 0.80, b = 0.60, a = 0.90 }
        }
      }
    },
    fluid_boxes = {
      {
        production_type = "output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {
          { flow_direction = "output", direction = defines.direction.east, position = { 1.5, 0.0 } }
        },
        secondary_draw_orders = { north = -1 }
      }
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.5 },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.5 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.5 }
  },
  (function()
    local biter = table.deepcopy(data.raw["unit"]["small-biter"])
    biter.name = "carapace-biter"
    biter.icon = "__base__/graphics/icons/small-biter.png"
    biter.icon_size = 64
    biter.max_health = 90
    biter.movement_speed = 0.28
    biter.vision_distance = 32
    biter.selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } }
    biter.attack_parameters.range = 1.2

    if biter.run_animation and biter.run_animation.layers then
      for _, layer in pairs(biter.run_animation.layers) do
        layer.tint = { r = 0.40, g = 0.80, b = 0.60, a = 0.80 }
      end
    end

    if biter.attack_parameters and biter.attack_parameters.animation and biter.attack_parameters.animation.layers then
      for _, layer in pairs(biter.attack_parameters.animation.layers) do
        layer.tint = { r = 0.40, g = 0.80, b = 0.60, a = 0.80 }
      end
    end

    return biter
  end)()
})
