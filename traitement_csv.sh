
while IFS="," read -r rec_column1 rec_column2 rec_column3 rec_column4
do
  echo "value column 1: $rec_column1"
  echo "value column 2: $rec_column2"
  echo "value column 3: $rec_column3"
  echo "value column 4: $rec_column4"
  echo ""
done < <(tail -n +2 test.csv)