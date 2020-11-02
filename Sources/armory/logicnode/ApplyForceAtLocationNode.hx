package armory.logicnode;

import iron.object.Object;
import iron.math.Vec4;
import armory.trait.physics.RigidBody;

using armory.object.TransformExtension;

class ApplyForceAtLocationNode extends LogicNode {

	public function new(tree: LogicTree) {
		super(tree);
	}

	override function run(from: Int) {
		var object: Object = inputs[1].get();
		var force: Vec4 = inputs[2].get();
		var localForce: Bool = inputs.length > 2 ? inputs[3].get() : false;
        	var location: Vec4 = inputs[4].get();
		var localLoc: Bool = inputs.length > 4 ? inputs[5].get() : false;

		if (object == null || force == null || location == null) return;

#if arm_physics
		var rb: RigidBody = object.getTrait(RigidBody);

		if (localLoc) {
			location.applyQuat(object.transform.rot);
		}

		!localForce ? rb.applyForce(force, location) : rb.applyForce(object.transform.worldVecToOrientation(force), location);
#end

		runOutput(0);
	}

}
