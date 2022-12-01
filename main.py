# Load pandas
import pandas as pd

# Read CSV file into DataFrame df
df = pd.read_csv('US_Accidents_Dec21_updated.csv', index_col=0)

# Show dataframe
print(df)