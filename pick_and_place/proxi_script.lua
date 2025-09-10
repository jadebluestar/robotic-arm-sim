function sysCall_threadmain()
local ProxiBoi = sim.getObjectHandle('ProxiBoi')
local customizableConveyor = sim.getObjectHandle('customizableConveyor')
-- Initialize signals
sim.setFloatSignal('conveyorBeltVelocity', 0.01) -- start conveyor
sim.setIntegerSignal('boxColor', 1)
sim.setIntegerSignal('detectedBox', 0)
sim.addStatusbarMessage("Simulation started. Conveyor running.")
local boxPreviouslyDetected = false -- track detection state
while true do
local result, _, _, detectedObjectHandle = sim.readProximitySensor(ProxiBoi)
if result > 0 then
-- Stop conveyor
sim.setFloatSignal('conveyorBeltVelocity', 0)
sim.setIntegerSignal('detectedBox', 1)
sim.setIntegerSignal('detectedObjectHandle', detectedObjectHandle)
-- Print debug message only once per detection
if not boxPreviouslyDetected then
boxPreviouslyDetected = true
sim.addStatusbarMessage("Box detected! Conveyor stopped.")
-- Detect box color
local _, rgbData = sim.getShapeColor(detectedObjectHandle, nil,
sim.colorcomponent_ambient_diffuse)
if rgbData[1] == 1 then
sim.setIntegerSignal('boxColor', 1)
sim.addStatusbarMessage("Box color: Red")
elseif rgbData[2] == 1 then
sim.setIntegerSignal('boxColor', 2)
sim.addStatusbarMessage("Box color: Green")
else
sim.setIntegerSignal('boxColor', 3)
sim.addStatusbarMessage("Box color: Blue")
end
end
else
-- Resume conveyor
sim.setFloatSignal('conveyorBeltVelocity', 0.01)
sim.setIntegerSignal('detectedBox', 0)

sim.setIntegerSignal('detectedObjectHandle', -1)
boxPreviouslyDetected = false
end
sim.wait(0.01) -- prevent CPU lock
end
end
function sysCall_cleanup()
end