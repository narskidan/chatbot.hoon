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
  =/  kind-data  [%chat ~]
  =/  essay  [memo kind-data]
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
  =/  kind-data  [%chat ~]
  =/  essay  [memo kind-data]
  =/  post-action  [%add essay]
  =/  action  [%post post-action]
  [%pass /chat/bot %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
++  reply
  :: (tag /~motluc-nammex/h00ncr3w/chill-chat/~nospur-sontud 'Teach me shrub, bro!')
  |=  [to=whom:cb what=@t]
  ::  @ a user in a channel with a message
  ~
+|  %admin
::  Administrative tasks
::  ---
++  join
  |=  what=group:cb
  ::  Attempt to join a group
  ~
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
  ::  r-channels is from the channels sur file.
  ::  channel-response is a mark used to interpret it (I think)
  ::  https://github.com/tloncorp/tlon-apps/blob/develop/desk/mar/channel/response.hoon
  |=  =sign:agent:gall
  ^-  event:cb
  ?.  ?=(%fact -.sign)  *event:cb
  ?.  ?=(%channel-response -.+.sign)  *event:cb
  =/  channel-response
    !<([nest=[kind=?(%chat %diary %heap) ship=@p name=@tas] r-channel-simple-post:channels] q.cage.sign)
  ?.  ?=(%post -.+.channel-response)  *event:cb
  =/  channel-kind  kind.nest.channel-response
  =/  channel  name.nest.channel-response
  =/  event  +.+.channel-response
  =/  id  id.event
  =/  rest  r-post.event
  =/  group  (detect-group channel)
  =/  channel-owner  -:+:-:(snag 0 (skim ~(tap by channels.q.group) |=(g=[[@tas [@p @tas]] *] =(channel +.+.-.g))))
  ::  [host=@p group=@tas channel=@tas kind=?(%chat %diary %heap)]
  ?+  -.rest  *event:cb
    %set  :*  id
              [-.-.group +.-.group]
              [channel-owner channel channel-kind]     
              %post
              -:+:-:+:+:+:rest :: author (i know this is hideous, will rewrite this whole arm soon)
              -:-:+:+:+:rest
          ==
    ::  deal with other types of incoming messages lol
  ==
  :: There are a few things that `rest` might contain
  :: 
  :: For chat channels, here's what can happen:
  :: [id=~2024.7.2..04.55.47..b889 kind=%chat ship=~motluc-nammex name=%goals-bot]
  ::
  :: A completely new thread in a chat channel
  :: [ %set
  ::   post
  ::     [ ~
  ::       [ [ id=~2024.7.2..04.40.06..1668
  ::           reacts=~
  ::           replies={}
  ::           reply-meta=[reply-count=0 last-repliers=~ last-reply=~]
  ::         ]
  ::         [ content=[i=[%inline p=[i='Totally new post' t=[i=[%break ~] t=~]]] t=~]
  ::           author=~sapruc-bostyn-motluc-nammex
  ::           sent=~2024.7.2..04.40.05..c418.9374.bc6a.7ef9
  ::         ]
  ::         kind-data=[%chat kind=~]
  ::       ]
  ::     ]
  ::   ]
  ::
  :: A reply to an existing chat post:
  ::   [ %reply
  ::   id=~2024.7.2..05.02.32..fd89
  ::     reply-meta
  ::   [ reply-count=1
  ::     last-repliers=[n=~sannem-ligpex l={} r={}]
  ::     last-reply=[~ ~2024.7.2..05.02.32..fd89]
  ::   ]
  ::     r-reply
  ::   [ %set
  ::       reply
  ::     [ ~
  ::       [ [ id=~2024.7.2..05.02.32..fd89
  ::           parent-id=~2024.7.2..04.55.47..b889
  ::           reacts=~
  ::         ]
  ::           content
  ::         [i=[%inline p=[i='hi there this is a reply!' t=[i=[%break ~] t=~]]] t=~]
  ::         author=~sannem-ligpex
  ::         sent=~2024.7.2..05.02.32..970a.3d70.a3d7.0a3d
  ::       ]
  ::     ]
  ::   ]
  :: ]
  ::
  :: An emoji reaction:
  :: [%reacts reacts=[n=[p=~sannem-ligpex q=~.:blush:] l=~ r=~]]
  ::
  :: For media channels:
  :: [ id=~2024.7.2..05.27.18..1b64
  ::   kind=%heap
  ::   ship=~motluc-nammex
  ::   name=%beats-and-vidz
  :: ]
  ::
  :: Creating new post in media channel (this is a text post)
  :: [ %set
  ::     post
  ::   [ ~
  ::     [ [ id=~2024.7.2..05.27.18..1b64
  ::         reacts=~
  ::         replies={}
  ::         reply-meta=[reply-count=0 last-repliers=~ last-reply=~]
  ::       ]
  ::       [ content=[i=[%inline p=[i='new block baby' t=[i=[%break ~] t=~]]] t=~]
  ::         author=~sapruc-bostyn-motluc-nammex
  ::         sent=~2024.7.2..05.27.17..dae1.47ae.147a.e147
  ::       ]
  ::       kind-data=[%heap title=[~ '']]
  ::     ]
  ::   ]
  :: ]
  ::
  :: replying to a post in a media channel:
  :: [ %reply
  ::   id=~2024.7.2..05.37.49..8819
  ::     reply-meta
  ::   [ reply-count=1
  ::     last-repliers=[n=~sapruc-bostyn-motluc-nammex l={} r={}]
  ::     last-reply=[~ ~2024.7.2..05.37.49..8819]
  ::   ]
  ::     r-reply
  ::   [ %set
  ::       reply
  ::     [ ~
  ::       [ [ id=~2024.7.2..05.37.49..8819
  ::           parent-id=~2024.7.2..05.27.18..1b64
  ::           reacts=~
  ::         ]
  ::         content=[i=[%inline p=[i='reply guy' t=[i=[%break ~] t=~]]] t=~]
  ::         author=~sapruc-bostyn-motluc-nammex
  ::         sent=~2024.7.2..05.37.49..3e76.c8b4.3958.1062
  ::       ]
  ::     ]
  ::   ]
  :: ]
  ::
  :: heap emoji reaction:
  ::   [ %reply
  ::   id=~2024.7.2..05.37.49..8819
  ::     reply-meta
  ::   [ reply-count=1
  ::     last-repliers=[n=~sapruc-bostyn-motluc-nammex l={} r={}]
  ::     last-reply=[~ ~2024.7.2..05.37.49..8819]
  ::   ]
  ::     r-reply
  ::   [%reacts reacts=[n=[p=~sapruc-bostyn-motluc-nammex q=~.:grinning:] l=~ r=~]]
  :: ]
  ::
  :: And finally, diary posts:
  :: [ id=~2024.7.2..05.41.55..3069
  ::   kind=%diary
  ::   ship=~motluc-nammex
  ::   name=%bulletin-board
  :: ]
  :: [ %set
  ::     post
  ::   [ ~
  ::     [ [ id=~2024.7.2..05.41.55..3069
  ::         reacts=~
  ::         replies={}
  ::         reply-meta=[reply-count=0 last-repliers=~ last-reply=~]
  ::       ]
  ::       [ content=[i=[%inline p=[i='hi there' t=[i=[%break ~] t=~]]] t=~]
  ::         author=~sannem-ligpex
  ::         sent=~2024.7.2..05.41.54..d374.bc6a.7ef9.db22
  ::       ]
  ::       kind-data=[%diary title='new post hehe' image='']
  ::     ]
  ::   ]
  :: ]
  ::
  :: Leaving comment:
  :: [ %reply
  ::   id=~2024.7.2..05.44.22..51cd
  ::     reply-meta
  ::   [ reply-count=1
  ::     last-repliers=[n=~sapruc-bostyn-motluc-nammex l={} r={}]
  ::     last-reply=[~ ~2024.7.2..05.44.22..51cd]
  ::   ]
  ::     r-reply
  ::   [ %set
  ::       reply
  ::     [ ~
  ::       [ [ id=~2024.7.2..05.44.22..51cd
  ::           parent-id=~2024.7.2..05.41.55..3069
  ::           reacts=~
  ::         ]
  ::         content=[i=[%inline p=[i='hi there' t=[i=[%break ~] t=~]]] t=~]
  ::         author=~sapruc-bostyn-motluc-nammex
  ::         sent=~2024.7.2..05.44.21..f999.9999.9999.9999
  ::       ]
  ::     ]
  ::   ]
  :: ]
  ::
  :: Diary comment emoji reaction:
  :: [ %reply
  ::   id=~2024.7.2..05.44.22..51cd
  ::     reply-meta
  ::   [ reply-count=1
  ::     last-repliers=[n=~sapruc-bostyn-motluc-nammex l={} r={}]
  ::     last-reply=[~ ~2024.7.2..05.44.22..51cd]
  ::   ]
  ::   r-reply=[%reacts reacts=[n=[p=~sannem-ligpex q=~.:kissing_heart:] l=~ r=~]]
  :: ]
  :: we need to create the proper structure depending on which of the above we match...
  :: for now, we'll just not worry about it lol
  :: the other stuff is in 'rest'
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
  --
--
