-- Project 2: Ops KPI / SLA Dashboard Tables
-- Columns (confirmed):
-- ticket_id, created_at, resolved_at, priority, category, channel, agent, sla_hours, status, csat_positive

-- Convert timestamps and compute resolution hours + SLA breach flag
-- SLA breach definition: resolution_hours > sla_hours

-- 1) Overall KPIs (1 row)
COPY (
  WITH t AS (
    SELECT
      *,
      CAST(created_at AS TIMESTAMP) AS created_ts,
      CAST(resolved_at AS TIMESTAMP) AS resolved_ts,
      (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 AS resolution_hours,
      CASE
        WHEN (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 > sla_hours THEN 1
        ELSE 0
      END AS sla_breached
    FROM read_csv_auto('data/project2_ops_tickets.csv')
  )
  SELECT
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN LOWER(status) = 'resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_breached = 0 THEN 1 ELSE 0 END), 2) AS sla_compliance_pct,
    ROUND(100.0 * AVG(csat_positive), 2) AS csat_positive_pct
  FROM t
) TO 'outputs/ops_kpis.csv' (HEADER, DELIMITER ',');

-- 2) Backlog trend (tickets created per month)
COPY (
  WITH t AS (
    SELECT
      CAST(created_at AS TIMESTAMP) AS created_ts,
      status
    FROM read_csv_auto('data/project2_ops_tickets.csv')
  )
  SELECT
    strftime(created_ts, '%Y-%m') AS month,
    COUNT(*) AS tickets_created,
    SUM(CASE WHEN LOWER(status) <> 'resolved' THEN 1 ELSE 0 END) AS open_created
  FROM t
  GROUP BY month
  ORDER BY month
) TO 'outputs/ops_volume_by_month.csv' (HEADER, DELIMITER ',');

-- 3) SLA compliance by priority
COPY (
  WITH t AS (
    SELECT
      priority,
      sla_hours,
      (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 AS resolution_hours,
      CASE
        WHEN (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 > sla_hours THEN 1
        ELSE 0
      END AS sla_breached
    FROM read_csv_auto('data/project2_ops_tickets.csv')
  )
  SELECT
    priority,
    COUNT(*) AS tickets,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_breached = 0 THEN 1 ELSE 0 END), 2) AS sla_compliance_pct
  FROM t
  GROUP BY priority
  ORDER BY tickets DESC
) TO 'outputs/ops_sla_by_priority.csv' (HEADER, DELIMITER ',');

-- 4) Resolution time + SLA by category
COPY (
  WITH t AS (
    SELECT
      category,
      sla_hours,
      (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 AS resolution_hours,
      CASE
        WHEN (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 > sla_hours THEN 1
        ELSE 0
      END AS sla_breached
    FROM read_csv_auto('data/project2_ops_tickets.csv')
  )
  SELECT
    category,
    COUNT(*) AS tickets,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_breached = 0 THEN 1 ELSE 0 END), 2) AS sla_compliance_pct
  FROM t
  GROUP BY category
  ORDER BY avg_resolution_hours DESC
) TO 'outputs/ops_resolution_by_category.csv' (HEADER, DELIMITER ',');

-- 5) Agent performance (top 15 by volume)
COPY (
  WITH t AS (
    SELECT
      agent,
      sla_hours,
      (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 AS resolution_hours,
      CASE
        WHEN (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 > sla_hours THEN 1
        ELSE 0
      END AS sla_breached
    FROM read_csv_auto('data/project2_ops_tickets.csv')
  )
  SELECT
    agent,
    COUNT(*) AS tickets,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_breached = 0 THEN 1 ELSE 0 END), 2) AS sla_compliance_pct
  FROM t
  GROUP BY agent
  ORDER BY tickets DESC
  LIMIT 15
) TO 'outputs/ops_agent_performance.csv' (HEADER, DELIMITER ',');

-- 6) Channel performance (optional but strong)
COPY (
  WITH t AS (
    SELECT
      channel,
      sla_hours,
      (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 AS resolution_hours,
      CASE
        WHEN (epoch(CAST(resolved_at AS TIMESTAMP)) - epoch(CAST(created_at AS TIMESTAMP))) / 3600.0 > sla_hours THEN 1
        ELSE 0
      END AS sla_breached
    FROM read_csv_auto('data/project2_ops_tickets.csv')
  )
  SELECT
    channel,
    COUNT(*) AS tickets,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * AVG(CASE WHEN sla_breached = 0 THEN 1 ELSE 0 END), 2) AS sla_compliance_pct
  FROM t
  GROUP BY channel
  ORDER BY tickets DESC
) TO 'outputs/ops_channel_performance.csv' (HEADER, DELIMITER ',');
