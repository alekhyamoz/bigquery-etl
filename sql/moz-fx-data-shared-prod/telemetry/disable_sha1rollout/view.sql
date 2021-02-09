CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.disable_sha1rollout`
AS -- Generated by bigquery_etl.view.generate_stable_views

SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.telemetry_stable.disable_sha1rollout_v4`