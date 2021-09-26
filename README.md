# Pooling Objects
An implementation of object pooling for Game Maker Studio 2. 
Works only for GMS2.3+.

# Setup 
First, import [Pooling_Objects.yymps](https://github.com/JeffersonJales/pooling_objects/releases/download/Pooling_obj_releases/Pooling_Objects.yymps) to your project. 
Them,  put the object "obj_pooling_objects" on the first room of the game. 

# Functions
``` gml
pooling_objects_get_instance(obj_index)
```
*Retuns*: instance_id. Instance of the object obj_index.  
| Name| Datatype| 
|--|--|
| obj_index| object asset index |

Will try to get a previous deactevated instance of this object. 
Case it fails, will instantiate a new instance of the object.
#
``` gml
pooling_objects_deactive_instance(instance = self)
```
*Returns: N/A.*
| Name| Datatype| Purpose 
|--|--|--|
| instance | instance_id |  The instance that will be deactivated. Self as default.

Deactive an instance. Can be activated again with pooling_objects_get_instance. 

Deactivate an instance created without the pooling_objects_get_instance will result in a crash.


# Example
You can also download the project and see the example and see how you can use this lib. [Pooling_Objects_With_Examples.yy](https://github.com/JeffersonJales/pooling_objects/releases/download/Pooling_obj_releases/Pooling_Objects_With_Examples.yyz)

![enter image description here](https://github.com/JeffersonJales/pooling_objects/blob/master/example_obj_pooling.gif?raw=true)

> Written with [StackEdit](https://stackedit.io/).
