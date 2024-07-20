/-  channels, cb=chatbot
/+  default-agent, chatbot
=|  =state.cb
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
  =/  event      (parse:bot sign)
  =/  author     author.event
  =/  history    (get:crud:bot %user author)
  =/  new-state  (put:crud:bot %user author [now.bowl history])
  ?~  id.event   `this
  :_  this(state new-state)
  ?:  (lte (lent history) 7)  ~
  ?:  (gth (sub now.bowl (snag 0 history)) ~s20)  ~
  =/  host   (termify:bot host.channel.event)
  =/  owner  (termify:bot owner.group.event)
  =/  whom   [host name.channel.event (termify:bot author) ~]
  :~  (tag:bot whom ' Flood detected, bannished')
      (ban:bot author [owner name.group.event ~])
  ==
++  on-fail   on-fail:default
--
