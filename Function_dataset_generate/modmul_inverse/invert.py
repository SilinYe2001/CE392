from util import invert
import random
import argparse
"""
The multiplicitive inverse of a in the integers modulo b.

:return int: x, where a * x == 1 mod b
"""

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='set number of data needed')
    parser.add_argument('--keysize', type=int, default=2048, help='Key size in bits. Default is 2048.')
    parser.add_argument('--numkeys', type=int, default=1, help='Number of keypairs to generate. Default is 1.')
    args = parser.parse_args()
    input_file=f'input_data.txt'
    output_file=f"invert.txt"
    open(input_file, 'w').close()
    open(output_file, 'w').close()
    for i in range(args.numkeys):
        suffix = f"{i}" if args.numkeys > 1 else ""   
        a=random.getrandbits(args.keysize)
        b=random.getrandbits(args.keysize)
        c=random.getrandbits(args.keysize)
        result=invert(a,b)
        with open(input_file, 'a') as file:
            file.write(f'{a}\n')
            file.write(f'{b}\n')
        with open(output_file, 'a') as file:
            file.write(f'{result}\n')
        print(f"Set {i+1} finish")