CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_launcher_process.launcher_process_failure`
AS -- Generated by bigquery_etl.view.generate_stable_views

SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.firefox_launcher_process_stable.launcher_process_failure_v1`