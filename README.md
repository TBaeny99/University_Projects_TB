# University Projects – Teddy Fabrizio Baeny Vargas
**Master of Data Analytics | University of Niagara Falls Canada**

This repository contains a selection of academic projects completed during my Master of Data Analytics program. Each project reflects hands-on work across database design, data visualization, predictive analytics, prescriptive analytics, machine learning, and Python programming.

---

## Projects

### 1. E-Commerce Database – Video Games & Electronics (MySQL)

A fully normalized relational database simulating an e-commerce platform for video games and electronics. Designed and implemented in MySQL, the project covers schema design (DDL), data population, transactional data management (DML), and a full suite of analytical queries (DQL) including views, CTEs, window functions, and joins. It also includes ML-ready data extraction queries for use cases such as customer segmentation, sales forecasting, churn prediction, and product recommendations. The schema follows 1NF, 2NF, and 3NF, with constraints, indexes, and foreign keys enforcing data integrity throughout.

**My contribution:** This was an individual project completed entirely independently. I designed the full normalized schema, wrote all DDL including constraints and indexes, populated the database with realistic sample data, developed the full suite of analytical queries including views, window functions, and CTEs, and built the ML-ready data extraction pipelines.

**Files:** `DDL_AND_POPULATION_ecommerce.sql`, `DML_ecommerce_dynamic_data_management.sql`, `DQL_Query_ecommerce.sql`, `DQL_Query_Track_ecommerce.sql`, `DQL_VIEW_ecommerce.sql`, `DQL_WINDOW_FUNCTION_ecommerce.sql`, `DQL_CTE_ecommerce.sql`, `machinelearning.sql`, `ecommerceERD.pdf`, `Database_Design_Report.pdf`

**Tools:** MySQL

---

### 2. Marketing Analytics – Customer Segmentation (K-Means, Excel)

A cluster segmentation analysis performed on a 100-customer commerce dataset containing demographic, geographic, and behavioral variables. Using K-Means clustering, customers were grouped into four distinct segments based on age, income, purchasing behavior, and campaign engagement. Each cluster was profiled and mapped to targeted marketing strategies across product, price, place, and promotion.

**My contribution:** I handled the full segmentation pipeline — encoding the categorical variables, applying Z-score standardization across all features, computing Euclidean distances to each centroid, and assigning all 100 customers to their clusters in Excel.

**Files:** `Mkt_Final_Assignment.xlsx`, `PresentationMKT.pptx`

**Tools:** Excel

---

### 3. Data Warehouse & Visualization – Bike Sharing & Housing Prices (Power BI)

A two-part dashboard assignment built in Power BI covering a bike sharing dataset and a real estate housing prices dataset. The project applied exploratory data analysis, statistical summaries, forecasting, and key influencer analysis to extract actionable business insights from both datasets.

**My contribution:** I built the four Power BI report pages covering the housing dataset end-to-end. I handled missing value imputation using a DAX measure to filter NA values and fill them with the mean sale price, then built all the visuals: distribution analysis, correlation heatmap, outlier detection boxplots, a real estate price forecast, a decomposition tree breaking down average sale price by property attributes, and a key influencers analysis identifying lot area, year built, and bedroom count as the main price drivers.

**Files:** `Assignment4G7__.pbix`, `Housing_Prices_Cleaned.csv`, `Assignment4_G7__.pdf`

**Tools:** Power BI, DAX, Python (embedded visuals)

---

### 4. Predictive Analytics – Alzheimer's Disease Diagnosis (Logistic Regression, Python)

A predictive analytics project applying logistic regression to classify the likelihood of an Alzheimer's diagnosis across 2,149 patients. The dataset, sourced from Kaggle, contains 32 variables spanning six categories: demographic details, lifestyle factors, medical history, clinical measurements, cognitive and functional assessments, and Alzheimer's symptoms. The project covers the full analytical pipeline — data preprocessing, exploratory analysis, correlation analysis, model development, evaluation, and interpretation.

**My contribution:** I was responsible for the full model development. I built the correlation matrix to identify key predictors, implemented the multicollinearity check to ensure logistic regression assumptions were met, and developed two logistic regression models using both scikit-learn and statsmodels. Model 1 used all 32 variables and achieved 83% accuracy. After identifying that only the 5 cognitive and functional assessment variables (MMSE, Functional Assessment, Memory Complaints, Behavioral Problems, and ADL) were statistically significant, I built Model 2 using only those variables — achieving the same 83% accuracy with a cleaner, fully significant model. I also interpreted the coefficients and evaluation metrics (accuracy, precision, recall, F1, confusion matrix) that supported the final conclusions. The visualizations, variable interpretations, and written documentation were handled by my teammates.

**Files:** `predictivealzheimer.py`, `Alzheimer_Dataset_Phyton.ipynb`, `alzheimer.xlsx`, `Variables_Interpretations.xlsx`, `PredictiveAssigment2.pdf`

**Tools:** Python (pandas, scikit-learn, statsmodels, seaborn, matplotlib), Power BI, Flourish

---

### 5. Prescriptive Analytics – Cooling Fan Replacement Policy (Monte Carlo Simulation, Python)

A prescriptive analytics assignment evaluating two maintenance policies for a data center server rack cooled by three identical fans. The business challenge was to determine whether replacing only the failed fan (current policy) or replacing all three fans whenever one fails (proposed policy) is more cost-effective. Both policies were simulated over 45 failure cycles using Monte Carlo methods, accounting for fan costs ($32/unit), server downtime costs ($10/min), and technician labor costs ($30/hr), with randomized fan lifetimes and technician arrival times drawn from probability distributions. The simulation concluded that the current policy averages ~$509 per failure cycle versus ~$803 for the proposed policy — a saving of approximately $294 per failure.

**My contribution:** I built the full Monte Carlo simulation in Python. This included setting up the shared probability distributions for fan lifetimes and technician arrival times, implementing the current policy simulation with per-fan lifetime tracking across cycles (so surviving fans correctly carry their remaining life into the next cycle), and implementing the proposed policy where all three fans are replaced on every failure. I also produced the comparative visualizations — cost per cycle and cumulative cost across 45 cycles — and exported the full results to a structured Excel file with separate sheets for each policy and a summary comparison. The Excel-based manual simulation and written report were handled by my teammates.

**Files:** `PrescriptiveG7Assignment2_unif.ipynb`, `PrescG7Assignment2.xlsx`, `Prescriptive_P2.pdf`

**Tools:** Python (pandas, numpy, matplotlib), Excel

---

### 6. Advanced Data Visualization – Superstore Sales Analysis (Tableau)

A multi-dashboard Tableau workbook built on the Superstore dataset, blended with supplementary supplier and returns data to enable cross-source analysis. The project covers three analytical areas — customer behavior, sales and profitability, and operational/logistics performance — across 25,000+ orders and $12.6M in total sales. Advanced Tableau features were applied throughout, including dataset blending, calculated fields, Level of Detail (LOD) expressions, trend lines, forecasting, and interactive filters, producing dashboards designed to answer specific business questions rather than simply display data.

**My contribution:** I built the Sales and Profitability Overview dashboard. It includes a KPI header row surfacing total orders, total sales, total profit, profit margin, quantity, return rate, shipping cost, and average sales per customer. Below that I built a geographic profit map by country, a performance by category and segment bar chart showing how Furniture, Office Supplies, and Technology compare across Consumer, Corporate, and Home Office segments, a monthly profit trend with a trend line, and a monthly sales forecast. Together these visuals give decision-makers a full executive-level view of business performance and forward-looking projections in a single dashboard.

**Files:** `Assig_3_G5.twbx`, `DataVisualization_A3.pdf`

**Tools:** Tableau

---

### 7. Python for Data Analytics – LAPD Crime Case Resolution (Classification, Python)

A comprehensive case study analyzing 203,089 LAPD crime incidents to predict whether a criminal case will be solved. The dataset presents a significant class imbalance — only 20.9% of cases are solved — which was addressed through class weighting in both models. The project covers the full data science pipeline: data cleaning, exploratory analysis, feature engineering, classification model development, evaluation, and interpretation.

**My contribution:** This was an individual assignment completed entirely independently. I cleaned and merged the three datasets, handled the class imbalance, and engineered five new features: hour of crime, weekend flag, weapon usage flag, age group bins (with a dedicated Non-Person category for property crimes where age = 0), and a non-overlapping crime category classification built from the lookup table. Both models were built inside sklearn Pipelines to prevent data leakage, with the preprocessor fitted exclusively on training data. The Random Forest was tuned with GridSearchCV optimizing F1-score. Key findings showed that crime category (Property), geographic coordinates, and weapon usage were the strongest predictors per the feature importance analysis, while Logistic Regression outperformed Random Forest on the primary objective with an F1-score of 0.56, recall of 0.78, and AUC-ROC of 0.80.

**Files:** `TeddyBaenyAssignment4.ipynb`, `Assignment_4_Insights_Report_Teddy_Baeny.pdf`, `crime_dataset.csv`, `crime_types.csv`, `weapon_types.csv`

**Tools:** Python (pandas, scikit-learn, seaborn, matplotlib)

---

### 8. Machine Learning – Wheat Variety Classification (ANN, Python/TensorFlow)

A multiclass classification project applying a feed-forward artificial neural network to the UCI Seeds dataset, which contains 210 samples across three balanced wheat variety classes (Kama, Rosa, Canadian) with seven numerical morphological features. The project covers the full ML pipeline: exploratory data analysis, preprocessing, ANN design and training, hyperparameter comparison, and final evaluation.

**My contribution:** This was an individual assignment completed entirely independently. I built a two-hidden-layer MLP (64 → 32 units, ReLU, Dropout, softmax) using TensorFlow/Keras, trained with Adam (lr=0.001) and EarlyStopping over 100 epochs. A reusable `create_model()` function was used to run a controlled dropout comparison between light regularization (0.2) and strong regularization (0.5), with the 0.2 model outperforming on all metrics — 88.10% test accuracy versus 85.71%. Rosa and Canadian were classified with no errors; Kama was the only class with misclassifications, consistent with the EDA finding that its feature distributions overlap with the other two classes. The scaler was correctly fitted on training data only before transforming both sets, preventing leakage.

**Files:** `TeddyBaenyFinalProjectML.ipynb`, `TeddyBaeny_ML_Final_Project_Report.docx`

**Tools:** Python (TensorFlow/Keras, scikit-learn, pandas, seaborn, matplotlib)

---

## Skills Demonstrated

| Area | Tools & Techniques |
|---|---|
| Database Design | MySQL, DDL/DML/DQL, normalization, ERD, CTEs, window functions |
| Data Engineering | Schema design, data integrity, ML-ready pipelines |
| Business Intelligence | Power BI, Tableau, DAX, LOD expressions, forecasting |
| Predictive Analytics | Logistic Regression, ANN, Random Forest, GridSearchCV |
| Prescriptive Analytics | Monte Carlo Simulation, cost-benefit analysis |
| Machine Learning | TensorFlow/Keras, scikit-learn Pipelines, hyperparameter tuning |
| Programming | Python, SQL |
| Visualization | Matplotlib, Seaborn, Power BI, Tableau, Flourish |
