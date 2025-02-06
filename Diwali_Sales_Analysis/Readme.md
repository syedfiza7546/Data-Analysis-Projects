1. Process and Objective
Objective:
The project aims to analyze Diwali sales data to uncover key consumer trends, demographic insights, and purchasing behaviors.
Process:
Data Preparation → Load, clean, and preprocess the dataset.
Exploratory Data Analysis (EDA) → Identify patterns through visualizations.
Trend Analysis → Analyze spending habits based on demographics.
Key Business Insights → Provide recommendations for targeted marketing.

2. About the Dataset
Total Records: 11,251 rows, 15 columns.
Data Preprocessing Steps:
Removed unnecessary columns (Status, Unnamed1).
Dropped missing values (dropna()).
Converted the Amount column from float to int for consistency.
Renamed columns (Marital_Status → Shaadi).

3. Line of Thinking & Hypothesis
Hypothesis:
Gender-based Sales: Do men or women spend more during Diwali?
Age-wise Spending: Which age group contributes the most revenue?
State-wise Sales: Which states have the highest sales volume?
Occupation-based Trends: Do working professionals spend more than students?
Popular Product Categories: Which products generate the most revenue?
Approach:
Start with Demographics → Understand customer distribution.
Analyze Purchasing Power → Identify spending trends by category.
Compare Across Groups → Find variations in spending behavior.
Use Visuals for Insights → Bar charts, count plots, and violin plots.

4. Data Exploration & Key Findings
1️⃣ Gender-based Sales Trends
Approach:
Grouped sales data by Gender and calculated total Amount.
Sorted results in descending order.
Used sns.barplot() for visualization.
python
CopyEdit
sales_gen = df.groupby(['Gender'], as_index=False)['Amount'].sum().sort_values(by='Amount', ascending=False)
sns.barplot(x='Gender', y='Amount', data=sales_gen)

Insight:
Women contribute more to total sales compared to men.
Businesses should target female customers with personalized marketing campaigns.

2️⃣ Age-wise Spending Analysis
Approach:
Grouped sales data by Age Group.
Created a bar chart to visualize total spending per age group.
python
CopyEdit
sales_age = df.groupby(['Age Group'], as_index=False)['Amount'].sum().sort_values(by='Amount', ascending=False)
sns.barplot(x='Age Group', y='Amount', data=sales_age)

Insight:
The 26-35 age group has the highest spending.
Offers and discounts should focus on this demographic.

3️⃣ State-wise Sales Trends
Approach:
Grouped sales data by State to analyze total orders and revenue.
Displayed the top 10 states with the highest sales.
python
CopyEdit
sale_state = df.groupby(['State'], as_index=False)['Orders'].sum().sort_values(by='Orders', ascending=False).head(10)
sns.barplot(data=sale_state, x='State', y='Orders')

Insight:
The top-performing states are Uttar Pradesh (UP), Maharashtra, and Karnataka.
Marketing campaigns should be focused on these regions for higher engagement.

4️⃣ Occupation-based Spending Patterns
Approach:
Grouped sales data by Occupation and calculated total spending.
Used a bar chart to visualize different occupation-wise spending trends.
python
CopyEdit
sale_state = df.groupby(['Occupation'], as_index=False)['Amount'].sum().sort_values(by='Amount', ascending=False)
sns.barplot(data=sale_state, x='Occupation', y='Amount')

Insight:
Customers in IT, Healthcare, and Aviation industries spend the most.
Promotional efforts should target professionals in these sectors.


5️⃣ Product Category Trends
Approach:
Identified the top-selling product categories based on sales amount.
Used bar charts to visualize spending per category.
python
CopyEdit
sale_state = df.groupby(['Product_Category'], as_index=False)['Amount'].sum().sort_values(by='Amount', ascending=False).head(10)
sns.barplot(data=sale_state, x='Product_Category', y='Amount')

Insight:
The Food, Clothing, and Electronics categories generate the highest revenue.
Stocking more of these products during Diwali sales can increase profits.

6️⃣ Best-Selling Products
Approach:
Found top 10 best-selling products based on total revenue.
python
CopyEdit
sale_state = df.groupby(['Product_ID'], as_index=False)['Amount'].sum().sort_values(by='Amount', ascending=False).head(10)
sns.barplot(data=sale_state, x='Product_ID', y='Amount')

Insight:
Certain Product_IDs contribute significantly to total revenue.
Promotions should highlight these high-performing products.

5. Recommendations Based on Analysis
Based on the insights from the analysis, here are some actionable recommendations:
1️⃣ Target Female Consumers
Since women spend more than men, businesses should introduce exclusive deals and personalized offers for female shoppers.
2️⃣ Focus on Age Group 26-35
This demographic spends the most, so special discounts and bundled offers can boost sales.
3️⃣ State-Level Marketing Strategy
Uttar Pradesh, Maharashtra, and Karnataka drive most sales.
Localized advertising and regional discounts can further increase revenue.
4️⃣ Promote High-Spending Occupations
Since professionals in IT, Healthcare, and Aviation industries spend the most, targeted ads on LinkedIn and industry-specific platforms can be beneficial.
5️⃣ Optimize Product Inventory
Stock more Food, Clothing, and Electronics items as they generate the highest revenue.
Plan inventory based on historical sales data to maximize profits.
