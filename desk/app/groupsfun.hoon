/-  channels, c=chatbot
/+  default-agent, dbug, chatbot
=|  =state.c
|_  =bowl:gall
+*  this      .
    default   ~(. (default-agent . %|) bowl)
    bot       ~(. chatbot [bowl state])
++  on-init
  :_  this
  :~  (sub:bot /)
  ==
++  on-save   on-save:default
++  on-load   on-load:default
++  on-poke   on-poke:default
++  on-arvo   on-arvo:default
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent
  |=  [=wire:agent:gall =sign:agent:gall]
  =/  event       (parse:bot sign)
  =/  owner       owner.where.event
  =/  author      author.what.event
  =/  history     (fall (get:crud:bot %user author) ~)
  =/  updated     (snoc history now.bowl)
  =/  new-state   (put:crud:bot %user author updated)
  =/  irrelevant  ?|(=(~zod owner) =(author our.bowl))
  ?:  irrelevant  `this
  =/  new-poster  (lte (lent history) 7)
  ?:  new-poster  `this(state new-state)
  =/  last-seven  (flop (scag 7 (flop history)))
  =/  oldest  (snag 0 recent)
  :_  this(state new-state)
  ?.  (lth (sub now.bowl oldest) ~s20)  ~
  =/  host     (termify:bot host.where.event)
  =/  channel  channel.where.event
  :~  (tag:bot [host (termify:bot author) ~] ' Flood detected, bannished')
      (ban:bot author [owner group.where.event ~])
  ==
++  on-fail   on-fail:default
--