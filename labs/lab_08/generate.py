import argparse
import random
import string
import json
from time import sleep
from datetime import datetime
from functools import reduce

parser = argparse.ArgumentParser()
parser.add_argument("--cwe_id", type=int)
parser.add_argument("--file_id", type=int)
args = parser.parse_args()

allowed_status = (
    "Stable",
    "Draft",
    "Incomplete",
)

allowed_abstraction = (
    "Base",
    "Class",
    "Variant",
    "Pillar",
    "Compound",
)

def random_string(size):
    return reduce(lambda acc, _: acc + random.choice(string.ascii_lowercase), range(size), "").capitalize()


def generate_cwe(cwe_id):
    data = {
        "cwe_id": cwe_id,
        "name": random_string(random.randint(10, 256)),
        "weakness_abstraction": random_string(random.randint(15, 512)),
        "status": random.choice(allowed_status),
        "description": random.choice(allowed_abstraction),
    }

    return json.dumps(data)


def main():
    file_id = args.file_id
    current_cwe_id = args.cwe_id
    table_name = "cwe"

    while True:
        current_time = datetime.now().strftime("%Y-%m-%d_%H:%M:%S")
        raw = generate_cwe(current_cwe_id)

        with open(f"{file_id:02d}_{table_name}_{current_time}.json", "w") as f:
            f.write(raw)

        current_cwe_id += 1
        file_id += 1

        sleep(15)


if __name__ == "__main__":
    main()