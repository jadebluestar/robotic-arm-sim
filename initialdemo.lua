function sysCall_init()
    -- Get joint handles (same as before)
    jointHandles = {}
    jointNames = {'rotary_head', 'lower_arm', 'upper_arm', 'forearm_twisting', 'wrist', 'axis6'}
    
    for i, name in ipairs(jointNames) do
        local handle = sim.getObject('/' .. name)
        if handle ~= -1 then
            local objectType = sim.getObjectType(handle)
            if objectType == sim.object_joint_type then
                jointHandles[i] = handle
                sim.setJointMode(handle, sim.jointmode_kinematic, 0)
                print('Found joint: ' .. name)
            end
        end
    end
    
    -- Simple demo: define 3 key positions
    step = 1
    stepTime = 0
    
    -- Position arrays: [rotary_head, lower_arm, upper_arm, forearm_twisting, wrist, axis6]
    homePos =     {0,    0,    0,    0,    0,    0}     -- Start position
    pickPos =     {0.8,  -0.5, 0.5,  0,    0.8,  0}     -- Pick location
    placePos =    {-0.8, -0.5, 0.5,  0,    0.8,  0}     -- Place location
    
    currentPos = {0, 0, 0, 0, 0, 0}  -- Current joint positions
    
    print("Simple pick and place demo ready!")
    print("Step 1: Home -> Step 2: Pick -> Step 3: Place -> Step 4: Home")
end

function sysCall_actuation()
    stepTime = stepTime + sim.getSimulationTimeStep()
    
    -- Change positions every 4 seconds
    if stepTime > 4 then
        step = step + 1
        stepTime = 0
        
        if step > 4 then step = 1 end  -- Loop back to start
        
        if step == 1 then
            print("Moving to HOME position")
            targetPos = homePos
        elseif step == 2 then  
            print("Moving to PICK position")
            targetPos = pickPos
        elseif step == 3 then
            print("Moving to PLACE position")  
            targetPos = placePos
        elseif step == 4 then
            print("Returning to HOME")
            targetPos = homePos
        end
    end
    
    -- Smoothly move to target position
    local speed = 0.02  -- Movement speed
    
    for i = 1, #jointHandles do
        if jointHandles[i] and targetPos then
            local diff = targetPos[i] - currentPos[i]
            
            -- Move towards target
            if math.abs(diff) > 0.01 then
                local step = math.min(speed, math.abs(diff))
                if diff < 0 then step = -step end
                currentPos[i] = currentPos[i] + step
            else
                currentPos[i] = targetPos[i]  -- Snap to target when close
            end
            
            -- Apply position to joint
            sim.setJointPosition(jointHandles[i], currentPos[i])
        end
    end
end

function sysCall_cleanup()
    -- Return to home
    for i, handle in ipairs(jointHandles) do
        if handle then
            sim.setJointPosition(handle, 0)
        end
    end
end