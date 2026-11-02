-- sync.lua
-- A downloader script for ComputerCraft modules.

local moduleName = arg[1]
local baseUrl = "http://127.0.0.1:10001/"

if not moduleName then
    print("Available modules: patroller")
    print("Usage: sync <module_name>")
    return
end

-- NOTE: In a real-world scenario, this dependency map would be dynamically generated
-- by parsing module metadata or a manifest file. For this example, we hardcode
-- the dependencies based on the user's provided structure for 'patroller'.
local moduleDependencies = {
    patroller = {
        files = {
            "patrol.lua",
            "startup.lua"
        },
        dependencies = {
            "utilities/init.lua",
            "utilities/movement/basic.lua",
            "utilities/movement/fuel.lua",
            "utilities/movement/init.lua",
            "utilities/init.lua"
        }
    }
}
-- Function to download a file and place it in the correct local path
local function downloadFile(remotePath, localPath)
    local url = baseUrl .. remotePath
    print("Attempting to download " .. remotePath .. " from " .. url)

    -- In a real ComputerCraft environment, you would use http.get() or similar.
    -- For this simulation, we create a placeholder file.
    local file = io.open(localPath, "w")
    if file then
        response = http.get(url)
        if response then
            local content = response.readAll()
            file:write(content)
            response.close()
        else
            print("Error: Failed to download " .. remotePath)
        end
    else
        print("Error: Could not open file for writing at " .. localPath)
    end
end

-- 1. Download the main module files (e.g., patrol.lua, startup.lua)
-- These files are assumed to be directly inside the module folder.
local mainModuleFiles = moduleDependencies[moduleName].files

for _, localPath in ipairs(mainModuleFiles) do
    -- Transform remote path (modules/patroller/patrol.lua) to local path (patrol.lua)
    local remotePath = "modules/" .. moduleName .. "/" .. localPath
    downloadFile(remotePath, localPath)
end

-- 2. Download dependencies
local dependencies = moduleDependencies[moduleName].dependencies
if dependencies then
    for _, remotePath in ipairs(dependencies) do
        -- Dependencies are already structured relative to the root (e.g., utilities/movement/basic.lua)
        local localPath = remotePath
        downloadFile(remotePath, localPath)
    end
end

-- 2. Download dependencies
local dependencies = moduleDependencies[moduleName]
if dependencies then
    for _, remotePath in ipairs(dependencies) do
        -- Dependencies are already structured relative to the root (e.g., utilities/movement/basic.lua)
        local localPath = remotePath
        downloadFile(remotePath, localPath)
    end
else
    print("Error: No dependencies defined for module '" .. moduleName .. "'")
end

print("Sync complete.")
