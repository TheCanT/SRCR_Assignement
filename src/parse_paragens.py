import csv, sys

sep = '\''

def ascii_only (input):
    return ''.join(filter(str.isascii,input))

with open(sys.argv[1], 'r') as csvfile, open(sys.argv[2], 'w') as outfile:
    reader = csv.DictReader(csvfile)
    list_of_gid = []
    
    for row in reader:
        l = 'paragem(\''
        l += ascii_only(row['gid'])+sep+', '
        l += (ascii_only(row['latitude']) if len(row['latitude']) > 0 else '_') +', '
        l += (ascii_only(row['longitude']) if len(row['longitude']) > 0 else '_') +', '+sep
        l += ascii_only(row['Estado de Conservacao'])+sep+', '+sep
        l += ascii_only(row['Tipo de Abrigo'])+sep+', '+sep
        l += ascii_only(row['Abrigo com Publicidade?'])+sep+', '+sep
        l += ascii_only(row['Operadora'])+sep+', '
        l += ascii_only(str(row['Carreira'].split(',')))+', '+sep
        l += ascii_only(row['Codigo de Rua'])+sep+', '+sep
        l += ascii_only(row['Nome da Rua'])+sep+', '+sep
        l += ascii_only(row['Freguesia'])+sep+').\n'
        
        outfile.write(l)
        
        list_of_gid.append(row['gid'])
    
    outfile.write('gids('+str(list_of_gid)+').\n')
