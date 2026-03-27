SELECT 
    DATE(date_time) AS failure_date,
    COUNT(*) AS downtime_intervals,
    ROUND(SUM(theoretical_power_curve)::numeric, 2) AS total_lost_kw
FROM t1
WHERE wind_speed_ms > 5 
  AND active_power_kw = 0
GROUP BY DATE(date_time)
ORDER BY total_lost_kw DESC
LIMIT 10;
