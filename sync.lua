-- local baseURL = "https://raw.githubusercontent.com/yourusername/yourrepository/main/" -- Replace with your repository URL
local baseURL = "http://127.0.0.1:10001/"

-- Define script groups and their files
local SCRIPT_GROUPS = {
    patroller = {
        files = {
            "modules/patroller/startup.lua",
            "modules/patroller/patroldoor.lua"
        },
        dependencies = {
            "lib/movementutilities/basicmovement.lua",
            "lib/movementutilities/checkfuel.lua"
        }
    },
    movementutilities = {
        files = {
            "lib/movementutilities/basicmovement.lua",
            "lib/movementutilities/checkfuel.lua"
        },
        dependencies = {}
    }
}

-- Function to ensure directory exists
local function ensureDir(path)
    local dir = path:match("^(.*)/")
    if dir then
        local parentDir = dir:match("^(.*)/")
        if parentDir and not fs.exists(parentDir) then
            fs.makeDir(parentDir)
        end
    end
end

-- Function to download and save a file
local function downloadAndSave(relativePath)
    local url = baseURL .. relativePath
    local response = http.get(url)
    if response then
        local fullPath = relativePath -- Adjust path if needed, assuming sync.lua is at root
        local file = fs.open(fullPath, "w")
        file.write(response.readAll())
        file.close()
        response.close()
        print("Downloaded: " .. relativePath)
    else
        print("Failed to download: " .. relativePath)
    end
end

-- Process all groups and their dependencies
local groupName = arg[1]
if not groupName or not SCRIPT_GROUPS[groupName] then
    print("Usage: lua sync.lua <group_name>")
    print("Available groups: ", table.concat(table.keys(SCRIPT_GROUPS), ", "))
    return
end

local groupData = SCRIPT_GROUPS[groupName]
print("--- Syncing Group: " .. groupName .. " ---")

-- 1. Sync dependencies first
for _, depFile in ipairs(groupData.dependencies) do
    ensureDir(depFile)
    downloadAndSave(depFile)
end

-- 2. Sync group files
for _, groupFile in ipairs(groupData.files) do
    ensureDir(groupFile)
    downloadAndSave(groupFile)
end
