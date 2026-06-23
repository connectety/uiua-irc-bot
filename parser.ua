# Experimental!

~IRCLine {
  Name ← ""
  Host ← ""
  Nick ← ""
  Cmd ← ""
  Args ← ""
}

LTrim ← |1 ◌ ⍜⇌°⬚@ ↙
Param ← |1 ⍣(
  □₀ °""
| □₁ °$":_"
| ⊂□ ⊙Param °$"_ _"
| □₁
) LTrim

Param′ ← |1 ◌ ⍢(
  ⍣("" ˜⊂□ °$":_"
  | ⊙(˜⊂□) °˜$"_ _"
  | "" ˜⊂□
  )
  LTrim
| ¬≍""
) ⊙{} LTrim

Parse ← |1 IRCLine!(
  ⊙New
  ⍣(
    °˜$":_ _"
    ⊙⍣(⊙°⊸Host °$"_@_")∘
    ⊙⍣(⊙°⊸Nick °$"_!_")∘
  
    ⊙°⊸Name
    LTrim
  )∘

  ⊙(°⊸Cmd ⌵) ⍣°˜$"_ _" ""
  °⊸Args Param
) ⯾₁∞

┌─╴test
  $ :vindobona.hackint.org NOTICE * :*** Checking Ident
  $ PING    :76717E6B
  $ :vindobona.hackint.org 001 DoorDBot :Welcome to the hackint Internet Relay Chat Network DoorDBot
  $ :vindobona.hackint.org 376 DoorDBot :End of /MOTD command.
  $ :DoorDBot!~DoorDBot@net.isp.de    JOIN     #tmp55245               
  $ :irc.example.net 422 Tety :MOTD File is missing
  $ :irc.example.net NOTICE Tety :*** Looking up your hostname
  $ :alice!user@example.org PRIVMSG Tety :hello world
  $ :bob!~bob@host PRIVMSG #chat :message with spaces
  $ :bob!~bob@host PaRT #chat :bye
  $ :bob!~bob@host QUIT :Ping timeout
  $ :dan!~dan@2001:db8::1 PRIVMSG #chat :Hello from IPv6 land
  $ :prefix PING
  °/$"_\n_"

  ⍤"All Parse" ≍ ∩⧻ ⊸≡◇Parse
└─╴
