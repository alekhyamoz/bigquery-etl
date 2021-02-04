CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.frecency_update`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.telemetry_stable.frecency_update_v4`
