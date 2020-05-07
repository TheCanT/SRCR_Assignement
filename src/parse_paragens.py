import csv, sys

with open(sys.argv[1], 'r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    for row in spamreader:
        l = 'paragem(\''
        l += row[0]+'\', '
        l += row[1]+', '
        l += row[2]+', \''
        l += row[3]+'\', \''
        l += row[4]+'\', \''
        l += row[5]+'\', \''
        l += row[6]+'\', '
        l += str(row[7].split(','))+', \''
        l += row[8]+'\', \''
        l += row[9]+'\', \''
        l += row[10]+'\').'
        print (l)
