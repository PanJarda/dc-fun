#!/usr/bin/dc
# stack num to ascii
[
	P
	z 0 !=z
] sz

# split hex num to list
[
	d
	100 %
	r
	100 /
	d Z 2 <y
] sy
16i
?
Ai	# back to decimal input
5617843187844953170308463622230283376298685	# RSA private key
9516311845790656153499716760847001433441357	# modulus
|
16i	# hex input
lyx
f
lzx
