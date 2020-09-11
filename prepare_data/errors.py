import csv


def appchecker_parse():
    with open('appchecker.csv') as f:
        with open('errors.csv', 'w', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=['CWE-ID', 'description', 'tool_name'])
            writer.writeheader()

            for row in f:
                id = row.strip()[:]
                descri = f.readline()[:-1].strip()

                d = dict()
                d['CWE-ID'] = id
                d['description'] = descri
                d['tool_name'] = 'AppChecker'
                if d['CWE-ID'] != "":
                    writer.writerow(d)
                    print(d)


def clang_parse():
    with open('clang.txt') as f:
        with open('errors.csv', 'a', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=['CWE-ID', 'description', 'tool_name'])

            for row in f:
                row = row[1:]
                table = row.split('"')[:5]
                if table != []:
                    d = dict()
                    if 'nil' in table[4].strip():
                        d['CWE-ID'] = "0"
                    else:
                        d['CWE-ID'] = table[4].strip()
                    d['description'] = table[3].strip()
                    d['tool_name'] = 'clang-analyzer'
                    if d['CWE-ID'] != "":
                        writer.writerow(d)
                        print(d)


def clang_parse2():
    with open('clang_bugs') as f:
        with open('errors.csv', 'a', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=['CWE-ID', 'description', 'tool_name'])

            for row in f:
                row = row[1:]
                table = row.split(',')[:7]
                if table != []:
                    d = dict()
                    if 'nil' in table[2].strip():
                        d['CWE-ID'] = "0"
                    else:
                        d['CWE-ID'] = table[2].strip()
                    d['description'] = table[0].strip()[1:-1]
                    d['tool_name'] = 'clang-analyzer'
                    if d['CWE-ID'] != "":
                        writer.writerow(d)
                        print(d)
                        #print(d)


def infer_parse():
    with open('infer.txt') as f:
        with open('errors.csv', 'a', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=['CWE-ID', 'name', 'tool_name'])

            for row in f:
                table = row.strip().split('"')
                if table != []:
                    d = dict()
                    print(table)
                    if table[3].strip() == "":
                        d['CWE-ID'] = "0"
                    else:
                        d['CWE-ID'] = table[3].strip()
                    d['name'] = table[1].strip()
                    d['tool_name'] = 'Infer'
                    if d['CWE-ID'] != "":
                        writer.writerow(d)
                        print(d)
                        #print(d)

def pvs_parse():
    with open('pve.txt') as f:
        with open('errors.csv', 'a', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=['CWE-ID', 'name', 'tool_name'])

            for row in f:
                table = row.strip().split()[1:]
                print(table)
                if table != []:
                    d = dict()
                    print(table)
                    if table[-1].strip() == "":
                        d['CWE-ID'] = "0"
                    else:
                        d['CWE-ID'] = table[-1].strip()[4:]
                    name = ""
                    for x in table:
                        if not x.startswith("CWE-"):
                            name += x + " "
                    d['name'] = name.strip()
                    d['tool_name'] = 'PVS-Studio'
                    if d['CWE-ID'] != "":
                        writer.writerow(d)
                        print(d)
                        #print(d)


def main():
    #appchecker_parse()
    #clang_parse()
    #clang_parse2()
    #infer_parse()
    pvs_parse()


if __name__ == "__main__":
    main()
