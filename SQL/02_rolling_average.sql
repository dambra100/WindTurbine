SELECT 
    date_time,
    wind_speed_ms,
    ROUND(AVG(wind_speed_ms) OVER (
        ORDER BY date_time 
        ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
    )::numeric, 2) AS rolling_avg_wind_speed
FROM raw_scada
WHERE wind_speed_ms > 0
LIMIT 20;
