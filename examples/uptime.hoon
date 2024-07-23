/-  cb=chatbot
/+  default-agent, chatbot
=|  =state.cb
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent . %|) bowl)
    bot      ~(. chatbot [bowl state])
++  on-init
  :_  this
  :~  (brb:bot ~m2)
  ==
++  on-save   on-save:default
++  on-load   on-load:default
++  on-poke   on-poke:default
++  on-arvo
  |=  [=wire =sign-arvo]
  ?+  wire  `this
    [%timers ~]
      =/  url  'https://darigo.su'
      =/  =request:http  [%'GET' url ~ ~]
      =/  =task:iris  [%request request *outbound-config:iris]
      :_  this
      :~  [%pass /uptime %arvo %i task]
          (brb:bot ~m2)
      ==
    [%uptime ~]
      =/  status-code  -.-.+.+.+.sign-arvo
      ?:  =(200 status-code)  
        `this
      :_  this
      =/  whom  /motluc-nammex/bots/motluc-nammex
      =/  what  ' darigo.su is down!'
      (tag:bot whom what)
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
