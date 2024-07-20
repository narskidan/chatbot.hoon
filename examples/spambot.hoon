/-  cb=chatbot
/+  default-agent, chatbot
=|  =state.cb
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent . %|) bowl)
    bot      ~(. chatbot [bowl state])
++  on-init
  :_  this
  :~  (brb:bot ~s1)
  ==
++  on-save   on-save:default
++  on-load   on-load:default
++  on-poke   on-poke:default
++  on-arvo
  |=  [=wire =sign-arvo]
  :_  this
  :~  (brb:bot ~s1)
      (say:bot /motluc-nammex/test-48 'make tlon irc again')
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
