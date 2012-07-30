
SELECT
	{[Parameters].children } ON COLUMNS,
	{[Targets].[politician].children } ON ROWS
FROM
	[Measurements]
WHERE
	([Time].[2012])