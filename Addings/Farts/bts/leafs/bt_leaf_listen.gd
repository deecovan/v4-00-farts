extends BTLeaf
## A leaf is where the actual logic that controlls the actor or other nodes
## is implemented.
##
## It is the base class for all leaves and can be extended to implement
## custom behaviours.[br]
## The [code]tick(actor: Node, blackboard: Blackboard)[/code] method is called
## every frame and should return the status.


var bb_tick: int


func tick(delta: float, actor: Node, blackboard: Blackboard) -> BTStatus:
	var timer: float = blackboard.get_value("timer")
	bb_tick = blackboard.get_value("bb_tick")
	
	## If not initializes BlackBoard variables
	## Or random fail -> random select 1 of 2 leafs
	if timer == null or randf() > 0.5:
		return BTStatus.FAILURE
		
	## Else continue test one of two random leafs
	if timer > 2:
		start_actor_logic(timer, actor, blackboard)
		timer = 0.0
	
	## Update timer and exit with SUCCESS
	timer += delta
	bb_tick += 1
	blackboard.set_value("timer", timer)
	blackboard.set_value("bb_tick", bb_tick)
	return BTStatus.SUCCESS
	
	
## Working for each 1 sec (2 leafs in 2 seconds)
func start_actor_logic(_timer: float, actor: Node, _blackboard: Blackboard) -> void:
	print (actor.name, " is listening...")
