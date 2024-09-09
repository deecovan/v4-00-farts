extends BTLeaf
## A leaf is where the actual logic that controlls the actor or other nodes
## is implemented.
##
## It is the base class for all leaves and can be extended to implement
## custom behaviours.[br]
## The [code]tick(actor: Node, blackboard: Blackboard)[/code] method is called
## every frame and should return the status.


func tick(delta: float, _actor: Node, blackboard: Blackboard) -> BTStatus:
	var timer: float = blackboard.get_value("timer")
	## If not initializes BlackBoard variables
	## Or random fail -> random select 1 of 2 leafs
	if timer == null or randf() > 0.5:
		return BTStatus.FAILURE
	## Else continue test one of two random leafs
	if timer > 2.0:
		print(name, ": ", timer)
		timer = 0.0
	## Update timer and exit with SUCCESS
	timer += delta
	blackboard.set_value("timer", timer)
	return BTStatus.SUCCESS
