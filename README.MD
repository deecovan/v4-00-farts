# v4-00-farts GitHub and BitBucket repo
## Added Project's branch 13-add-farts-and-its-beheivours 
- Deployed BaseNPC
- Fixed most Position's issues on enter Fullscreen or on Resize window
- Working NPC's movement
- Working NPC's instantiation
- Deployed and tested main BehaviourToolkit features:
	- BTSelector with 2 Leafs
	- BT FSM with basic idle/move/stuck states and transitions
- Comment States and remove redundant logic
- Finally tested FSM with Idle/Move/Stuck
	- Separate States/Transitions and Physics process in NPCs 
	  because FSM cant process
	- Use reset_to_idle method in NPCs with forced Timer and State
	- Link FSM into NPCs via child.state_machine child.find_child(FSM)
- Start deploy BT's with Speakers/Listeners
	- Deploy FSMBT Enter, Speak-Listen and Exit
- Tag base-npc-fsm
- :) Add juicy sounds, music and CPU particles to the Speak state
