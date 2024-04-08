import random
import argparse

def l_function(x, p):
    """Computes the L function as defined in Paillier's paper. That is: L(x,p) = (x-1)/p"""
    return (x - 1) // p

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='set number of data needed')
    parser.add_argument('--keysize', type=int, default=2048, help='Key size in bits. Default is 2048.')
    parser.add_argument('--numkeys', type=int, default=1, help='Number of keypairs to generate. Default is 1.')
    args = parser.parse_args()
    input_file=f'input_data.txt'
    output_file=f"l_function.txt"
    open(input_file, 'w').close()
    open(output_file, 'w').close()
    for i in range(args.numkeys):
        suffix = f"{i}" if args.numkeys > 1 else ""   
        a=random.getrandbits(args.keysize)
        b=random.getrandbits(args.keysize)
        result=l_function(a,b)
        with open(input_file, 'a') as file:
            file.write(f'{a}\n')
            file.write(f'{b}\n')
        with open(output_file, 'a') as file:
            file.write(f'{result}\n')
        print(f"Set {i+1} finish")