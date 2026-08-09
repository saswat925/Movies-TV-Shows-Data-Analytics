# 🎬 OTT Movies & TV Shows Analytics

An end-to-end **Data Analytics & Business Intelligence project** analyzing **16,000 Movies** and **15,991 TV Shows** released between 2010 and 2025.

The project combines **SQL Server, Python, Pandas, Matplotlib, Seaborn, and Power BI** to build a complete analytics workflow—from raw CSV ingestion and data quality validation to EDA, KPI analysis, interactive dashboards, and business recommendations.

---

## 📌 Project Objective

The objective of this project is to understand:

- Content volume and release patterns
- Audience ratings and engagement
- Movie budget and revenue performance
- Popularity of individual titles
- Leading languages, genres, and countries
- Relationship between movie investment and revenue
- Differences between Movie and TV Show performance indicators
- Business factors that can support content and portfolio decisions

---

## 🏗️ End-to-End Architecture

```text
Raw CSV Files
     │
     ▼
SQL Server — OTT_DB
     │
     ├── Staging Tables
     │     ├── stg_movies
     │     └── stg_tvshows
     │
     ▼
Data Profiling & Cleaning
     │
     ├── Duplicate validation
     ├── NULL validation
     ├── Text/space cleaning
     ├── Numeric validation
     ├── Date validation
     └── Business-rule validation
     │
     ▼
Final Tables
     ├── final_movies
     └── final_tvshows
     │
     ├───────────────┐
     ▼               ▼
Python EDA       Power BI
     │               │
     ▼               ▼
Statistical &     Interactive
Correlation       Dashboards
Analysis
     │
     └──────► Business Insights
```

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| Database | Microsoft SQL Server |
| Data Ingestion | BULK INSERT |
| Data Cleaning | SQL |
| Data Validation | SQL |
| Data Analysis | Python |
| Data Manipulation | Pandas, NumPy |
| Visualization | Matplotlib, Seaborn |
| BI & Dashboard | Power BI |
| Database Connection | SQLAlchemy, PyODBC |
| Documentation | GitHub README |

---

# 🗄️ 1. SQL Server — Data Engineering & Cleaning

## Database

```sql
CREATE DATABASE OTT_DB;
```

The raw datasets were loaded into separate staging tables:

```text
stg_movies
stg_tvshows
```

Both staging datasets initially contained **16,000 records**.

### Data Quality Checks

The project performs:

- Record-count validation
- Duplicate detection
- NULL-value profiling
- Leading/trailing-space validation
- Double-space detection
- Blank-string validation
- Special-character/encoding checks
- Rating-range validation
- Popularity validation
- Vote-count validation
- Date validation
- Numeric data-type validation
- String-length validation
- Decimal-precision validation

### Cleaning Highlights

**Movies**
- No duplicate `show_id` values were found.
- 466 missing country values were replaced with `Unknown`.
- 107 missing genre values were replaced with `Unknown`.
- 132 missing descriptions were replaced with `No Description Available`.
- Double spaces were identified and cleaned across text fields.

**TV Shows**
- 9 duplicate records were identified and removed using `ROW_NUMBER()`.
- Missing country, genre, and description values were standardized.
- 10,960 missing director values and 1,156 missing cast values were retained as NULL because they represent unavailable source information rather than invalid values.
- Double spaces were identified and cleaned.
- Rating, popularity, vote-count, and vote-average validation checks passed.

---

# 🐍 2. Python — EDA

Clean SQL Server tables were connected to Python using:

```text
SQL Server
   ↓
SQLAlchemy + PyODBC
   ↓
Pandas DataFrames
```

The analysis covered:

- Dataset profiling
- Data types
- Statistical summaries
- Unique values
- KPI calculation
- Language analysis
- Genre analysis
- Country analysis
- Rating analysis
- Popularity analysis
- Release-year analysis
- Budget analysis
- Revenue analysis
- Budget vs Revenue analysis
- Correlation analysis

---

# 📊 3. Power BI — Interactive Dashboards

Two separate dashboards were created to avoid mixing Movie and TV Show business logic.

## 🎬 Movies Dashboard

### KPIs

- Total Movies: **16,000**
- Total Revenue: **391B**
- Total Budget: **140B**
- Average Popularity: **20.38**
- Average Rating: **5.96**
- Average Vote Count: **719**

### Key Visuals

- Top Revenue Movies
- Top Budget Movies
- Top Popularity Movies
- Top Rated Movies
- Top Languages
- Release-Year Analysis
- Country Analysis
- Budget vs Revenue
- Rating Distribution
- Popularity Distribution

---

## 📺 TV Shows Dashboard

### KPIs

- Total TV Shows: **15,991**
- Total Countries: **565**
- Average Rating: **5.42**
- Average Vote Count: **107**

### Key Visuals

- TV Show Release-Year Analysis
- Top Popular TV Shows
- Highest Vote-Count Shows
- Top Languages
- Top Genres
- Top Countries
- Rating Distribution
- Popularity Analysis

---

# 🔎 Key Business Insights

## 🎬 Movies

### 1. Revenue is strongly linked to investment

The Python correlation analysis found:

```text
Budget ↔ Revenue = 0.75
```

This is a strong positive relationship. Higher-budget movies generally tend to generate higher revenue.

However, this should **not** be interpreted as a guarantee of profitability. Revenue is not the same as profit, and the dataset does not provide complete cost information such as marketing or distribution expenses.

### 2. Audience engagement is a major commercial signal

```text
Vote Count ↔ Revenue = 0.75
```

Movies receiving more audience votes tend to generate higher revenue.

This makes audience engagement a valuable complementary indicator when evaluating commercial performance.

### 3. Budget also connects with audience engagement

```text
Budget ↔ Vote Count = 0.67
```

Higher-budget productions generally attract greater audience attention, although the relationship is weaker than Budget–Revenue and does not imply causation.

### 4. Blockbusters dominate revenue

**Avengers: Endgame** leads the revenue ranking at approximately **2.8B**, followed by **Avatar: The Way of Water** at approximately **2.3B**.

The revenue leaders are heavily represented by major franchise and blockbuster titles.

### 5. Investment concentration is visible

**Avatar: The Way of Water** has the highest budget at approximately **0.46B**.

This demonstrates the scale of capital required for premium blockbuster production.

### 6. Popularity and revenue are not identical concepts

**The Gorge** has the highest popularity score at approximately **3.9K**, while the highest-revenue title is **Avengers: Endgame**.

This difference shows why a dashboard should track **revenue, popularity, ratings, and audience engagement separately** rather than using one metric as a universal definition of success.

### 7. Ratings alone are insufficient

The average movie rating is **5.96**, but the most highly rated titles do not necessarily appear among the highest-revenue or highest-popularity titles.

Therefore, rating should be treated as a quality/audience-perception metric rather than a direct commercial-success metric.

### 8. English-language content dominates the catalog

Approximately **9.5K movies** are in English, substantially ahead of other languages.

This indicates strong concentration around English-language content, while the presence of French, Japanese, Korean, Spanish, Chinese and other languages demonstrates international content diversity.

---

# 📺 TV Shows — Key Business Insights

### 1. TV performance is less explained by the available numeric metrics

The Python correlation analysis found no strong relationships among the major TV-show performance metrics.

In particular, popularity and vote count show only a weak positive relationship.

This suggests that TV-show success is more complex and may depend on factors not captured in the dataset, such as:

- Brand/franchise strength
- Episode count
- Season longevity
- Release strategy
- Marketing
- Platform exposure
- Cultural relevance
- Audience retention

These factors are **business hypotheses**, not variables directly measured in this dataset.

### 2. Audience engagement is concentrated

The average TV-show vote count is approximately **107**, while leading titles reach tens of thousands of votes.

**Game of Thrones** leads the vote-count ranking at approximately **25K**, followed by **Money Heist**, **Stranger Things**, and **The Walking Dead**.

This indicates a large gap between typical titles and globally recognized series.

### 3. Popularity is concentrated around highly visible shows

**The Late Show with Stephen Colbert** leads the popularity ranking at approximately **6.4K**, followed by **The Tonight Show Starring Jimmy Fallon** and **Good Mythical Morning**.

The result demonstrates that frequently engaged and recognizable programs can generate exceptionally high popularity scores.

### 4. Drama is the dominant TV genre

Drama is the largest genre category with approximately **2.7K titles**, followed by Reality and Comedy.

This indicates that drama is a major component of the TV content portfolio.

### 5. English remains the leading TV language

English leads with approximately **4.4K TV shows**, followed by Chinese, Japanese and Korean.

This shows English-language dominance while also highlighting strong Asian-language representation.

### 6. The United States is the largest TV production market in the dashboard

The United States contributes approximately **2.3K TV shows**, followed by China and Japan.

This indicates that a relatively small group of major production markets contributes a substantial portion of the catalog.

---

# ⚖️ Movies vs TV Shows — Strategic Comparison

| Metric | Movies | TV Shows |
|---|---:|---:|
| Records | 16,000 | 15,991 |
| Average Rating | 5.96 | 5.42 |
| Average Vote Count | 719 | 107 |
| Main Success Signal | Revenue + Engagement | Engagement + Popularity |
| Financial Metrics | Budget & Revenue available | Not available |
| Dominant Language | English | English |
| Leading Genre | Drama | Drama |
| Major Production Market | United States | United States |

### Strategic takeaway

Movies provide stronger direct commercial analysis because the dataset contains **Budget and Revenue**.

TV Shows require a broader engagement-based framework because the available financial variables are limited and the numeric correlations are weak.

---

# 💡 Business Recommendations

## For Movie Portfolio Decisions

1. Use **Budget + Revenue + Vote Count** together when evaluating commercial performance.
2. Do not select projects based on rating alone.
3. Monitor franchise performance because blockbuster titles dominate revenue.
4. Use popularity as an early audience-interest signal rather than a substitute for revenue.
5. Evaluate high-budget projects carefully because higher investment is associated with higher revenue, but high budget does not guarantee success.

## For TV Content Strategy

1. Track audience engagement alongside ratings.
2. Identify long-running and internationally recognized franchises.
3. Maintain a diversified genre portfolio rather than relying only on one category.
4. Consider regional and language diversity when expanding content.
5. Add additional business metrics such as watch hours, completion rate, subscriber acquisition, retention, seasons, episodes, and production cost in future versions of the model.

---

# ⚠️ Data Quality & Analytical Limitations

- Revenue and budget are available for Movies but not TV Shows, so direct financial comparison is not possible.
- Missing director and cast information exists in the TV Show dataset and was retained as NULL.
- `Rating` and `Vote Average` show a perfect correlation of **1.00**, indicating duplicate information; one should be removed in a future feature-engineering step.
- Popularity, ratings, and votes are audience/platform metrics and should not automatically be interpreted as causal drivers.
- The dataset does not contain complete profit, marketing, distribution, watch-time, subscriber, or retention information.
- The release-year visuals should be interpreted carefully because the dashboard data shows unusually uniform yearly counts; this may reflect dataset construction rather than a real-world release trend.

---

# 📁 Project Structure

```text
OTT-Movies-TV-Shows-Analytics/
│
├── data/
│   ├── movies.csv
│   └── tvshows.csv
│
├── sql/
│   ├── Staging_bulkinsert_Netflix.sql
│   ├── Netflix_copy_data.sql
│   ├── Netflix_Cleaning_part.sql
│   └── store_procedure_Netflix.sql
│
├── python/
│   ├── OTT_SQL_Connection.ipynb
│   ├── OTT_EDA.ipynb
│   └── OTT_VISUALS.ipynb
│
├── powerbi/
│   └── Movies_And_TV_Shows_Dashboard.pbix
│
├── screenshots/
│   ├── movies-dashboard.png
│   ├── tvshows-dashboard.png
│   └── insights.png
│
└── README.md
```

---

# 🔄 ETL / Analytics Workflow

```text
1. Collect Raw CSV Data
        ↓
2. Create OTT_DB
        ↓
3. BULK INSERT into Staging Tables
        ↓
4. Profile Data
        ↓
5. Detect Duplicates & NULLs
        ↓
6. Clean Text and Standardize Missing Values
        ↓
7. Validate Numeric & Date Fields
        ↓
8. Create Final Tables
        ↓
9. Load Data into Python
        ↓
10. Perform EDA
        ↓
11. Calculate KPIs & Correlations
        ↓
12. Build Power BI Dashboards
        ↓
13. Interpret Business Insights
        ↓
14. Recommend Business Actions
```

---

# 🚀 Future Enhancements

The project can be extended into a production-style analytics solution by adding:

- Automated API/data ingestion
- AWS S3 or Azure storage
- Incremental ETL instead of full refresh
- SQL Server Agent / Windows Task Scheduler automation
- Power BI Service scheduled refresh
- Watch-time and subscriber metrics
- Profit and ROI calculations
- Genre-level revenue analysis
- Country-level revenue analysis
- Recommendation system
- Predictive modeling for revenue/popularity
- Data warehouse star schema
- Automated data-quality monitoring

---

# 🎯 Final Project Outcome

This project demonstrates an end-to-end analytics workflow:

**SQL Server → Data Cleaning → Data Validation → Python EDA → Statistical Analysis → Power BI → Business Insights**

The most important business finding is that **Movie performance can be meaningfully evaluated through the combination of investment and audience engagement**, while **TV Show performance is more complex and cannot be explained reliably by ratings or popularity alone**.

The project therefore moves beyond dashboard creation and demonstrates how data can be transformed into **business-oriented decisions, analytical findings, and actionable recommendations**.

---

## 👤 Author

**Saswat Betta Aptakam**

**Data Analyst | SQL | Python | Power BI | Excel**

### Tools Used

`SQL Server` `Python` `Pandas` `NumPy` `Matplotlib` `Seaborn` `Power BI` `SQLAlchemy` `PyODBC`
