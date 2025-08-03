import pandas as pd
import json
import os
import argparse

def extract_unique_column_to_json(
    excel_path: str,
    sheet_name: str,
    column_index: int,
    output_dir: str,
    output_filename: str
):
    df = pd.read_excel(excel_path, sheet_name=sheet_name)
    column = df.iloc[:, column_index].dropna()
    unique_values = sorted(set(str(v).strip() for v in column if str(v).strip()))
    result = {"data": unique_values}
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, output_filename)
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2, ensure_ascii=False)
    print(f"✅ {len(unique_values)} unique values written to {output_path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("excel_path", help="Path to the Excel file")
    parser.add_argument("sheet_name", help="Name of the sheet to read")
    parser.add_argument("column_index", type=int, help="Index of the column (0-based)")
    parser.add_argument("output_dir", help="Directory to save the JSON file")
    parser.add_argument("output_filename", help="Name of the output JSON file")

    args = parser.parse_args()

    extract_unique_column_to_json(
        args.excel_path,
        args.sheet_name,
        args.column_index,
        args.output_dir,
        args.output_filename
    )



## python extract_unique_values_from_excel.py "C:/Users/user/Downloads/stock bkmh 17-05-2025.xlsx" Sheet1 2 "C:/Projects/hader-pharm-mobile/assets/json/filters" "dci.json"
## python extract_unique_values_from_excel.py "C:/Users/user/Downloads/stock bkmh 17-05-2025.xlsx" Sheet1 1 "C:/Projects/hader-pharm-mobile/assets/json/filters" "code.json"
