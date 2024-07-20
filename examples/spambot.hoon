/-  cb=chatbot
/+  default-agent, chatbot
|_  =bowl:gall
+*  this      .
    default   ~(. (default-agent . %|) bowl)
    bot       ~(. chatbot [bowl state])
++  on-init
  :_  this
  :~  (sub:bot /)
      (brb:bot ~s1)
  ==
++  on-save   on-save:default
++  on-load   on-load:default
++  on-poke   on-poke:default
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  :_  this
  :~  (brb:bot ~s1)
      (say /motluc-nammex/test 'make tlon irc again')
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
