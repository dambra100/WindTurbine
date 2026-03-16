# Wind Turbine Sensor Data Pipeline & Downtime Analysis

## Overview
This project bridges physical infrastructure with modern data engineering. As a Mechanical Engineering graduate (BEng, Brunel University London), I engineered this local pipeline to ingest, format, and analyze raw SCADA sensor data to calculate the direct financial impact of mechanical turbine failures.

## Tech Stack
* **Infrastructure:** Local Linux Server, Docker Containerization
* **Database:** PostgreSQL (deployed via Docker), DBeaver
* **Analytics:** Advanced SQL (Window Functions, Aggregations, Data Type Transformations)
* **Version Control:** Git & GitHub

## Architecture & Process
1. **The ELT Pipeline:** Handled massive raw `.csv` sensor datasets by extracting and loading them into PostgreSQL, executing the transformations directly within the database to standardize non-compliant European timestamps.
2. **Downtime Financial Analysis:** Engineered SQL queries to cross-reference active wind speed against power output to identify true mechanical faults (e.g., brake failures, maintenance shutdowns, or grid disconnects). Identified a peak single-day loss of over 350,000 kW of potential energy.
3. **Sensor Noise Reduction:** Implemented 5-interval rolling averages using advanced SQL Window Functions to smooth out erratic wind gust data and reveal true mechanical performance trends.# Wind Turbine Data Engineering Project
