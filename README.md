# 🚀 Assignment 1: INDIA E-COMMERCE TRENDS ANALYSIS | JSONs parsing & window functions application in DuckDB

This project focuses on processing and extracting insights from the **Flipkart Fashion Dataset**, a massive collection of 5.7M+ records from India’s leading e-commerce platform.

### 📊 Dataset Overview

The raw data was sourced from [Kaggle](https://www.kaggle.com/datasets/aaditshukla/flipkart-fasion-products-dataset) and contains granular details on clothing items, including pricing dynamics, brand performance, and product specifications.

**Schema Post-Processing:**

| Category | Columns |
| --- | --- |
| **Identifiers** | `id`, `style_code`, `title` |
| **Pricing** | `actual_price`, `selling_price` |
| **Metrics** | `average_rating`, `out_of_stock` |
| **Metadata** | `brand`, `category`, `sub_category`, `seller`, `crawled_at` |
| **Attributes** | `closure`, `pockets`, `fabric`, `pattern`, `color` |

---

### 🔍 Data Insights

Queries for JSON parsing and data analysis can be found in `assignment1.sql` file.

#### 1. Price Variance Analysis

I calculated the **Price Difference** (the delta between `selling_price` and `actual_price`) and found the average for each subcategory.

* **Logic:** Aggregated the average price delta per sub-category.
* **Window Function:** Utilized `ROW_NUMBER()` to rank sub-categories within their parent categories, ordered from largest to smallest price difference.

<img width="1144" height="531" alt="Знімок екрана 2026-02-16 о 18 37 51" src="https://github.com/user-attachments/assets/9e508826-e16a-4a0a-a7bc-16cba914166a" />

---

#### 2. Top-reviewed Brands Indentification

To identify market leaders, I extracted the top-performing brands based on consumer rating.

* **Logic:** Calculated the mean `average_rating` per brand.
* **Window Function:** Applied `DENSE_RANK()` (or similar tie-handling logic) to isolate the **Top-3 brands** within each sub-category.
* **Outcome:** Brands with identical ratings share the same rank.

<img width="1096" height="536" alt="Знімок екрана 2026-02-16 о 18 34 12" src="https://github.com/user-attachments/assets/9c2d4511-0e0e-4f11-aa4d-981df85a5909" />

---

### 🛠 Tech Stack

* **Language:** SQL
* **Database Management System:** DuckDB 
* **Logic:** Window Functions, JSON Parsing, Data Aggregation
