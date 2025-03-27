--[[

MIT License

Copyright (c) 2024 Mohammed Sinan Almosa

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]] --
-- GTKIT - ECS Library for Love2D
-- Author: Mohammed Sinan Al-Mosa
-- Version: 1.0.0


local ECS = {
    entities = {},
    components = {},
    systems = {},
    EntityID = 0
}

-- Helper Functions
function ECS.createEntity()
    ECS.EntityID = ECS.EntityID + 1
    ECS.entities[ECS.EntityID] = {}
    return ECS.EntityID
end

function ECS.addComponent(entity, componentType, data)
    if not ECS.components[componentType] then
        ECS.components[componentType] = {}
    end
    ECS.components[componentType][entity] = data
    table.insert(ECS.entities[entity], componentType)
end

function ECS.getComponent(entity, componentType)
    return ECS.components[componentType] and ECS.components[componentType][entity]
end

function ECS.updateComponent(entity, componentType, data)
    if ECS.components[componentType] then
        ECS.components[componentType][entity] = data
    end
end

function ECS.removeComponent(entity, componentType)
    if ECS.components[componentType] then
        ECS.components[componentType][entity] = nil
    end
end

function ECS.destroyEntity(entity)
    for _, componentType in ipairs(ECS.entities[entity] or {}) do
        ECS.removeComponent(entity, componentType)
    end
    ECS.entities[entity] = nil
end

function ECS.addSystem(system)
    table.insert(ECS.systems, system)
end

function ECS.updateWorld(dt)
    for _, system in ipairs(ECS.systems) do
        system:update(dt)
    end
end

function ECS.drawWorld()
    for _, system in ipairs(ECS.systems) do
        if system.draw then
            system:draw()
        end
    end
end

function ECS.loadWorld()
    for _, system in ipairs(ECS.systems) do
        if system.load then
            system:load()
        end
    end
end

return ECS
