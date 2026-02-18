# Project 2 — Ops KPI / SLA Dashboard

## Overview
This project demonstrates an operations analytics workflow: transforming raw ticket data into SLA and performance KPIs, then building an interactive dashboard for stakeholders to monitor service health, bottlenecks, and improvement opportunities.

## Business Problem
An operations team needs a clear, repeatable way to answer:
- Are we meeting SLAs by priority?
- How long does it take to resolve tickets (overall and by category/channel)?
- Which categories and channels are driving the longest resolution times?
- Which agents are handling the most volume and meeting SLA expectations?
- What is customer satisfaction (CSAT) doing?

## Dashboard
**Interactive dashboard (Looker Studio):** (https://lookerstudio.google.com/reporting/86c86295-405e-4a04-8e48-3069f37d759a/page/OsnoF/edit)

![Project 2 Dashboard](docs/images/project2_dashboard.png)
[Open screenshot](docs/images/project2_dashboard.png)


## Key Metrics (Definitions)
- **Total Tickets:** total number of tickets created in the selected period.
- **SLA Compliance %:** % of resolved tickets where resolution time <= SLA hours (by priority).
- **Avg Resolution (hrs):** average hours between created_at and resolved_at for resolved tickets.
- **CSAT Positive %:** % of resolved tickets with positive CSAT feedback (1 = positive, 0 = not positive).

## Data
Source file:
- `data/project2_ops_tickets.csv`

Columns include:
- ticket_id, created_at, resolved_at, priority, category, channel, agent, sla_hours, status, csat_positive

## Tools Used
- **SQL (DuckDB):** aggregation and KPI table creation  
- **Python:** executes SQL and exports CSV outputs  
- **Google Sheets:** hosting the output tables for Looker Studio  
- **Looker Studio:** dashboard and data visualization  
- **GitHub:** version control and portfolio publishing

## Outputs Generated (for the dashboard)
The dashboard is built from these tables in `outputs/`:
- `ops_kpis.csv`
- `ops_volume_by_month.csv`
- `ops_sla_by_priority.csv`
- `ops_resolution_by_category.csv`
- `ops_channel_performance.csv`
- `ops_agent_performance.csv`

## Insights (Example Talking Points)
Use these when presenting the dashboard:
- **SLA risk:** Critical priority typically has the lowest SLA compliance and should be monitored closely.
- **Bottlenecks:** The slowest categories highlight process or dependency issues (handoffs, tooling, approvals).
- **Channel opportunity:** The slowest channel suggests routing/triage improvements or staffing changes.
- **Agent coaching:** Compare volume vs speed vs SLA to identify training and load-balancing opportunities.

## Recommendations
1) **Reduce SLA misses:** focus on the lowest-performing priority (often Critical) with tighter triage and escalation rules.
2) **Remove bottlenecks:** investigate the slowest categories and standardize playbooks/macros to reduce resolution time.
3) **Improve channel routing:** if one channel is consistently slower, adjust staffing, automate triage, or shift volume to faster channels.

## How to Reproduce (Run Locally in Codespaces)
1) Generate dashboard output tables:
```bash
python scripts/run_project2_dashboard_sql.py
