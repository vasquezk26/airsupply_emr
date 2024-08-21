# airsupply_OneLake_Orchestrator
This is the orchestrator lambda for creating the transient EMR cluster
Each Step for a DQ consists of the following:
GetExtract.py:   
- Extract the csv files from s3
- store into list
ExtractionDF.py:
- Generating an extraction dataset for each csv in the list for the given date.
SchemaCheck.py:
- For each dataset pull a row count and store in text file with proper name.
