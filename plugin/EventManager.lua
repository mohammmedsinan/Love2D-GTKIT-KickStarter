--- @class Manager
-- @field listeners table<string, function[]> A table mapping event types to listener functions.
local Manager = {
    listeners = {}
}
--- @param entity number
function Manager:registerEntity(entity)
    self.entity = entity
end
--- The function listens for an event on an entity.
--- @param self number
--- @param eventType string
--- @param listener function
--- @return nil
function Manager:addEventListener(eventType, listener)
    if not self.listeners[eventType] then
        self.listeners[eventType] = {}
    end
    table.insert(self.listeners[eventType], listener)
    return nil;
end

--- The function dispatches an event on an entity.
--- @param eventType string
--- @param event any
function Manager:dispatchEvent(eventType, event)
    if self.listeners[eventType] then
        for _, listener in ipairs(self.listeners[eventType]) do
            if event.entityA == self.entity or event.entityB == self.entity then
                listener(event)
            end
        end
    end
end

return Manager;
