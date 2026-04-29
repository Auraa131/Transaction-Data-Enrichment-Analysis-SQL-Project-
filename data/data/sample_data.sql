CREATE TABLE transactions (
    TransactionId INT,
    EntityId VARCHAR(50),
    Amount DECIMAL(10,2),
    EventDate DATE
);

INSERT INTO transactions VALUES
(1, 'E1', 25.50, '2024-01-01'),
(2, 'E1', 300.00, '2024-01-02'),
(3, 'E2', 15.00, '2024-01-03'),
(4, 'E2', 1200.00, '2024-01-04');
