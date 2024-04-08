## pq_file:
equal length prime numbers
p0 
q0 
p1
q1

## public_key:
g=n-1
n=p*q

## private key:
lambda=(p-1)*(q-1)
u=1/lambda mod n  (modular multiplicative inverse)

## mr_file
m: random integer from 0<=m<n
r: random integer gcd(r,n)=1

## cypher_file
c=g^m * r^n mod n^2

## plaintext_file

plaintext==m, decrypted from cipher