# Experimental!

~ "parser.ua" ~ IRCLine Parse
~ "base64.ua" ~ EncB₆₄
~ "config.ua" ~ Channel DataUrl Name Pass Server Tls

Wr ← |2 ⊸&w $"_\r\n" &p ⊸$"\tCLIENT: _"

Line ← |1 (
  ⍣°$"_\r"∘ °$"_\n" &ru "\n"
  Parse ⊸(&p $"\tSERVER: _")
)

FmtTime ← |1 (
  +×3600 timezone
  datetime
  ⍚(⬚@0↙¯⊙°⋕) [4 2 2 2 2 2]
  °[°$"_-_-_ _:_:_"]
)

KillPre ← |1 ⍣(◌ °$":_ _")∘

Pong ← |2 (
  IRCLine.Args
  Wr $"PONG :_" °□₁
)

PingWhile! ← |1.2 ◌ ⍢(
  |3.3 ◌◌
  ⊸Line
  ⊸IRCLine.Cmd

  ⍣⊸₂(⍩Pong °"PING")∘
| ^0
) "" NaN

Listener ← |1.0 ◌ ⍢(
  ⊸Line
  ⊸IRCLine.Cmd

  ⍣(⍩Pong °"PING"
  | |3 °"PRIVMSG"
    °Name ⍩°□₂ ⊸IRCLine.Args
    Wr $"PRIVMSG _ :_" IRCLine.Name ˜∘
  | ⋅⋅∘
  )
| 1
)

SafeFetch ← |0 (⍢(⍣(°utf₈ &fetch DataUrl ◌|&sl 0.5 &p "fetch errored")|≍"") "")
GetState ← |0 (°□ get □"state" °json SafeFetch)

(⨬&tcpc &tlsc Tls) Server

# ⊸&tcpsrt ∞

Wr $ CAP REQ :sasl
Wr $"USER _ 0 * :_" Name Name
Wr $"NICK _" Name
PingWhile!⍣(0 °"CAP"|1)
°{"*" "ACK" "sasl"} IRCLine.Args

Wr $ AUTHENTICATE PLAIN
PingWhile!⍣(0 °"AUTHENTICATE"|1)
°{"+"} IRCLine.Args

Wr $"AUTHENTICATE _" EncB₆₄ utf₈ $"\0_\0_" Name Pass
◌ PingWhile!⍣(0 °"903"|1)

Wr $ CAP END

◌ PingWhile!⍣(0 °"376"|0 °"422"|1)
Wr $"JOIN #_" Channel

◌ $sockId ⊸spawn!Listener

⍢(GetState
  °□₂ ≡⌟get {"open" "lastchange"}

  ⟜(
    ⊃($same = ⊙⋅∘
    | $"space _ at _" ⊓(
        ⨬"closed" "opened"
      | FmtTime
      )
    )
  
    ⨬(Wr $"PRIVMSG #_ :_" Channel)◌
  )

  &p "polled"
  &sl 20
| 1
) W

$ ============
$     EXIT
$ ============
&p
