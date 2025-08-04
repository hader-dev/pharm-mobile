import csv
import argparse
import uuid
from datetime import datetime

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Generate PostgreSQL-compatible product CSV from medicine data.")
parser.add_argument('--rows', type=int, default=500, help='Number of rows to generate')
parser.add_argument('--input', type=str, default='medicine.csv', help='Input medicine CSV path')
parser.add_argument('--output', type=str, default='products.csv', help='Output CSV path')
parser.add_argument('--company', type=str, default='0197a673-4fbb-7088-8b4c-f26e64033680', help='Fixed company_id UUID')
args = parser.parse_args()

# Output CSV headers
headers = [
    "id", "unit_price_ttc", "unit_price_ht", "tva_percentage",
    "thumbnail_image", "image", "created_at", "updated_at",
    "company_id", "dci", "registration_number", "distributorSku",
    "isPrivate", "margin", "stockQuantity", "minOrderQuantity",
    "maxOrderQuantity", "isPsychoactive", "requiresColdChain",
    "isActive", "isQuota", "isFeatured", "displayOrder"
]

# Constants
UNIT_PRICE_TTC = 25.00
UNIT_PRICE_HT = 22.94
TVA = 9.0
MARGIN = round(UNIT_PRICE_TTC - UNIT_PRICE_HT, 2)
QTY = 100
TIMESTAMP = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')

# Read input rows
with open(args.input, newline='', encoding='utf-8') as infile:
    reader = list(csv.DictReader(infile))
    if args.rows > len(reader):
        raise ValueError(f"Only {len(reader)} rows available in the input CSV.")

    rows = reader[:args.rows]

# Write output
with open(args.output, mode='w', newline='', encoding='utf-8') as outfile:
    writer = csv.writer(outfile)
    writer.writerow(headers)

    for med in rows:
        writer.writerow([
            str(uuid.uuid4()),                      # id (new UUID)
            UNIT_PRICE_TTC,
            UNIT_PRICE_HT,
            TVA,
            "", "",                                 # thumbnail_image, image
            TIMESTAMP, TIMESTAMP,
            args.company,
            med.get("dci", ""),
            med.get("registration_number", ""),
            f"SKU-{med.get('code', '')}",
            't',                                     # isPrivate
            MARGIN,
            QTY, QTY, QTY,                          # stockQuantity, minOrderQuantity, maxOrderQuantity
            't', 't', 't', 't', 't',                 # isPsychoactive, requiresColdChain, isActive, isQuota, isFeatured
            QTY                                      # displayOrder
        ])

print(f"✅ {args.rows} rows generated to {args.output} using input {args.input}")


# python generate_random_seed_for_mecidines_table.py --rows 12 --output "C:/Users/user/Documents/postgresql_csv/products.csv" --input "C:/Users/user/Documents/postgresql_csv/medicines.csv" --company 0197cb86-e566-75bf-ab4f-f5fbad016522
# python generate_random_seed_for_mecidines_table.py --rows 12 --output "C:/Users/user/Documents/postgresql_csv/products.csv" --input "C:/Users/user/Documents/postgresql_csv/medicines.csv" --company 0197a673-4fbb-7088-8b4c-f26e64033680
# python generate_random_seed_for_mecidines_table.py --rows 12 --output "C:/Users/user/Documents/postgresql_csv/products.csv" --input "C:/Users/user/Documents/postgresql_csv/medicines.csv" --company 0197993b-fc2d-70fd-931d-23f4911731fe
