CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.tls_13_study_v2`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.telemetry_stable.tls_13_study_v2_v4`
