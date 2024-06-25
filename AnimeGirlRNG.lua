local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Anime Girl RNG",
   LoadingTitle = "Anime Girl RNG",
   LoadingSubtitle = "by kagari1314",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Anime Girl RNG"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Toggle = Tab:CreateToggle({
   Name = "Auto Summon (Quick Roll)",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
      if Value then
         startAutoSummon()
      else
         stopAutoSummon()
      end
   end,
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CORE_RemoteEvents = ReplicatedStorage:WaitForChild("CORE_RemoteEvents")
local sendSummonRequestEvent = CORE_RemoteEvents:WaitForChild("SendSummonRequest")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local autoSummonEnabled = false

-- Function to trigger the RemoteEvent
local function triggerSummonRequest()
    while autoSummonEnabled do
        sendSummonRequestEvent:FireServer()
        wait(0.000000000000000000000000000001)  -- Add a delay to prevent the loop from running too fast
    end
end

-- Function to start auto summon
function startAutoSummon()
    autoSummonEnabled = true
    triggerSummonRequest()
end

-- Function to stop auto summon
function stopAutoSummon()
    autoSummonEnabled = false
end
