-- Project 2: Ops KPI / SLA dashboard tables

COPY (
  WITH t AS (SELECT * FROM read_csv_auto('data/project2_ops_tickets.csv'))
  SELECT
    COUNT(*) AS total_tickets
  FROM t
) TO 'outputs/ops_kpis.csv' (HEADER, DELIMITER ',');
