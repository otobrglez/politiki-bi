SELECT
	{[Measures].[Value]} ON COLUMNS,
	{[Targets].children} ON ROWS
FROM
	[Measurements]
WHERE
	([Time].[2012])