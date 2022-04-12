# Godot VR starter project

My VR game development practice by following the official tutorial [VR starter tutorial]https://docs.godotengine.org/en/3.1/tutorials/vr/vr_starter_tutorial.html)

Adopted to WebXR by attaching WebXR setup script (Game.gd)

The build, export, running instructions are the same as this project [Apple thinning WebXR project](https://github.com/Jade1724/godot-apple-picking-prototype-v1)

## My learning notes

### VR interaction methodology

**Raycast node**: Useful for casing ray from controller.

**GrabCast node**: Used for picking up objects if the player is using Raycast node to pick up objects.

**Area node**: Detect objects in the area. Useful for having them around the players hand to directly pick up objects.

`VR_Controller.gd` on the Left_Controller node contains the controller logic. 

**controller_velocity** To get smooth motion of the controllers, calculation of the average velocity and from previous frames is done. See `_physics_process()`

### Node structure design

The teleport mesh is under `Game` node rather than Controllers node. This is becuase the teleport node should not inheret the position and rotation from the controller. 

## Questions

- In `_physics_process()` in `VR_Controller.gd`, why do I check if the ARVR controller is active after setting the teloport area? Isn't the controller check should be done before anything?

