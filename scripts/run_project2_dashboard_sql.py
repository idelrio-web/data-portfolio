import duckdb
from pathlib import Path

Path("outputs").mkdir(exist_ok=True)

sql_path = Path("sql/project2_dashboard_tables.sql")
sql_text = sql_path.read_text(encoding="utf-8")

con = duckdb.connect()

con.execute(sql_text)

print("✅ Project 2 outputs created:")
for p in sorted(Path("outputs").glob("ops_*.csv")):
    print(" -", p.as_posix())
