/-  channels
|%
+$  event
  $:  id
      owner=@p
      group=@tas
      host=@p
      channel=@tas
      kind=?(%chat %diary %heap)]
      :: TODO: 
      :: content should be a ?() representing
      :: either replies, emojis, posts, etc.
      author=@p
      content=*
    ==
+$  group     [owner=term name=term ~]
+$  channel   [owner=term channel=term ~]
+$  whom      [owner=term channel=term user=term ~]
+$  substate  (map @ (list @))
+$  state
  $:
    $:  $=  user     substate  ==
    $:  $=  channel  substate  ==
    $:  $=  group    substate  ==
    $:  $=  global   substate  ==
  ==
--