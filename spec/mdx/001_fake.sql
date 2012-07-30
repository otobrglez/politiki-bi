SELECT
	{[Measures].[Unit Sales],
	[Measures].[Store Sales]} ON COLUMNS,
	{[Products].children} ON ROWS
FROM
	[Sales]
WHERE
	([Time].[2010].[Q1],
	[Customers].[USA].[CA])