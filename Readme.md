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
        
<img width="2000" height="1181" alt="image" src="https://github.com/user-attachments/assets/63dca1ed-8264-4325-b5b6-4c3a4d5508f8" />
    - Replaced nulls with zeros & added a YearSUM column
        
<img with="2048" height="1180" alt="image" src="https://github.com/user-attachments/assets/33323beb-1a96-4d85-a9df-be83307ee8b7" />
            
### **Data Modelling in Power BI** 
   - Created relationships between **Company Information → Country → Region** tables for cross-filtering.
        
<img width="1852" height="887" alt="image" src="https://github.com/user-attachments/assets/1185a2ac-f2a2-482d-a8f7-63f9d5fd82df" />      
  - Defined calculated metrics using **DAX**:
        
        - Total Revenue = SUM(Revenue)
        - Year-over-Year Growth = ([This Year Revenue] - [Last Year Revenue]) / [Last Year Revenue] * 100
        - Revenue Rank = RANKX(ALL(Region), [Total Revenue])
        - Revenue Rank = RANKX(ALL(Company), [Total Revenue])

### **Dashboard Design**

**Dashboard Pages & Visuals:**

1. **Global Overview** – KPI cards showing Total Revenue and Highest Earning NOC.
    
<img width="2048" height="977" alt="image" src="https://github.com/user-attachments/assets/e02156fc-bab8-487d-a733-907ab2579c2e" />
    
2. **Regional Performance** – Map showing aggregated revenues by region.
    
<img width="2048" height="1158" alt="image" src="https://github.com/user-attachments/assets/bd67b842-3031-43d6-b8d1-95571a373752" />
    
3. **Top Performers** – Pie chart comparing Top 10 NOCs by annual revenue.
    
<img width="2048" height="1073" alt="image" src="https://github.com/user-attachments/assets/a53a98f6-e35c-467f-84db-87dac5be5b48" />
    
4. **Fiscal Dependence** – Line + column chart showing NOC revenue vs government revenue over time.
5. **Interactive Filters** – Region, Year, Peer Group, and Company slicers for exploration.

### **Analysis & Insights**

- Identified which NOCs consistently dominate global revenue (e.g., Saudi Aramco, KPC, Pemex).
- Highlighted regions with **high fiscal dependence**, such as the Middle East and Sub-Saharan Africa.
- Observed how **oil price shocks (2014, 2020)** impact overall NOC earnings.
- Showed differences between **commercially driven vs. state-controlled NOCs** in growth trends.

### **Validation & Reporting**

- Cross-referenced key revenue figures with public financial statements (e.g., Aramco Annual Reports).
- Validated ratios with World Bank’s public finance data for selected countries.
- Published dashboard to **Power BI Service** for interactive exploration.
- Documented visuals, insights, and methodology in Github.
  
### Outcomes

- Interactive global dashboard tracking NOC revenue trends (2011–2023).
- Benchmarked government fiscal dependence on NOC income.
- Highlighted top-performing companies and most volatile revenue regions.
- Strengthened Power BI skills in **data modelling, DAX, KPI design, and geo-visualization**.

### By Ikenna Anasieze
