## 📊 YipitData Case Study

The task was designed to simulate real-world responsibilities involving data cleaning, transformation, and analysis.

### 🔍 Objective

Analyze Netflix Top 10 weekly viewership data to identify trends and generate user-based insights using Excel/Google Sheets or Power BI. The exercise focused on:

- Handling nulls and incomplete data (especially for the week of May 22, 2022)
- Estimating viewership using runtime and hours viewed
- Identifying top-performing Non-English films by cumulative weeks in the top 10
- Understanding risks in estimation and reporting
- Visualizing insights using Power BI (with calculated columns, measures, and cards)

### 🛠️ Tools & Skills Used

- Power BI
- Excel / Google Sheets
- DAX for custom calculations (e.g., Estimated Users, Avg Rating by Category)
- Data Cleaning & Joins (IMDb Ratings & Runtime)
- Pivot tables & charts
- Interactive report features (dropdowns, category filters, dynamic cards)

### 🧠 Key Learnings

- Estimated viewership can be misleading without accounting for rewatch behavior, shared accounts, or missing data
- Importance of excluding corrupted/incomplete data points (e.g., outage week)
- Power BI’s model view and measures can power dynamic reporting and handle grouped/filtered aggregations effectively

### 🔢 Google Sheets / Excel Formulas

// Estimated Users (per row)
=IFERROR(IF([Runtime (min)]=0, "", [Weekly Hours Viewed]/([Runtime (min)]/60)), 0)

// Runtime (hrs)
=ROUND([Runtime (min)] / 60)

// Include Week Flag
=IF([Week]=DATE(2022,5,22), "No", "Yes")

// SUMIFS to get total Estimated Users (excluding nulls & outage week)
=SUMIFS([Estimated Users Range], [Include Week Range], "Yes", [Estimated Users Range], "<>")

### 🧮 Power BI DAX Measures

// Estimated Users
Estimated Users = 
DIVIDE(
    SUM('NFLX Top 10'[weekly_hours_viewed]),
    SUM('Runtime'[runtime]) / 60,
    0
)

// Filtered Estimated Users (excluding week of May 22 and nulls)
Filtered Estimated Users = 
CALCULATE(
    [Estimated Users],
    'NFLX Top 10'[Include_week] = "Yes",
    NOT(ISBLANK('NFLX Top 10'[weekly_hours_viewed]))
)

// Max Cumulative Weeks in Top 10
Max Weeks in Top 10 = 
MAX('NFLX Top 10'[cumulative_weeks_in_top_10])

// Avg IMDb Rating by Show Title
Avg Rating = 
AVERAGE('IMDb Ratings'[rating])

// Avg Rating by Category (with title match)
Avg Rating by Category = 
CALCULATE(
    AVERAGE('IMDb Ratings'[rating]),
    TREATAS(
        VALUES('NFLX Top 10'[show_title]),
        'IMDb Ratings'[title]
    ),
    NOT(ISBLANK('IMDb Ratings'[rating]))
)

// Dynamic Card Title for Top Show (by category)
Top Non-English Film = 
CALCULATE(
    SELECTEDVALUE('NFLX Top 10'[show_title]),
    FILTER(
        'NFLX Top 10',
        'NFLX Top 10'[cumulative_weeks_in_top_10] = 
        CALCULATE(MAX('NFLX Top 10'[cumulative_weeks_in_top_10]))
            && 'NFLX Top 10'[category] = "Films (Non-English)"
    )
)
