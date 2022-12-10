-- DDDDDDDDDDDDD        IIIIIIIIII          CCCCCCCCCCCCC     SSSSSSSSSSSSSSS 
-- D::::::::::::DDD     I::::::::I       CCC::::::::::::C   SS:::::::::::::::S
-- D:::::::::::::::DD   I::::::::I     CC:::::::::::::::C  S:::::SSSSSS::::::S
-- DDD:::::DDDDD:::::D  II::::::II    C:::::CCCCCCCC::::C  S:::::S     SSSSSSS
--   D:::::D    D:::::D   I::::I     C:::::C       CCCCCC  S:::::S            
--   D:::::D     D:::::D  I::::I    C:::::C                S:::::S            
--   D:::::D     D:::::D  I::::I    C:::::C                 S::::SSSS         
--   D:::::D     D:::::D  I::::I    C:::::C                  SS::::::SSSSS    
--   D:::::D     D:::::D  I::::I    C:::::C                    SSS::::::::SS  
--   D:::::D     D:::::D  I::::I    C:::::C                       SSSSSS::::S 
--   D:::::D     D:::::D  I::::I    C:::::C                            S:::::S
--   D:::::D    D:::::D   I::::I     C:::::C       CCCCCC              S:::::S
-- DDD:::::DDDDD:::::D  II::::::II    C:::::CCCCCCCC::::C  SSSSSSS     S:::::S
-- D:::::::::::::::DD   I::::::::I     CC:::::::::::::::C  S::::::SSSSSS:::::S
-- D::::::::::::DDD     I::::::::I       CCC::::::::::::C  S:::::::::::::::SS 
-- DDDDDDDDDDDDD        IIIIIIIIII          CCCCCCCCCCCCC   SSSSSSSSSSSSSSS
------------------------------------------------------------------------------
----------------------- Dynamic Interactive Car System -----------------------
------------------------------------------------------------------------------

DICS = {}
DICS.SERVER_TICK = 24

local realm = {
    SERVER = 0,
    CLIENT = 1,
    SHARED = 2
}

local function prefixToRealm( sPrefix )
    return sPrefix == "sv" and realm.SERVER or (sPrefix == "cl" and realm.CLIENT or realm.SHARED)
end

local function loadFile( sFilePath )
    local iRealm = prefixToRealm( sFilePath )
    if( SERVER ) then
        if( iRealm == realm.CLIENT or iRealm == realm.SHARED ) then
            AddCSLuaFile( sFilePath )
        end

        if( iRealm == realm.SERVER or iRealm == realm.SHARED ) then
            include( sFilePath )
        end
    elseif( iRealm == realm.CLIENT or iRealm == realm.SHARED ) then
        include( sFilePath )
    end
end

local function loadFolder( sFolderPath )
    local tFiles, tDirectories = file.Find( sFolderPath .. "/*", "LUA" )
    for i = 1, #tFiles do
        loadFile( sFolderPath .. "/" .. tFiles[i] )
    end

    if( #tDirectories < 1 ) then return end

    for i = 1, #tDirectories do
        loadFolder( sFolderPath .. "/" .. tDirectories[i] )
    end
end

loadFolder( "dics/damagesystem" )
loadFolder( "dics/hud" )

loadFile( "drive/drive_dics_vehicle.lua" )

concommand.Add( "test_movecalss", function()
    print( FrameTime(), 1 / FrameTime() )
end )