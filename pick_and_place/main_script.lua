function sysCall_threadmain()
-- Initialization
Target = sim.getObjectHandle('Target')
ROBOTBASE = sim.getObjectHandle('ROBOTBASE')
FLANGE = sim.getObjectHandle('FLANGE')
vel = 0.1
accel = 70
jerk = 70
currentVel = {0,0,0,0}
currentAccel = {0,0,0,0}
maxVel = {vel,vel,vel,vel}
maxAccel = {accel,accel,accel,accel}
maxJerk = {jerk,jerk,jerk,jerk}
targetVel = {0,0,0,0}
while true do
-- Move the robot above the pick-up point
quaternion1 ={0,1,4.5474735088646e-13,-4.3711565922422e-08}
position1 ={-0.62499988079071,-0.39999994635582,0.64999985694885}
sim.rmlMoveToPosition(Target,ROBOTBASE,-1,currentVel,currentAccel,maxVel,maxAccel,m
axJerk,position1,quaternion1,targetVel)
-- Wait for sensor to detect the object
while sim.getIntegerSignal('detectedBox')==1 do
detectedObjectHandle=sim.getIntegerSignal('detectedObjectHandle')
-- Move down to pick object
quaternion2 ={0,1,4.5474735088646e-13,-4.3711565922422e-08}
position2 ={-0.62499988079071,-0.39999994635582,0.57499992847443}
sim.rmlMoveToPosition(Target,ROBOTBASE,-1,currentVel,currentAccel,maxVel,maxAccel,m
axJerk,position2,quaternion2,targetVel)
-- Fake gripping
sim.setObjectInt32Parameter(detectedObjectHandle,3003,1) -- make static
sim.resetDynamicObject(detectedObjectHandle)
sim.setObjectParent(detectedObjectHandle,FLANGE,true)
-- Return to slightly upward position
sim.rmlMoveToPosition(Target,ROBOTBASE,-1,currentVel,currentAccel,maxVel,maxAccel,m
axJerk,position1,quaternion1,targetVel)

-- Travel to the correct bin based on color
quaternion3 ={0,1,4.5474735088646e-13,-4.3711565922422e-08}
local boxColor = sim.getIntegerSignal('boxColor')
local xPos = -0.07 -- Default RED
local colorName = "RED"
if boxColor == 2 then
xPos = 0.375 -- GREEN
colorName = "GREEN"
elseif boxColor == 3 then
xPos = 0.775 -- BLUE
colorName = "BLUE"
end
position3 ={xPos, -0.67499995231628, 0.77499985694885}
sim.addStatusbarMessage("Sorting object into: "..colorName.." bin (X="..xPos..")")
sim.rmlMoveToPosition(Target,ROBOTBASE,-1,currentVel,currentAccel,maxVel,maxAccel,m
axJerk,position3,quaternion3,targetVel)
-- Release object
sim.setObjectInt32Parameter(detectedObjectHandle,3003,0) -- make dynamic
sim.setObjectParent(detectedObjectHandle,-1,true) -- detach from flange
end
end
end
function sysCall_cleanup()
-- Clean-up code if needed
end