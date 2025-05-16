
# 🍕 Pizza Hut Sales Analysis Project (PostgreSQL)

This project analyzes pizza sales data for a fictional Pizza Hut franchise using **PostgreSQL**. It covers business questions related to sales, revenue, customer preferences, and ordering trends.

## 📂 Dataset

The dataset consists of 4 CSV files:

- `orders.csv` – Information about each order (date, time, order_id).
- `order_details.csv` – Quantity and type of each pizza in an order.
- `pizzas.csv` – Price and size of each pizza.
- `pizza_types.csv` – Details of each pizza (name, category, ingredients).

## 🧠 Business Questions Answered

The SQL queries are divided into three levels:

### 🔹 Basic

- Total number of orders
- Total revenue generated
- Highest priced pizza
- Most common pizza size
- Top 5 most ordered pizzas

### 🔸 Intermediate

- Total quantity ordered by category
- Order distribution by hour of the day
- Category-wise pizza distribution
- Average pizzas ordered per day
- Top 3 pizzas by revenue

### 🔺 Advanced

- Percentage contribution of each pizza type to total revenue
- Cumulative revenue over time
- Top 3 revenue-generating pizzas for each category

## ⚙️ Technologies Used

- PostgreSQL (SQL)
- CSV files as data source
- Common Table Expressions (CTE), Window Functions, Joins, Aggregates

## 📌 How to Use

1. Import the CSV files into your PostgreSQL database.
2. Run the SQL queries from the provided `.sql` file.
3. Analyze the results using your SQL editor (e.g., DBeaver, pgAdmin).

## 📈 Insights

- Peak ordering times are easy to identify.
- Most popular pizza sizes and types are revealed.
- Business can focus on top-selling categories and optimize pricing.

---

## 📁 Files Included

- `PIZZA_HUT PROJECT CODES SOLVE.sql` – All SQL queries
- `orders.csv`, `order_details.csv`, `pizzas.csv`, `pizza_types.csv`
- `Questions.txt` – List of business problems solved

## 🙌 Credits

This project was created as a learning exercise in SQL and data analytics.
