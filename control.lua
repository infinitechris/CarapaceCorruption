local PERIODIC_TICK = 60

local function on_entity_created(event)
  local entity = event.created_entity or event.entity

  if entity and entity.valid then
    if entity.name == "incubator-pen" then
      -- Initial incubator setup can be placed here.
    end
  end
end

local function periodic_checks()
  for _, surface in pairs(game.surfaces) do
    local incubators = surface.find_entities_filtered({ name = "incubator-pen" })

    for _, incubator in pairs(incubators) do
      if incubator.valid then
        local fluid = incubator.fluidbox and incubator.fluidbox[1]

        if fluid and fluid.name == "cyber-slurry" and fluid.amount > 0 then
          -- Periodic logic for slurry-bearing incubators goes here.
        end
      end
    end
  end
end

script.on_event(defines.events.on_built_entity, on_entity_created)
script.on_event(defines.events.on_robot_built_entity, on_entity_created)
script.on_event(defines.events.script_raised_built, on_entity_created)
script.on_nth_tick(PERIODIC_TICK, periodic_checks)
