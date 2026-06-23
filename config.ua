Parse ↚ map ⊜(
  °$"_=_"
  ⊓(⌵ ⊣°¤ regex "^\\s*(\\w+)\\s*$"|□°json)
) ⊸≠@\n

Get ↚ |1 °□get ⊓(□⌵|Parse &fras "irc.cfg")

Channel ← memo!(Get "channel")
Name    ← memo!(Get "name")
Pass    ← memo!(Get "pass")
Server  ← memo!(Get "server")
Tls     ← memo!(Get "tls")
DataUrl ← memo!(Get "dataUrl")

┌─╴test
  $ arr = [1, 2]
  $ var =     "str"
  $ num = 2.1
  Parse
  map {"arr" "var" "num"} {[1 2] "str" 2.1}
  ⍤⤙≍ ⍜°map⌵
└─╴
