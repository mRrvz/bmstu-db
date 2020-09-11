import csv
import random


names = []
with open('MOCK_DATA.csv', newline='') as csvfile:
    writer = csv.DictReader(csvfile)
    for x in writer:
        names.append(x['appname'])


def cut(string, i=1, j=-1):
    return string.split(':', 1)[i][1:j]


def generate_tools(names_):
    value = dict()

    name = random.choice(names)
    while name in names_:
        name = random.choice(names) + str(random.randint(1, 20))
    names_.append(name)

    value['name'] = name
    value['description'] = "No Description"
    value['homepage'] = "No Homepage"
    value['proprietary'] = random.choice(['N', 'Y'])
    value['languages'] = random.choice(['javascript', 'haskell', 'cpp', 'java', 'kotlin', 'objectivec', 'ocaml', 'bash', 'python', 'asm', 'csharp'])

    return value, names_


def parse(tool):
    values = {}
    strings = tool.split('\n')
    values['name'] = cut(strings[0], 0, j=len(strings[0]))
    values['homepage'] = cut(strings[1])[1:]
    values['proprietary'] = 'N'

    is_tags = False

    for value in strings:
        if 'description' in value:
            vai = cut(value)
            if vai.startswith('"'):
                values['description'] = vai[1:]
                print(values['description'])
            else:
                values['description'] = vai
            is_tags = False

        if 'proprietary' in value:
            values['proprietary'] = 'Y'
            is_tags = False

        if 'tags:' in value:
            is_tags = True
            values['languages'] = ''
            continue

        if is_tags and value != '' and value != ' ':
            try:
                values['languages'] += value.split('-')[1][1:] + ", "
            except IndexError:
                continue

    values['languages'] = values['languages'][:-2]
    return values



with open('tools.txt') as f:
    with open('tools.csv', 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=['name', 'homepage', 'description', 'languages', 'proprietary'])
        writer.writeheader()

        apps = f.read().split('- name:')

        names_ = []
        for tool in apps[1:]:
            val = parse(tool)
            names.append(val['name'])
            writer.writerow(val)

        for i in range(600):
            val, names_ = generate_tools(names)
            writer.writerow(val)

