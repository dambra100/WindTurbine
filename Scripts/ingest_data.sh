#!/bin/bash

echo "Starting Wind Turbine SCADA Data Ingestion Pipeline..."

# 1. Health Check: Verify the database container is running
if ! docker ps | grep -q "wind_turbine_db"; then
    echo "❌ Error: Database container 'wind_turbine_db' is not running."
    echo "Please run 'docker-compose up -d' from the /Infrastructure directory first."
    exit 1
fi

echo "✅ Database is active. Commencing ELT process..."

# 2. Schema Setup: Create the raw staging table
docker exec -i wind_turbine_db psql -U scada_admin -d turbine_telemetry -c "
CREATE TABLE IF NOT EXISTS raw_scada (
    date_time TIMESTAMP,
    wind_speed_ms DECIMAL,
    theoretical_power_curve DECIMAL,
    active_power_kw DECIMAL
);
"
echo "✅ Staging tables verified."

# 3. Data Loading (The 'L' in ELT)
# Note: Ensure your raw data file is placed in a /Data folder, or adjust the path below.
echo "📥 Loading raw telemetry data into PostgreSQL..."
# Uncomment and update the path to your actual CSV file when you have it downloaded:
# docker exec -i wind_turbine_db psql -U scada_admin -d turbine_telemetry -c "\copy raw_scada FROM STDIN WITH (FORMAT csv, HEADER true);" < ../Data/scada_data.csv

# 4. Execution: Run the analytical SQL scripts
# We use '<' to stream the local SQL files into the container's standard input
echo "🔄 Executing noise reduction and rolling average transformations..."
docker exec -i wind_turbine_db psql -U scada_admin -d turbine_telemetry < ../SQL/02_rolling_average.sql

echo "🔄 Executing mechanical downtime and financial impact analysis..."
docker exec -i wind_turbine_db psql -U scada_admin -d turbine_telemetry < ../SQL/01_downtime_analysis.sql

echo "🚀 Pipeline execution complete. High-fidelity analytics ready."
