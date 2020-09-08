import csv

pp = ['Missing Documentation for Design', 'Base', 'Incomplete', 'The product does not have documentation that represents how it is designed.']
def upgrade(values):
    with open('dataset.csv', 'a', newline='') as csvfile:
        spamreader = csv.writer(csvfile, delimiter=',', quotechar='|')

        listof= [x for x in range(1, 1300)]
        for x in listof:
            if x not in values:
                spamreader.writerow([str(x)] + pp)


values = []
with open('dataset.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')

    for i, row in enumerate(spamreader):
        if i == 0:
            continue
        if int(row[0]) not in values:
            values.append(int(row[0]))

upgrade(values)
