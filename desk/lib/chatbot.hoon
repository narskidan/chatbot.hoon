/-  cb=chatbot, channels, g=groups
|_  [=bowl:agent:gall =state:cb]
+|  %helpers
:: Helper functions
++  detect-group
  |=  name=@tas
  =/  groups-data  .^(groups:g %gx /(scot %p our.bowl)/groups/(scot %da now.bowl)/groups/noun)
  =/  matching-group
    %+  snag  0
    %+  skim
      ~(tap by groups-data)
      |=  n=[name=[@p @tas] data=group:g]
      ?!  .=  ~
      %+  find
        [name]~
      %+  turn
        ~(tap by channels.data.n)
      |=  n=[p=[p=@tas q=[p=@p q=@tas]] q=*]
      q:q:p:n
  matching-group
++  termify
  |=  ship=@p
  `@tas`(slav %tas (crip `tape`(slag 1 `tape`(scow %p ship))))
++  shipify
  |=  =term
  `@p`+:(scan `tape`(scow %tas term) crub:so)
+|  %sending
::  Sending messages
::  ---
++  say
  ::  (say /motluc-nammex/chill-chat 'Hello fellow humans!')
  |=  [to=channel:cb what=@t]
  ::  send a generic text message to a channel
  =/  nest  [%chat (shipify owner.to) channel:to]
  =/  memo  :*
    ~[[%inline ~[what]]]
    author=our.bowl
    sent=now.bowl
  ==
  =/  essay  [memo [%chat ~]]
  =/  post-action  [%add essay]
  =/  action  [%post post-action]
  [%pass /chat/bot %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
++  tag
  :: (tag /~motluc-nammex/h00ncr3w/chill-chat/~nospur-sontud 'Teach me shrub, bro!')
  |=  [to=whom:cb what=@t]
  ::  @ a user in a channel with a message
  ::  send a generic text message to a channel
  =/  nest  [%chat (shipify owner.to) channel:to]
  =/  memo  :*
    [i=[%inline p=[i=[%ship p=(shipify user.to)] t=[i=what t=~[[%break ~]]]]] t=~]
    author=our.bowl
    sent=now.bowl
  ==
  =/  essay  [memo [%chat ~]]
  =/  post-action  [%add essay]
  =/  action  [%post post-action]
  [%pass /chat/bot %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
++  reply
  |=  [to=thread:cb what=@t]
  :: (reply {some kind of message id and channel combo, I} 'Teach me shrub, bro!')
  =/  nest  [%chat (shipify owner.to) channel.to]
  =/  memo
    :*
      ~[[%inline ~[what]]]
      author=our.bowl
      sent=now.bowl
    ==
  =/  reply-action  [%add memo]
  =/  post-action   [%reply `@da`(slav %da id.to) reply-action]
  =/  action        [%post post-action]
  [%pass /chat/bot %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
++  delete
  |=  what=thread:cb
  =/  nest         [%chat (shipify owner.what) channel:what]
  =/  post-action  [%del `@da`(slav %da id.what)]
  =/  action       [%post post-action]
  [%pass /chat/bot %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
++  edit
  |=  [where=thread:cb what=@t]
  =/  nest  [%chat (shipify owner.where) channel:where]
  =/  memo  :*
    ~[[%inline ~[what]]]
    author=our.bowl
    sent=now.bowl
  ==
  =/  kind-data    [%chat ~]
  =/  essay        [memo kind-data]
  =/  post-action  [%edit `@da`(slav %da id.where) essay]
  =/  action       [%post post-action]
  [%pass /chat/bot %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
+|  %admin
::  Administrative tasks
::  ---
++  ban
  |=  [ship=@p =group:cb]
  =/  =action:g  [[(shipify owner.group) name.group] [now.bowl [%cordon %open %add-ships (silt ship ~)]]]
  =/  =wire  /chat/bot
  =/  =dock  [our.bowl %groups]
  =/  =cage  group-action-3+!>(action)
  [%pass wire %agent dock %poke cage]
++  role
  |=  [what=channel:cb role=term]
  :: Assign a role (allowing access to post, view certain channels, etc)
  ~
+|  %events
::  Managing events
::  ---
++  brb
  |=  when=@dr
  [%pass /timers %arvo %b %wait (add now.bowl when)]
++  sub
  ::  (see: https://github.com/tloncorp/tlon-apps/blob/develop/docs/channels.md#subscriptions)
  |=  =path
  [%pass /chat/bot %agent [our.bowl %channels] %watch path]
++  parse
  :: for examples of how incoming messages can look, see this exhaustive list:
  :: https://gist.github.com/darighost/c5911ec989bcf405846b1c98187aefd6
  |=  =sign:agent:gall
  ^-  event:cb
  ?.  ?=(%fact -.sign)  *event:cb
  ?.  ?=(%channel-response -.+.sign)  *event:cb
  =/  channel-response
    !<(r-channels-simple-post:channels q.cage.sign)
  ?.  ?=(%post -.+.channel-response)  *event:cb
  =/  channel-kind  kind.nest.channel-response
  ?.  ?=(%chat channel-kind)  *event:cb
  =/  channel  name.nest.channel-response
  =/  event  +.+.channel-response
  =/  id  id.event
  =/  rest  r-post.event
  =/  group  (detect-group channel)
  =/  channel-owner  -:+:-:(snag 0 (skim ~(tap by channels.q.group) |=(g=[[@tas [@p @tas]] *] =(channel +.+.-.g))))
  ?+  -.rest  *event:cb
    %set  
      :*  id
        `@da`~
        [-.-.group +.-.group]
        [channel-owner channel]     
        %post
        -:+:-:+:+:+:rest :: author (i know this is hideous, will rewrite this whole arm soon)
        -:-:+:+:+:rest :: content (will refactor this I promise)
      ==
    %reacts  
      :*  id
        `@da`~
        [-.-.group +.-.group]
        [channel-owner channel]     
        %emoji
        -:-:+:rest :: author (i know this is hideous, will rewrite this whole arm soon)
        +:-:+:rest
        +:-:+:rest
      ==
    %reply
      ?.  ?=(%set -.r-reply.+.rest)
        *event:cb
      :*  id
          `@da`~
          [-.-.group +.-.group]
          [channel-owner channel] 
          %reply
          author.u.+:reply.r-reply.rest
          content.u.+:reply.r-reply.rest
          'hii'
      ==
  ==
+|  %state
::  Working with state
::  ---
++  crud
  :: Chatbot state is provided as four key-value stores:
  :: User, channel, group, and global.
  :: (crud state /user/~motluc-nammex/delete/32)
  |%
  ++  get
    |=  [from=?(%user %channel %group %global) id=@]
    ^-  (list @)
    %+  fall
      %-  %~  get  by
          ?-  from  
              %user     user.state
              %channel  channel.state
              %group    group.state
              %global   global.state
            ==
      id
    ~
  ++  put
    |=  [from=?(%user %channel %group %global) id=@ value=(list @)]
    ?-  from  
      %user     =.  user.state     (~(put by user.state) [id value])     state
      %channel  =.  channel.state  (~(put by channel.state) [id value])  state
      %group    =.  group.state    (~(put by group.state) [id value])    state
      %global   =.  global.state   (~(put by global.state) [id value])   state
    ==
  ++  del
    |=  [from=?(%user %channel %group %global) id=@ value=(list @)]
    ?-  from  
      %user     =.  user.state     (~(del by user.state) id)     state
      %channel  =.  channel.state  (~(del by channel.state) id)  state
      %group    =.  group.state    (~(del by group.state) id)    state
      %global   =.  global.state   (~(del by global.state) id)   state
    ==
  --
--
