import csv, sys

def ascii_only (input):
    return ''.join(filter(str.isascii,input))

with open(sys.argv[len(sys.argv)-1], 'a+') as outfile:
    for j in range(1,len(sys.argv)-1):
        with open(sys.argv[j], 'r') as csvfile:
            reader = csv.DictReader(csvfile)
            list_of_gid = []

            for row in reader:
                list_of_gid.append(ascii_only(row['gid']))

            outfile.write('%- Carreira '+ sys.argv[j] +' !\n\n')

            for i in range(0,len(list_of_gid)-1):
                outfile.write('adjacencia(\''+ str(list_of_gid[i]) +'\',\''+ str(list_of_gid[i+1]) +'\').\n')

            outfile.write('\n\n\n')
