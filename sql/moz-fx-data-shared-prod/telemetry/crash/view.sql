CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.crash`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.telemetry_stable.crash_v4`
