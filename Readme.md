# Oil, Data, and Dependence: Analyzing Global NOC Revenues through Power BI

I designed this project to understand how **National Oil Companies (NOCs)** contribute financially to their home countries through revenue generation. Although NOCs collectively earn **trillions of dollars in annual revenue**, the transparency and fiscal dependence of each country vary dramatically.

---

### Objectives

This dashboard helps answer questions like:

- Which NOCs generate the most revenue globally?
- How dependent are governments on NOC revenues?
- What trends emerge from 2011 to 2023 across different regions?

The goal is to create a **Power BI dashboard** that turns complex NOC revenue data into clear financial insights, supporting smarter decision-making for investors, analysts, and policymakers.

### Data Source

- **Dataset:** [National Oil Company Database](https://www.nationaloilcompanydata.org/indicator?utm_source=chatgpt.com)
- **Time Range:** 2011–2023
- **Key Indicators Used:**
    - NOC Total Revenues (USD)
    - NOC Revenues as % of General Government Revenues
    - Peer Group, Region, Year, Company

### **Data Collection & Cleaning**

- Downloaded dataset from the NOC page.
    
    [NRGI-NOCdatabase-ExploreByIndicator.xlsx](attachment:70ba6ddf-4e73-4f22-93ce-bed6773705a5:NRGI-NOCdatabase-ExploreByIndicator.xlsx)
    
- Cleaned data in **Power Query**:
    - Adjusted column names
        
        ![Screenshot 2025-11-14 at 9.36.45 PM.png](attachment:b22f6cd1-ff32-4a20-973c-a9b2910f5865:64915871-bf47-4fd3-8879-578d222df173.png)
        
    - Replaced nulls with zeros & added a YearSUM column
        
        ![Screenshot 2025-11-14 at 10.20.31 PM.png](attachment:23b2679b-4b30-4b35-81a4-a4e70673e574:Screenshot_2025-11-14_at_10.20.31_PM.png)
        
    
    ### **Data Modelling in Power BI**
    
    - Created relationships between **Company Information → Country → Region** tables for cross-filtering.
        
        ![Screenshot 2025-12-12 at 10.18.03 PM.png](attachment:464e4bf2-0765-4a3c-9f44-447cb1a4f2fd:46b47437-53f8-4f5e-9caf-5619bfcdd9d8.png)
        
        Defined calculated metrics using **DAX**:
        
        - `Total Revenue = SUM(Revenue)`
        - `Year-over-Year Growth = ([This Year Revenue] - [Last Year Revenue]) / [Last Year Revenue] * 100`
        - `Revenue Rank = RANKX(ALL(Region), [Total Revenue])`
        - `Revenue Rank = RANKX(ALL(Company), [Total Revenue])`
     

### **Dashboard Design**

**Dashboard Pages & Visuals:**

1. **Global Overview** – KPI cards showing Total Revenue and Highest Earning NOC.
    
    ![Screenshot 2025-12-13 at 2.08.33 AM.png](attachment:e17e3bfa-9c15-460c-897d-46e4e53135bb:Screenshot_2025-12-13_at_2.08.33_AM.png)
    
2. **Regional Performance** – Map showing aggregated revenues by region.
    
    ![Screenshot 2025-12-13 at 2.08.54 AM.png](attachment:0c2b5195-c2b7-4af8-9f2a-9d4031129292:Screenshot_2025-12-13_at_2.08.54_AM.png)
    
3. **Top Performers** – Pie chart comparing Top 10 NOCs by annual revenue.
    
    ![Screenshot 2025-12-13 at 2.09.12 AM.png](attachment:10b3cc00-d40c-4e49-9aaf-89c2d936fcf9:Screenshot_2025-12-13_at_2.09.12_AM.png)
    
4. **Fiscal Dependence** – Line + column chart showing NOC revenue vs government revenue over time.
5. **Interactive Filters** – Region, Year, Peer Group, and Company slicers for exploration.
  
## Featured Projects

| Project | Description |
|----------|--------------|
| **Global NOC Revenue Insights Dashboard** | Visualizes National Oil Company revenue trends (2011–2023) and fiscal dependence patterns using Power BI. |
| **xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx** | Tracks product revenue, profit, and regional sales metrics with dynamic slicers and KPI cards. |

## Tools & Technologies

- **Power BI Desktop**
- **DAX (Data Analysis Expressions)**
- **Power Query (ETL & Data Cleaning)**
- **Excel / CSV / Public Datasets**

## Key Learning Areas

- Data modeling and relationship management  
- Building custom measures and KPIs  
- Creating dynamic reports with slicers and buttons  
- Enhancing data storytelling with layout and color design  

### By Ikenna Anasieze
