# Assignments for course "AI240 Data Engineering Concepts"
## Assignment 1

I worked with [Flipkart fashion products dataset](https://www.kaggle.com/datasets/aaditshukla/flipkart-fasion-products-dataset).

Flipkart is the largest E-commerce website based in India. The pre-crawled dataset has more than 5.7 million records. It contains information about various clothing items, their brand, when each of them was added, how each of them was rated, their actual and sellimg prices, etc.

**After processing the JSON I got a table with such columns:**
- `id`
- `actual_price`
- `average_rating`
- `brand`
- `category`
- `crawled_at`
- `out_of_stock`
- `style_code`
- `closure`
- `pockets`
- `fabric`
- `pattern`
- `color`
- `seller`
- `selling price`
- `sub_category`
- `title`

### Data Insights:
#### 1. Ranking by average price difference by category
I defined `price difference` as `selling_price - actual_price` and found the average for each subcategory. Using `row_number` window function I **ranked the subcategories inside each category** from the biggest price difference to the smallest (assigning a different rank to each row).

<img width="1144" height="531" alt="Знімок екрана 2026-02-16 о 18 37 51" src="https://github.com/user-attachments/assets/9e508826-e16a-4a0a-a7bc-16cba914166a" />

#### 2. Top-3 brands by category by average rating
I calculated `average rating` for each brand and delivered **the top-3 brands with biggest average rating within each subcategory**, assigning the same rank to the brands with the same rating.

<img width="1096" height="536" alt="Знімок екрана 2026-02-16 о 18 34 12" src="https://github.com/user-attachments/assets/9c2d4511-0e0e-4f11-aa4d-981df85a5909" />
