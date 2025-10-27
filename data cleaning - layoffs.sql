use Layoff_db 
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql = @sql + 
'SELECT ''' + COLUMN_NAME + ''' AS ColumnName, 
       COUNT(*) AS TotalRows, 
       SUM(CASE WHEN [' + COLUMN_NAME + '] IS NULL THEN 1 ELSE 0 END) AS NullCount
FROM layoffs
UNION ALL
'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'layoffs' AND TABLE_SCHEMA = 'dbo';

SET @sql = LEFT(@sql, LEN(@sql) - 10);

EXEC sp_executesql @sql; 
select count(percentage_laid_off) from layoffs where percentage_laid_off = 'NULL' 

--1 Remove Duplicates
--2 Standardize data
--3 Remove null values

select * into layoff_staging from layoffs

--1 Remove Duplicates
select * from layoff_staging 
-- create CTE to number the order, if the order number is greater than 1 then remove that row
WITH duplicate_cte AS (
    SELECT *, 
           ROW_NUMBER() OVER(
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date
			   ORDER BY company
           ) AS row_num
    FROM layoff_staging
)
SELECT * 
FROM duplicate_cte 
WHERE row_num > 1;
-- table has no PK , so create new 
ALTER TABLE layoff_staging ADD ID INT IDENTITY(1,1);

WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date
               ORDER BY ID
           ) AS row_num
    FROM layoff_staging
)
DELETE FROM layoff_staging
WHERE ID IN (
    SELECT ID FROM duplicate_cte WHERE row_num > 1
);


--2 Standardizing data
select distinct(company) from layoff_staging
UPDATE layoff_staging set company = TRIM(company)


select distinct(industry) from layoff_staging
update layoff_staging set industry = 'Crypto' where industry like 'Crypto%'

select * from layoff_staging 

update layoff_staging set date = '2023-03-06' where date is null

update layoff_staging set date = cast(date as DATE)
alter table layoff_staging alter column date DATE

update layoff_staging set country = 'United States' where country = 'United States.'

update layoff_staging set country = TRIM(country)

update layoff_staging set industry = 'Travel' where company = 'Airbnb'
update layoff_staging set industry = 'Consumer' where company = 'Juul'
update layoff_staging set industry = 'Transportation' where company = 'Carvana'

--3 Remove missing values and columns
delete from layoff_staging where total_laid_off is null or funds_raised_millions is null
alter table layoff_staging drop column ID
delete from layoff_staging where percentage_laid_off = 'NULL'
alter table layoff_staging alter column percentage_laid_off float




