/-  channels
|%
+$  emoji  knot
+$  kind   ?(%post %reply %emoji)
+$  event
  $:  id=time
      parent-id=time
      $=  group    [owner=@p name=@tas]
      $=  channel  [host=@p name=@tas]
      kind=kind
      author=@p
      content=?(knot story:channels)
    ==
+$  ship       ?(@tas @p)
+$  group      [owner=@tas name=@tas ~]
+$  channel    [owner=@tas channel=@tas ~]
+$  whom       [owner=@tas channel=@tas user=@tas ~]
+$  thread     [owner=@tas channel=@tas id=@ta ~]
+$  substate   (map @ (list @))
+$  state
  $:
    $:  $=  user     substate  ==
    $:  $=  channel  substate  ==
    $:  $=  group    substate  ==
    $:  $=  global   substate  ==
  ==
--
