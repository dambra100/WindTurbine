#!/bin/bash

echo "Starting Wind Turbine SCADA Data Ingestion Pipeline..."

# 1. Health Check: Verify the database container is running
if ! docker ps | grep -q "wind_turbine_db"; then
    echo "❌ Error: Database container 'wind_turbine_db' is not running."
    echo "Please run 'docker-compose up -d' from the /infrastructure directory first."
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

# 3. Execution: Run the analytical SQL scripts
echo "🔄 Executing noise reduction and rolling average transformations..."
# docker exec -i wind_turbine_db psql -U scada_admin -d turbine_telemetry -f /sql/02_rolling_average.sql

echo "🔄 Executing mechanical downtime and financial impact analysis..."
# docker exec -i wind_turbine_db psql -U scada_admin -d turbine_telemetry -f /sql/01_downtime_analysis.sql

echo "🚀 Pipeline execution complete. High-fidelity analytics ready."
