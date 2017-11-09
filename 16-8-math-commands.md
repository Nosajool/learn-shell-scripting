# 16.8 Math Commands

## "Doing the numbers"

`factor`: Decompose an integer into prime factors.

`bc`: Bash can't handle floating point calculations, and it lacks operators for certain important mathematical functions. Fortunately, bc gallops to the rescue.

Not just a versatile, arbitrary precision calculation utility, bc offers many of the facilities of a programming language. It has a syntax vaguely resembling C.

Since it is a fairly well-behaved UNIX utility, and may therefore be used in a pipe, bc comes in handy in scripts.


`dc`: The dc (desk calculator) utility is stack-oriented and uses RPN (Reverse Polish Notation). Like bc, it has much of the power of a programming language.

Similar to the procedure with bc, echo a command-string to dc.

`awk`: Yet another way of doing floating point math in a script is using awk's built-in math functions in a shell wrapper.
