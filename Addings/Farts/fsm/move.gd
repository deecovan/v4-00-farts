extends FSMState
## A state in a [FiniteStateMachine]. This is the base class for all states.
##
## It's a basic building block to build full State Machines, only one state
## held by [FiniteStateMachine] is active, to switch to a different state,
## a [FSMTransition] must be triggered or you can use FSM methods to switch
## states manually.
## To implement your logic you can override the [code]_on_enter, _on_update and
## _on_exit[/code] methods when extending the node's script.


## Executes after the state is entered.
func _on_enter(actor: Node, _blackboard: Blackboard) -> void:
	#### Continue from BaseNPC script	
	if actor.velocity.length() < 200 and actor.timer > 3:
		while not actor.set_current_target(actor.get_random_position()):
			print("%s can't move to %s, re-target" % [actor.name, actor.target])
		#print(actor.name, " Moving to ", actor.target)
		actor.timer = 0.0


## Executes every process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	pass
