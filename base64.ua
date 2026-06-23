# Experimental!

Alpha ← ≡°(⋕₆₄¤) ⇡64

EncB₆₄ ← |1 (
  °⋯ ⍜≡⇌(⬚0↯∞_6) ⋯₈ # shape
  ⊏ ⊙Alpha          # alphabetize
  ♭ ⬚@=↯∞_4         # pad
)

DecB₆₄ ← |1 (
  °0 ◿₄ ⊸⧻        # check shape
  ◌ °⬚@=↙         # un pad
  ⋕₆₄ ⍉¤          # un alphabetize
  °⋯ ⍜≡⇌(↯∞_8) ⋯₆ # shape
)

┌─╴test
  # RFC test Vectors
  ⍤˜$"_ ≠ _"◠≍ "" EncB₆₄ utf₈ ""
  ⍤˜$"_ ≠ _"◠≍ "Zg==" EncB₆₄ utf₈ "f"
  ⍤˜$"_ ≠ _"◠≍ "Zm8=" EncB₆₄ utf₈ "fo"
  ⍤˜$"_ ≠ _"◠≍ "Zm9v" EncB₆₄ utf₈ "foo"
  ⍤˜$"_ ≠ _"◠≍ "Zm9vYg==" EncB₆₄ utf₈ "foob"
  ⍤˜$"_ ≠ _"◠≍ "Zm9vYmE=" EncB₆₄ utf₈ "fooba"
  ⍤˜$"_ ≠ _"◠≍ "Zm9vYmFy" EncB₆₄ utf₈ "foobar"

  RoundTrip ← ⍤˜$"_ ≠ _"◠≍ DecB₆₄ ⊸EncB₆₄

  ≡(RoundTrip ≡⋅0 ⇡) ⇡10

  # old Bouncy Castle fuzzy tests
  [
    1024 2048 4096 8192
    1025 2049 4097 8193
  ]
  ≡(RoundTrip ≡⋅⚂₂₅₆ ⇡)

  # current bouny castle test
  FailDec ← ⍤ ˜∘ ⊙˜$"Decoded _ to _" ⊸⍣(0 DecB₆₄|1 "")

  FailDec "%O4TyLWG7vjFWdKT8IJcVbZ/jwc="
  FailDec "F%I4p8Vf/mS+Kxvri3FPoMcqmJ1f"
  FailDec "UJ%EdJYodqHJmd7Rtv6/OP29/jUEFw=="
  FailDec "mO4%yLWG7vjFWdKT8IJcVbZ/jwc="
  FailDec "UJmEdJYodqHJmd7Rtv6/OP29/jUEF%=="
  FailDec "mO4TyLWG7vjFWdKT8IJcVbZ/jw%="
  FailDec "F4I4p8Vf/mS+Kxvri3FPoMcqmJ1%"
  FailDec "UJmEdJYodqHJmd7Rtv6/OP29/jUE%c=="
  FailDec "mO4TyLWG7vjFWdKT8IJcVbZ/j%c="
  FailDec "F4I4p8Vf/mS+Kxvri3FPoMcqmJ%1"
  FailDec "UJmEdJYodqHJmd7Rtv6/OP29/jU%Fc=="
  FailDec "mO4TyLWG7vjFWdKT8IJcVbZ/%wc="
  FailDec "F4I4p8Vf/mS+Kxvri3FPoMcqm%1c"
  FailDec "UJmEdJYodqHJmd7Rtv6/OP29/jUEFw=1"
  FailDec "DAxFSkJDQSBTYW"
  FailDec "M"

  DecB₆₄ "mO4TyLWG7vjFWdKT8IJcVbZ/jwc="
  ⧈⋕₁₆ [[2]] "98ee13c8b586eef8c559d293f0825c55b67f8f07"
  ⍤˜$"_ ≠ _" ◠≍

  DecB₆₄ "F4I4p8Vf/mS+Kxvri3FPoMcqmJ1f"
  ⧈⋕₁₆ [[2]] "178238a7c55ffe64be2b1beb8b714fa0c72a989d5f"
  ⍤˜$"_ ≠ _" ◠≍

  DecB₆₄ "UJmEdJYodqHJmd7Rtv6/OP29/jUEFw=="
  ⧈⋕₁₆ [[2]] "50998474962876a1c999ded1b6febf38fdbdfe350417"
  ⍤˜$"_ ≠ _" ◠≍
└─╴
