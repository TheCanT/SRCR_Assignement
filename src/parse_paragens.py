import csv, sys

with open(sys.argv[1], 'r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    next(spamreader)
    for row in spamreader:
        l = 'paragem(\''+row[0]+'\', '
        l += row[1]+', '+row[2]+', \''+row[3]+'\', \''
        l += row[4]+'\', \''+row[5]+'\', \''+row[6]+'\', '
        l += str(row[7].split(','))+', \''
        l += row[8]+'\', \''+row[9]+'\', \''+row[10]+'\').'
        print (l)
