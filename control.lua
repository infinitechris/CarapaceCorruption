local PERIODIC_TICK = 60
local STRUCTURE_NAME = "carapace-nexus"
local ALLIED_NAME = "carapace-sentinel"
local SAFE_RADIUS = 4.0
local SPAWN_OUTER_RADIUS = 8.0
local MAX_ALLIES_PER_STRUCTURE = 3

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

local function push_allied_away(structure, unit)
  if not (structure and structure.valid) or not (unit and unit.valid) then
    return
  end

  local dist = distance_between(structure.position, unit.position)
  if dist >= SAFE_RADIUS then
    return
  end

  local dx = unit.position.x - structure.position.x
  local dy = unit.position.y - structure.position.y
  local length = math.sqrt(dx * dx + dy * dy)

  if length == 0 then
    dx = 1
    dy = 0
    length = 1
  end

  local target = {
    x = unit.position.x + (dx / length) * 3,
    y = unit.position.y + (dy / length) * 3
  }

  local safe_target = unit.surface.find_non_colliding_position(ALLIED_NAME, target, 5, 0.5) or target
  unit.set_command({
    type = defines.command.go_to_location,
    destination = safe_target,
    radius = 2
  })
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

        if #allied < MAX_ALLIES_PER_STRUCTURE then
          spawn_allied_unit(surface, structure)
        end

        for _, unit in pairs(allied) do
          push_allied_away(structure, unit)
        end
      end
    end
  end
end

script.on_event(defines.events.on_built_entity, on_entity_created)
script.on_event(defines.events.on_robot_built_entity, on_entity_created)
script.on_event(defines.events.script_raised_built, on_entity_created)
script.on_nth_tick(PERIODIC_TICK, periodic_checks)
