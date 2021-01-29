SELECT
  * EXCEPT (submission_date)
FROM
  experiment_search_aggregates_base
WHERE
  submission_date = @submission_date
  AND dataset_id = 'telemetry_stable'