local baseURL = "https://raw.githubusercontent.com/yourusername/yourrepository/main/" -- Replace with your repository URL

local url = baseURL .. fileName
local response = http.get(url)
if response then
    local file = fs.open(fileName, "w")
    file.write(response.readAll())
    file.close()
    response.close()
    print("Downloaded: " .. fileName)
else
    print("Failed to download: " .. fileName)
end
