CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.cfr`
AS SELECT
  * REPLACE(
    mozfun.norm.metadata(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.messaging_system_stable.cfr_v1`
