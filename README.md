# Raydetection MK 2 - Module for hit detection.
### **Raycast-Based Hitboxes Module.**
My new and improved version of my old "Raydetection" module.  In development.

Some may ask: *"Why this when you can do :GetPartsInPart?"* 
Firstly, I like to reinvent the wheels. Secondly, this thing is sloow.
(really recommend not to use it bcuz it's just a pile of my stuff that's comfortable to me. but hey if you like it ofc use it)

### Features:

 - *Multiple Modes*
     **Directional** and **Omni-Directional(TODO)**
     
 - *Good Perfomance*
 - *Intended for clientside use. Still useable on server*

 ### Documentation
 ---
**Methods**

Raydetection Instance **`Raydetection.newDirectional(Instance part, String dir, Number volume)`**
 - Creates a Raydetection instance with a Directional mode. 
 - "dir" is a direction of a raycast, these are the options:
 - The amount of created Attachments depends on the "volume". Example - on a 4x4 part, volume 2 will equal to 4*4 attachment on one face.
1. Front, Back (X)
2. Left, Right (Z)
3. Up, Down (Y)

Raydetection Instance **`Raydetection.newOmnidirectional(TODO)`**

nil **`Raydetection:StartCast(Number frames, Bool cleanOnCast)` ASYNC** 
- Starts raycasting for set amount of frames. 
- If cleanOnCast set to true, :Cleanup() method is automatically called on cast stop.

 nil **`Raydetection:Cleanup()`**
 - Clean's up all attachments made by instance.

---
**Properties**

- `BasePart` [Instance] - Base part, specified while creating an instance
 - `CastDirEnum` [table, Vector3] - Enum of a part CFrame directions.
 - `Length` [number] - Length of a ray.
 - `RayParams` [RaycastParams] - RaycastParams instance used for raycasting.
 - `Hit` [Event] (RaycastResult rayResult) - Event fires when raycast hits something.
 
 *Directional only:*
 - `Attachments` [table, Instance] - Table of all attachments made by this Raydetection Instance
 - `FromPart` [Instance] - Defaulted to BasePart. Directions will be calculated using THIS part.
 - `RayDir` [Vector3] - Direction of a raycast.

