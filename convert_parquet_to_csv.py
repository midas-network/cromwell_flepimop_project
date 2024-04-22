import sys
import pyarrow.parquet as pq
from pyarrow import csv

table2 = pq.read_table(sys.argv[1])
csv.write_csv(table2, sys.argv[2])
