local Manager = {
    listeners = {}
}

function Manager:registerEntity(entity)
    self.entity = entity
end

function Manager:addEventListener(entityId, eventType, listener)
    if not self.listeners[eventType] then
        self.listeners[eventType] = {}
    end
    table.insert(self.listeners[eventType], listener)
end

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
