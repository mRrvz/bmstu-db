import csv
from random import randint, uniform

from random import randrange
from datetime import timedelta, datetime

def random_date(start, end):
    """
    This function will return a random datetime between two datetime
    objects.
    """
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = randrange(int_delta)
    return start + timedelta(seconds=random_second)


def new_fields():
    with open('errors_copy.csv') as f:
        with open('errors_new.csv', 'w', newline='') as csvfile:
            reader = csv.DictReader(f, fieldnames=['CWE-ID', 'description', 'tool_name'])

            writer = csv.DictWriter(csvfile, fieldnames=['CWE-ID', 'description', 'tool_name', 'percentage', 'danger_level',
                                                         'price', 'created'])
            writer.writeheader()
            d1 = datetime.strptime('1/1/2000', '%m/%d/%Y')
            d2 = datetime.strptime('1/1/2020', '%m/%d/%Y')

            for row in reader:
                print(row)
                writer.writerow({'CWE-ID': row['CWE-ID'], 'description': row['description'], 'tool_name': row['tool_name'],
                                 'percentage': uniform(0, 100), 'danger_level': randint(1, 10), 'price': randint(10, 100000),
                                 'created': str(random_date(d1, d2))[:-9]})


new_fields()
with open('errors_new.csv', 'r+') as f:
    with open('flex.csv', 'w') as f1:
        for row in f:
            f1.write(row[:-2] + ',\n')
