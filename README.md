# 🧹 Data Cleaning in SQL – Layoffs Dataset

## 📘 Overview
This project focuses on **data cleaning using SQL**, with the goal of improving data quality and ensuring consistency before performing analysis.  
The dataset used in this project contains information about company layoffs, including company name, location, industry, date, and other relevant details.

---

## 🎯 Objectives
- Detect and handle **missing values (NULL)** in the dataset.  
- Identify and remove **duplicate records**.  
- Standardize **text data** (such as trimming spaces and unifying case formats).  
- Validate and correct **inconsistent data types or formats**.  
- Prepare the cleaned dataset for use in data visualization or analytical tools.

---

## 🗂️ Dataset Information
**Table name:** `layoffs`

| Column Name | Description |
|--------------|-------------|
| company      | Name of the company |
| location     | Company location |
| industry     | Industry or sector |
| total_laid_off | Number of employees laid off |
| percentage_laid_off | Layoff percentage |
| date         | Date of the layoff event |
| country      | Country where the layoff occurred |
| stage        | Company stage (e.g., Startup, Series A, etc.) |
| funds_raised_millions | Total funding in millions |

---

## ⚙️ Data Cleaning Process

### 1. Checking for Missing Values
A dynamic SQL query was used to automatically check each column in the `layoffs` table for NULL values.  
This helped identify which fields had incomplete data and the number of affected rows.

---

### 2. Handling Missing Data
After identifying the columns with missing values, appropriate actions were taken based on the data type and business logic:
- **Text fields** (e.g., industry, country) were filled with `'Unknown'` or the most frequent value.
- **Numeric fields** (e.g., total_laid_off, percentage_laid_off) were replaced with `0` or calculated averages.
- **Date fields** were imputed or marked as placeholder dates where necessary.

These steps ensured that no critical information was left blank and that the dataset remained consistent for analysis.

---

### 3. Removing Duplicates
Duplicate rows were identified using the `ROW_NUMBER()` function and removed to maintain data integrity.

---

### 4. Standardizing Data Formats
String fields were standardized for uniformity:
- Leading and trailing spaces were removed.  
- Text values were converted to consistent casing (e.g., all uppercase for industry names).  
- Dates and numeric formats were validated and corrected.

---

## 📊 Results
After cleaning:
- All missing values were properly handled.  
- Duplicate records were removed.  
- Data formats were standardized and validated.  
- The dataset is now ready for visualization and analysis (e.g., in Power BI or Python).

---

## 🧠 Conclusion
Data cleaning plays a vital role in ensuring the accuracy and reliability of any analytical project.  
By leveraging SQL, missing data, duplicates, and inconsistencies were efficiently detected and corrected.  
As a result, the cleaned `layoffs` dataset is ready for deeper insight generation and decision-making.

---


