-- Generated via script/experiments_monitoring/generate_search_metrics_views.py
CREATE MATERIALIZED VIEW
IF
  NOT EXISTS `moz-fx-data-shared-prod.{{ dataset }}.experiment_{{ metric }}_live_v1`
  OPTIONS
    (enable_refresh = TRUE, refresh_interval_minutes = 5)
  AS
  WITH desktop AS (
    SELECT
      submission_timestamp,
      experiment.key AS experiment,
      experiment.value.branch AS branch,
      { %
      IF
        probe = ="payload.keyed_histograms.search_counts" - % }
      -- We cannot make UDF calls in a materialized view, so we have to reimplement part of
      -- mozfun.hist.extract here.
        SAFE_CAST(
          COALESCE(
            JSON_EXTRACT_SCALAR(search_counts.value, '$.sum'),
            SPLIT(search_counts.value, ';')[SAFE_OFFSET(2)],
            SPLIT(search_counts.value, ',')[SAFE_OFFSET(1)],
            search_counts.value
          ) AS INT64
        ) AS search_count,
        { %
      ELSE
        - % } { {probe.split(".")[-1] } }.value
        AS
          { {metric } } { %endif - % }
        FROM
          `{{ base_table }}`,
          UNNEST({ {experiment } }) AS experiment,
          UNNEST({ {probe } })
        AS
          { {probe.split(".")[-1] } }
  )
  SELECT
    date(submission_timestamp) AS submission_date,
    experiment,
    branch,
    TIMESTAMP_ADD(
      TIMESTAMP_TRUNC(submission_timestamp, HOUR),
    -- Aggregates event counts over 5-minute intervals
      INTERVAL(DIV(EXTRACT(MINUTE FROM submission_timestamp), 5) * 5) MINUTE
    ) AS window_start,
    TIMESTAMP_ADD(
      TIMESTAMP_TRUNC(submission_timestamp, HOUR),
      INTERVAL((DIV(EXTRACT(MINUTE FROM submission_timestamp), 5) + 1) * 5) MINUTE
    ) AS window_end,
    SUM({ {metric } })
  AS
    { {metric } }
  FROM
    desktop
  WHERE
    -- Limit the amount of data the materialized view is going to backfill when created.
    -- This date can be moved forward whenever new changes of the materialized views need to be deployed.
    DATE(submission_timestamp) >= DATE('2021-03-15')
  GROUP BY
    submission_date,
    experiment,
    branch,
    window_start,
    window_end
