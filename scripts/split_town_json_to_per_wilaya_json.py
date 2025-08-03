import json
import os
from pathlib import Path
import argparse

def group_towns_by_wilaya(input_path: Path, output_dir: Path):
    with open(input_path, 'r', encoding='utf-8') as f:
        json_data = json.load(f)

    raw_list = json_data['data']
    towns = [dict(town) for town in raw_list]

    grouped = {}
    for town in towns:
        wilaya_id = town['wilayaId']
        grouped.setdefault(wilaya_id, []).append(town)

    output_dir.mkdir(parents=True, exist_ok=True)

    for wilaya_id, town_list in grouped.items():
        file_name = f"town_{wilaya_id}_en.json"
        output_path = output_dir / file_name

        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump({"data": town_list}, f, indent=2, ensure_ascii=False)

        print(f"✅ Created: {output_path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_path", help="Path to the source JSON file")
    parser.add_argument("output_dir", help="Directory to output split JSON files")

    args = parser.parse_args()

    group_towns_by_wilaya(Path(args.input_path), Path(args.output_dir))

## python split_town_json_to_per_wilaya_json.py C:/Projects/hader-pharm-mobile/assets/json/town_en.json C:/Projects/hader-pharm-mobile/assets/json/town
