/*
    Example: Transaction Enrichment Query

    Description:
    This query demonstrates how to combine transactional data with
    related entity and reference data to produce enriched reporting output.

    Notes:
    - All names and values are fictional and for demonstration purposes only.
    - No real business logic or production data is included.
*/

SELECT
    u.EntityId,
    p.ItemId,

    CASE
        WHEN p.ItemType = 'A' THEN 'Type A'
        WHEN p.ItemType = 'B' THEN 'Type B'
        WHEN LEFT(p.MaskedIdentifier, 4) = '0000' THEN 'Special Category'
        ELSE 'Standard Type'
    END AS ItemCategory,

    CASE
        WHEN r.RelationshipType = 'PRIMARY' THEN r.ParentItemId
        ELSE p.ItemId
    END AS ParentItemId,

    p.MaskedIdentifier,
    t.EventReference,
    t.CategoryCode,
    t.LocationCity,
    t.LocationRegion,
    t.CurrencyCode,
    t.RelatedEventReference,
    t.ResponseId,
    t.StatusCode,
    s.StatusDescription,
    t.EventDate,
    t.EventTypeId,
    t.EventTypeDescription,
    t.Description,
    t.Amount,
    t.FeeAmount,
    t.AvailableValue,
    t.CurrentBalance,
    t.PreviousBalance

FROM SampleDb.Transactions AS t

JOIN SampleDb.Items AS p
    ON p.ItemId = t.ItemId

LEFT JOIN SampleDb.StatusCodes AS s
    ON s.StatusCode = t.StatusCode

LEFT JOIN SampleDb.ItemRelationships AS r
    ON r.ChildItemId = p.ItemId

JOIN SampleDb.Entities AS u
    ON u.EntityId = p.EntityId

WHERE 1 = 1
  AND t.EventTypeDescription NOT LIKE '%Temporary%'
  AND t.CategoryCode IS NOT NULL
  AND t.CategoryCode <> 0
  AND p.SystemType = 'EXTERNAL'
  AND u.EntityId = 'SAMPLE_ID';

-- Optional filters for exploration:
-- AND p.MaskedIdentifier = 'XXXX-XXXX'
-- AND t.EventDate >= DATEADD(DAY, -7, CURRENT_TIMESTAMP);
