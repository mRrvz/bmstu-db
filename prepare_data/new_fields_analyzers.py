import csv
from random import randint

def new_fields():
    with open('analyzers_exp.csv') as f:
        with open('analyzers_new.csv', 'w', newline='') as csvfile:
            reader = csv.DictReader(f, fieldnames=['name', 'homepage', 'description', 'languages', 'proprietary'])

            writer = csv.DictWriter(csvfile, fieldnames=['name', 'homepage', 'description', 'languages', 'proprietary', 'price', 'downloads'])
            writer.writeheader()

            for row in reader:
                print(row)
                writer.writerow({'name':row['name'], 'homepage': row['homepage'], 'description':row['description'], 'languages':row['languages'],
                                 'proprietary':row['proprietary'], 'price': randint(10, 10000000), 'downloads': randint(0, 100000000)})


new_fields()
with open('analyzers_new.csv', 'r+') as f:
    with open('flex.csv', 'w') as f1:
        for row in f:
            f1.write(row[:-2] + ',\n')
