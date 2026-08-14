local cyber_tint = { r = 0.24, g = 0.96, b = 0.68, a = 0.90 }

local function tint_animation(animation, tint)
  if not animation then
    return animation
  end

  if animation.layers then
    for _, layer in pairs(animation.layers) do
      if layer.filename then
        layer.tint = tint
      end
    end
  elseif animation.filename then
    animation.tint = tint
  end

  return animation
end

data:extend({
  {
    type = "item-group",
    name = "carapace-corruption",
    icon = "__base__/graphics/icons/creative-mod-gui.png",
    icon_size = 64,
    order = "e",
    inventory_order = "e"
  },
  {
    type = "item-subgroup",
    name = "carapace-raw",
    group = "carapace-corruption",
    order = "a"
  },
  {
    type = "item-subgroup",
    name = "carapace-production",
    group = "carapace-corruption",
    order = "b"
  },
  {
    type = "fluid",
    name = "cyber-slurry",
    icon = "__base__/graphics/icons/fluid/water.png",
    icon_size = 64,
    default_temperature = 25,
    max_temperature = 100,
    base_color = { r = 0.18, g = 0.82, b = 0.62 },
    flow_color = { r = 0.48, g = 1.00, b = 0.72 },
    pressure_to_speed_ratio = 0.4,
    flow_to_energy_ratio = 0.4,
    auto_barrel = true,
    order = "a"
  },
  {
    type = "recipe",
    name = "cyber-slurry-production",
    category = "carapace-incubation",
    enabled = true,
    energy_required = 1.5,
    ingredients = {},
    results = {
      { type = "fluid", name = "cyber-slurry", amount = 50 }
    },
    subgroup = "carapace-production",
    order = "a"
  },
  {
    type = "item",
    name = "carapace-nexus",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    place_result = "carapace-nexus",
    stack_size = 10,
    subgroup = "carapace-production",
    order = "a"
  },
  {
    type = "assembling-machine",
    name = "carapace-nexus",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64,
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 0.3, result = "carapace-nexus" },
    max_health = 260,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "medium-explosion",
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    crafting_categories = { "carapace-incubation" },
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 0 },
      drain = "20kW"
    },
    energy_usage = "90kW",
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
          tint = cyber_tint
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
          tint = cyber_tint
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
        volume = 1000,
        pipe_connections = {
          { flow_direction = "output", direction = defines.direction.east, position = { 1.1, 0.0 } }
        },
        secondary_draw_orders = { north = -1 }
      }
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.5 },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.5 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.5 }
  },
  (function()
    local ally = table.deepcopy(data.raw["unit"]["small-biter"])
    ally.name = "carapace-sentinel"
    ally.icon = "__base__/graphics/icons/small-biter.png"
    ally.icon_size = 64
    ally.max_health = 90
    ally.movement_speed = 0.31
    ally.vision_distance = 32
    ally.selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } }
    ally.attack_parameters.range = 1.4
    ally.attack_parameters.cooldown = 30
    ally.attack_parameters.damage_modifier = 1.0
    ally.pollution_to_join_attack_ratio = 0

    if ally.run_animation then
      tint_animation(ally.run_animation, cyber_tint)
    end

    if ally.attack_parameters and ally.attack_parameters.animation then
      tint_animation(ally.attack_parameters.animation, cyber_tint)
    end

    if ally.stand_animation then
      tint_animation(ally.stand_animation, cyber_tint)
    end

    return ally
  end)()
})
