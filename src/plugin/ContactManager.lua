local EventSystem = require "plugin.EventManager"

local Manager = {}

function Manager.beginContact(entityA, entityB, coll)
    entityA = entityA:getUserData()
    entityB = entityB:getUserData()

    if entityA and entityB then
        EventSystem:dispatchEvent("onEnter", {
            entityA = entityA,
            entityB = entityB,
            contact = coll
        })
    end
end

function Manager.endContact()
end

function Manager.preSolve()
end

function Manager.postSolve()
end

return Manager;
