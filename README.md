# Pooling Objects
Implementation of object pooling for Game Maker Studio 2. 
Works only for GMS2.3+.

# Setup 
First, import [Pooling_Objects.yymps](ttps://github.com/JeffersonJales/pooling_objects/releases/download/Pooling_obj_1_1_0/Pooling_Objects.yyz) to your project. 
Now put the object "obj_pooling_objects" on the first room of the game. 

# Functions
``` gml
pooling_objects_get_instance(obj_index)
```
*Retuns*: instance_id. Instance of the object obj_index.  
| Name| Datatype| 
|--|--|
| obj_index| object asset index |

Will try to get a previous deactivated instance of this object. 
Case it fails will instantiate a new instance of the object. 

#

``` gml
pooling_objects_deactive_instance(instance = self)
```
*Returns: N/A.*
| Name| Datatype| Purpose 
|--|--|--|
| instance | instance_id |  The instance that will be deactivated. Self as default.

Deactivate an instance. Can be activated again with pooling_objects_get_instance. 

Deactivate an instance created without the pooling_objects_get_instance will result in a crash.
#

```gml
pooling_object_set_reload_callback(callback)
```
*Returns: N/A*
| Name| Datatype| Purpose 
|--|--|--|
| callback | method/function | The function the instance will call when getting back from the pool.

By default, when getting an instance from the pool, it will perform its own create event again. 
Use this to change that, creating a new "create event" for this instance. 


# Example
You can also download the project and see the example and see how you can use this lib.

![enter image description here](https://github.com/JeffersonJales/pooling_objects/blob/master/example_obj_pooling.gif?raw=true)

> Written with [StackEdit](https://stackedit.io/).
