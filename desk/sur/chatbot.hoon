/-  channels
|%
+$  emoji  knot
+$  event
  $:  id=time
      parent-id=time
      $=  group    [owner=@p name=@tas]
      $=  channel  [host=@p name=@tas]
      kind=?(%post %reply %emoji)
      author=@p
      content=?(knot story:channels)
    ==
+$  ship      ?(@tas @p)
+$  group     [owner=@tas name=term ~]
+$  channel   [owner=@tas channel=term ~]
+$  whom      [owner=@tas channel=term user=@tas ~]
+$  substate  (map @ (list @))
+$  state
  $:
    $:  $=  user     substate  ==
    $:  $=  channel  substate  ==
    $:  $=  group    substate  ==
    $:  $=  global   substate  ==
  ==
--
