from util import mulmod
import random
import argparse
"""
Uses GMP, if available, to do a * b mod c, where a, b, c
are integers.

:return int: (a * b) % c
"""

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='set number of data needed')
    parser.add_argument('--keysize', type=int, default=2048, help='Key size in bits. Default is 2048.')
    parser.add_argument('--numkeys', type=int, default=1, help='Number of keypairs to generate. Default is 1.')
    args = parser.parse_args()
    input_file=f'input_data.txt'
    output_file=f"mulmod.txt"
    open(input_file, 'w').close()
    open(output_file, 'w').close()
    for i in range(args.numkeys):
        suffix = f"{i}" if args.numkeys > 1 else ""   
        a=random.getrandbits(args.keysize)
        b=random.getrandbits(args.keysize)
        c=random.getrandbits(args.keysize)
        result=mulmod(a,b,c)
        with open(input_file, 'a') as file:
            file.write(f'{a}\n')
            file.write(f'{b}\n')
            file.write(f'{c}\n')
        with open(output_file, 'a') as file:
            file.write(f'{result}\n')
        print(f"Set {i+1} finish")