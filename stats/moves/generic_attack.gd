extends Node

func do_effect(user, target):
  print("doing effect of generic attack on target %s" % target)
  target.take_damage(user.attack)
