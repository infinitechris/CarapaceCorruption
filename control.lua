-- Test-phase configuration: allied-only spawning with a fixed 180-second cadence.
-- The structure exists as a player-aligned spawn anchor; the units are free to test
-- spacing, safe placement, and dynamic separation without enemy interference.
local PERIODIC_TICK = 180
local STRUCTURE_NAME = "carapace-nexus"
local ALLIED_NAME = "carapace-sentinel"
local BARREL_NAME = "cyber-slurry-barrel"
local SAFE_RADIUS = 6.0
local SPAWN_OUTER_RADIUS = 12.0
local MAX_ALLIES_PER_STRUCTURE = 3
local ENEMY_REACTION_RADIUS = 12.0

local function distance_between(a, b)
  local dx = a.x - b.x
  local dy = a.y - b.y
  return math.sqrt(dx * dx + dy * dy)
end

local function spawn_allied_unit(surface, structure)
  local angle = math.random() * math.pi * 2
  local radius = SAFE_RADIUS + (math.random() * (SPAWN_OUTER_RADIUS - SAFE_RADIUS))
  local pos = {
    x = structure.position.x + math.cos(angle) * radius,
    y = structure.position.y + math.sin(angle) * radius
  }

  local valid_pos = surface.find_non_colliding_position(ALLIED_NAME, pos, 4, 0.5)
  if valid_pos then
    pos = valid_pos
  end

  local entity = surface.create_entity({
    name = ALLIED_NAME,
    position = pos,
    force = "player"
  })

  if entity and entity.valid then
    entity.ai_settings.allow_destroy_when_commands_fail = true
  end

  return entity
end

local function on_entity_created(event)
  local entity = event.created_entity or event.entity

  if entity and entity.valid and entity.name == STRUCTURE_NAME then
    local surface = entity.surface
    local nearby = surface.count_entities_filtered({
      name = ALLIED_NAME,
      force = "player",
      area = {
        { entity.position.x - SPAWN_OUTER_RADIUS, entity.position.y - SPAWN_OUTER_RADIUS },
        { entity.position.x + SPAWN_OUTER_RADIUS, entity.position.y + SPAWN_OUTER_RADIUS }
      }
    })

    if nearby < MAX_ALLIES_PER_STRUCTURE then
      spawn_allied_unit(surface, entity)
    end
  end
end

local function output_is_full(structure)
  if not structure or not structure.valid then
    return true
  end

  local output_inventory = structure.get_inventory(defines.inventory.assembling_machine_output)
  if not output_inventory then
    return true
  end

  return output_inventory.get_item_count(BARREL_NAME) >= 1
end

local function fill_internal_barrel(structure)
  if not structure or not structure.valid then
    return
  end

  if output_is_full(structure) then
    return
  end

  local output_inventory = structure.get_inventory(defines.inventory.assembling_machine_output)
  if not output_inventory then
    return
  end

  output_inventory.insert({ name = BARREL_NAME, count = 1 })
end

local function nearest_enemy_in_range(surface, position)
  local enemies = surface.find_entities_filtered({
    force = "enemy",
    type = "unit",
    area = {
      { position.x - ENEMY_REACTION_RADIUS, position.y - ENEMY_REACTION_RADIUS },
      { position.x + ENEMY_REACTION_RADIUS, position.y + ENEMY_REACTION_RADIUS }
    }
  })

  if #enemies == 0 then
    return nil
  end

  table.sort(enemies, function(a, b)
    return distance_between(position, a.position) < distance_between(position, b.position)
  end)

  return enemies[1]
end

local function spawn_test_enemy_if_needed(surface, structure)
  local probe_pos = {
    x = structure.position.x + 10,
    y = structure.position.y
  }

  local nearby_enemies = surface.count_entities_filtered({
    force = "enemy",
    type = "unit",
    area = {
      { probe_pos.x - 4, probe_pos.y - 4 },
      { probe_pos.x + 4, probe_pos.y + 4 }
    }
  })

  if nearby_enemies > 0 then
    return
  end

  surface.create_entity({
    name = "small-biter",
    position = probe_pos,
    force = "enemy"
  })
end

local function react_to_nearby_enemies()
  for _, surface in pairs(game.surfaces) do
    local allies = surface.find_entities_filtered({
      name = ALLIED_NAME,
      force = "player"
    })

    for _, ally in pairs(allies) do
      if ally and ally.valid then
        local ok, has_set_command = pcall(function()
          return ally.set_command ~= nil
        end)

        if ok and has_set_command then
          local enemy = nearest_enemy_in_range(surface, ally.position)

          local command = {
            type = defines.command.wander,
            ticks_to_wait = 30
          }

          if enemy and enemy.valid then
            command = {
              type = defines.command.attack,
              target = enemy,
              distraction = defines.distraction.by_damage
            }
          end

          pcall(function()
            ally.set_command(command)
          end)
        end
      end
    end
  end
end

local function periodic_checks()
  for _, surface in pairs(game.surfaces) do
    local structures = surface.find_entities_filtered({ name = STRUCTURE_NAME })

    for _, structure in pairs(structures) do
      if structure.valid then
        local allied = surface.find_entities_filtered({
          name = ALLIED_NAME,
          force = "player",
          area = {
            { structure.position.x - SPAWN_OUTER_RADIUS, structure.position.y - SPAWN_OUTER_RADIUS },
            { structure.position.x + SPAWN_OUTER_RADIUS, structure.position.y + SPAWN_OUTER_RADIUS }
          }
        })

        local is_full = output_is_full(structure)

        if not is_full and #allied < MAX_ALLIES_PER_STRUCTURE then
          spawn_allied_unit(surface, structure)
        end

        spawn_test_enemy_if_needed(surface, structure)
        fill_internal_barrel(structure)
      end
    end
  end

  react_to_nearby_enemies()
end

local function grant_free_nexus(player)
  if not player or not player.valid then
    return
  end

  local inventory = player.get_main_inventory()
  if inventory and inventory.get_item_count(STRUCTURE_NAME) == 0 then
    inventory.insert({ name = STRUCTURE_NAME, count = 1 })
  end
end

script.on_event(defines.events.on_player_created, function(event)
  local player = game.get_player(event.player_index)
  grant_free_nexus(player)
end)

script.on_event(defines.events.on_built_entity, on_entity_created)
script.on_event(defines.events.on_robot_built_entity, on_entity_created)
script.on_event(defines.events.script_raised_built, on_entity_created)
script.on_nth_tick(PERIODIC_TICK, periodic_checks)
