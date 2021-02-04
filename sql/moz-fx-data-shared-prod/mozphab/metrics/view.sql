CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozphab.metrics`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata,
    mozfun.norm.glean_ping_info(ping_info) AS ping_info)
FROM
  `moz-fx-data-shared-prod.mozphab_stable.metrics_v1`
