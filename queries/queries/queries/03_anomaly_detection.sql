SELECT *
FROM enriched_transactions
WHERE Amount > (
    SELECT AVG(Amount) * 3
    FROM enriched_transactions
);
