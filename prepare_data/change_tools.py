with open('tools.csv', 'r', newline='') as f1:
    with open('new_tools1.csv', 'w') as f2:
        for row in f1:
            f2.write(row[:-2] + "," + "\n")

exit(1)

with open('tools.csv', 'r', newline='') as f1:
    with open('new_tools.csv', 'w') as f2:
        for row in f1:
            spl = row.split(',')
            spl[-1] = spl[-1][:-2]
            if spl[-1] == 'false':
                spl[-1] = 'N'
            else:
                spl[-1] = 'Y'
            f2.write(','.join(spl)+'\n')

