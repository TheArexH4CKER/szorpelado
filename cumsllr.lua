task.wait(30)
while game.PlaceId ~= 15502339080 do 
    game:GetService("TeleportService"):Teleport(15502339080, game.Players.LocalPlayer)
    task.wait(10)
end

-- CLAIM RANDOM BOOTH
pcall(function()
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Booths_WipeSavedListings"):FireServer()
    task.wait(2)
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Booths_ClaimAnyBooth"):InvokeServer()
end)

-- RECONNECT
spawn(loadstring(game:HttpGet("https://gist.githubusercontent.com/AnigamiYT/d7ef2f539343b0d16e416d5f924ddfaa/raw/gistfile1.txt")))

-- LOW CPU
spawn(loadstring(game:HttpGet("https://gist.githubusercontent.com/AnigamiYT/43254dd3deabfd6b0743aadb2f5933a6/raw/gistfile1.txt")))


-- ANTI-AFK
local vu = game:GetService("VirtualUser")
game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

local price = 62500 -- itt a price nigga

local function sellItem()
    local Buckets = {} 
    for ItemUID, ItemData in pairs(require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Misc) do
        if ItemData.id == "Bucket O' Magic" then
            local amount = ItemData._am or 1
            table.insert(Buckets, {uid = ItemUID, amount = amount})
        end
    end

    for _, BucketData in pairs(Buckets) do
        local amountToList = math.min(BucketData.amount, 5000)

        local args = {
            BucketData.uid,
            price,
            amountToList
        }

        local success, result
        repeat
            task.wait()
            success, result = pcall(function()
                return game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Booths_CreateListing"):InvokeServer(unpack(args))
            end)
        until success
        task.wait(5)
    end
end

spawn(function()
    while true do
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
        end)
        task.wait(600)
    end
end)

while true do
    sellItem()
    task.wait(5)
end
