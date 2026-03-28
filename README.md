# 🌪️ Wind Turbine SCADA Analytics & ELT Pipeline

## 📌 Project Overview
A containerised data engineering pipeline designed to process industrial SCADA telemetry, isolate mechanical failures from environmental factors, and calculate the financial impact of turbine downtime. 

This project demonstrates a full physical-to-digital data architecture, featuring automated data ingestion, advanced SQL window functions for signal noise reduction, and real-time visualisation capabilities.

## 📊 Tech Stack
* **Database:** PostgreSQL / TimescaleDB
* **Visualisation:** Grafana
* **Ingestion:** Bash / Docker Exec
* **Querying:** Advanced SQL (CTEs, Window Functions)

## 📁 Repository Structure

* `/Infrastructure/`
  * `docker-compose.yaml` - Container configuration for TimescaleDB and the Grafana visualisation server.
* `/Scripts/`
  * `ingest_data.sh` - Automated ELT shell script for database health checks, schema setup, and query execution.
* `/SQL/`
  * `01_downtime_analysis.sql` - Core logic for isolating mechanical faults from environmental data and calculating financial impact.
  * `02_rolling_average.sql` - Advanced window functions for filtering erratic wind gusts and smoothing telemetry.
* `README.md` - Project documentation and architecture overview.

## ⚙️ Core Capabilities

### 1. Fault Isolation & Financial Analytics
Identifies exact periods of mechanical or grid failure by mathematically isolating intervals where wind speed is sufficient (`> 5m/s`) but active power generation is zero. It then calculates the theoretical power lost during these blackouts to provide a quantifiable financial impact metric.

### 2. Telemetry Smoothing
Raw SCADA data is often subjected to environmental noise and sensor jitter. The pipeline employs SQL window functions (5-interval rolling averages) to smooth out erratic wind gusts, providing a cleaner, more accurate dataset for predictive maintenance analysis.

### 3. Automated ELT Ingestion
A robust Bash script handles the entire Extract, Load, and Transform (ELT) process. It verifies container health, builds the `raw_scada` staging schema, and executes the analytical SQL transformations without requiring manual database interaction.

## 🚀 How to Run Locally

**1. Spin up the Infrastructure**
Navigate to the infrastructure folder and start the TimescaleDB and Grafana containers:
```bash
cd Infrastructure
docker-compose up -d
