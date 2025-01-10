local utils = {};

function utils.Print(t)
    for key, value in pairs(t) do
        if type(value) == "table" then
            print(key .. " = {")
            utils.Print(value)  -- Recursively print nested tables
            print("}")
        else
            print(key .. " = " .. tostring(value))
        end
    end
end

_G.Print = utils.Print;

return utils;
