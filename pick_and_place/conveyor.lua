function sysCall_init()
forwarder = sim.getObjectHandle('customizableConveyor_forwarder')
textureShape = sim.getObjectHandle('customizableConveyor_tableTop')
sim.addStatusbarMessage("Conveyor script initialized.")
end
function sysCall_cleanup()
end
function sysCall_actuation()
local targetVel = sim.getFloatSignal('conveyorBeltVelocity') or 0.1
-- Move conveyor texture
local t = sim.getSimulationTime()
sim.setObjectFloatParameter(textureShape, sim.shapefloatparam_texture_x, t * targetVel)
if targetVel == 0 then
-- Stop all boxes physically
local boxes = sim.getObjectsInTree(sim.handle_scene, sim.object_shape_type)
for i = 1, #boxes do
local box = boxes[i]
sim.setObjectFloatParameter(box, sim.shapefloatparam_init_velocity_x, 0)
sim.setObjectFloatParameter(box, sim.shapefloatparam_init_velocity_y, 0)
sim.setObjectFloatParameter(box, sim.shapefloatparam_init_velocity_z, 0)
end
-- Optionally stop forwarder visually too
sim.setObjectFloatParameter(forwarder, sim.shapefloatparam_init_velocity_x, 0)
sim.setObjectFloatParameter(forwarder, sim.shapefloatparam_init_velocity_y, 0)
sim.setObjectFloatParameter(forwarder, sim.shapefloatparam_init_velocity_z, 0)
else
-- Move forwarder normally
local relativeLinearVelocity = {targetVel, 0, 0}
sim.resetDynamicObject(forwarder)
local m = sim.getObjectMatrix(forwarder, -1)
m[4] = 0; m[8] = 0; m[12] = 0
local absVel = sim.multiplyVector(m, relativeLinearVelocity)
sim.setObjectFloatParameter(forwarder, sim.shapefloatparam_init_velocity_x,
absVel[1])
sim.setObjectFloatParameter(forwarder, sim.shapefloatparam_init_velocity_y,
absVel[2])
sim.setObjectFloatParameter(forwarder, sim.shapefloatparam_init_velocity_z,
absVel[3])
end
end