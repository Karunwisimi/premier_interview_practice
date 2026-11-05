# Sales Analytics: From Raw Data to Business Intelligence

An end-to-end analysis of a raw sales file, built for the Senior Tech Facilitator assessment at Premierhub Innovation Center. I profiled and cleaned the data in Excel, queried it in MySQL, modelled it in Power BI, and turned the results into a dashboard and two recommendations for management.

**Author:** Simisola Karunwi

## Business question

Where does our revenue come from, and where are we losing it?

## Key results

The data covers July to September 2026, in naira. Net sales counts completed and valid orders only.

| Measure | Result |
| --- | --- |
| Net sales | ₦33,881,750 |
| Completed orders | 55 |
| Average order value | ₦616,032 |
| Cancel rate | 15.6% |
| Units sold | 248 |

**Insight 1: cancellations are concentrated.** Abuja cancels 26.7% of its valid orders, against 5.9% in Lagos. September reached 26.9%, up from 5.3% in August. Monitors (30%) and External SSDs (27%) cancel the most. Recommendation: review order confirmation and stock availability in Abuja, starting with those two products.

**Insight 2: revenue depends on very little.** Kora Stores is 33% of net sales and Laptops are 51% of revenue. Recommendation: assign a key-account owner and build a pipeline of other customers and products.

## Tools

| Tool | Used for |
| --- | --- |
| Excel | Profiling and cleaning |
| Python (pandas) | The same cleaning, written for larger files |
| MySQL | Database, view with the business rules, and queries |
| Power BI | Data model, DAX measures and dashboard |
| PowerPoint | Dashboard wireframe and presentation |

## Project files

Edit the names below to match the files in this repository.

| File | What it is |
| --- | --- |
| `sales_transactions_raw.csv` | The original data, left untouched |
| Cleaned Excel file | The cleaned data, as an Excel table |
| Cleaned CSV for SQL | Prepared for MySQL: no currency symbols, discounts as decimals |
| SQL file | Table setup, the view and the queries |
| Power BI file (`.pbix`) | Data model, measures and dashboard |
| Wireframe (`.pptx`) | The dashboard layout I agreed before building |
| Presentation (`.pptx`) | The management presentation |
| Report (`.docx`) | The full written report |

## What I did

1. **Copied the raw file** and worked only on the copy, so the original stays as a record.
2. **Profiled the data** in Excel and found issues in every category the brief listed.
3. **Cleaned it:** fixed what was certain, flagged what was not.
4. **Built a database** in MySQL, imported the cleaned CSV, and put the business rules in a view.
5. **Modelled it in Power BI:** added `net_sales` and `is_valid` columns, a Calendar dimension joined to the sales table, and explicit DAX measures.
6. **Planned the layout on a wireframe** using the Premier Hub colours, then built the dashboard inside it.

## Data quality issues and decisions

| Issue | Transaction | Decision |
| --- | --- | --- |
| Exact duplicate | TXN-0010 | Removed the copy |
| Duplicate ID with different values (4 and 99 units) | TXN-0021 | Kept both and flagged. I cannot tell which is correct, so I would ask the owner |
| Missing customer, region, sales rep | TXN-0061, TXN-0006, TXN-0079 | Filled with Unknown |
| Missing unit price | TXN-0025 | Recovered from the same product, since each product has one price |
| Quantity written as text ("three") | TXN-0019 | Converted to 3 |
| Negative quantity (-2) | TXN-0052 | Changed to 2 as an assumption. I would confirm this with the business |
| Discount of 1.25 | TXN-0032 | Flagged and excluded from revenue |
| Inconsistent status and payment labels | TXN-0045, TXN-0071 | Standardised to Completed and Transfer |
| Trailing space in region | TXN-0039 | Trimmed |
| Month-first date among year-first dates | TXN-0013 | Converted to a proper date |

## Business rules

- **Revenue is completed and valid orders only.** Pending orders are still in process and may be cancelled. Cancelled orders never produced money. Invalid rows cannot be trusted until the owner confirms them. These are reported separately so sales are never overstated.
- **Net sales** = quantity × unit price × (1 − discount).
- **Valid** means quantity between 1 and 50 and discount between 0 and 1.
- **Cancel rate** = cancelled valid orders ÷ all valid orders.

## How to reproduce

1. Save a copy of the raw CSV and clean the copy using the decisions above.
2. Export the cleaned data as a CSV with discounts as decimals, no currency symbols and year-first dates.
3. In MySQL, create a database and table, import the CSV, then run the SQL file. Expected check: 79 rows, and net sales of ₦33,881,750 from 55 completed orders.
4. Open the Power BI file, point it at the cleaned Excel table, and refresh.
5. Check that the dashboard shows the same net sales, 55 completed orders and a 15.6% cancel rate.

## Assumptions and limitations

- The data is synthetic, has 79 usable rows and covers three months, so the findings are leads to investigate, not firm conclusions.
- There is no cost or profit data, so the analysis covers revenue only.
- Changing TXN-0052 from -2 to 2 adds ₦56,000 to net sales, about 0.2%.
- A few rows have an Unknown region, customer or sales rep, which understates those groups slightly.

## Questions I would ask a real client

- Were the duplicate transaction IDs deliberate, and is the ID a primary key?
- Which TXN-0021 record is correct?
- Why is there a discount of 1.25, and does a negative quantity mean a return or a typing error?
