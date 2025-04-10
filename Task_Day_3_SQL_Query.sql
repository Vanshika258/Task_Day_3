SELECT productLine, SUM(quantityOrdered * priceEach) AS totalSales
FROM orderdetails
JOIN products USING (productCode)
GROUP BY productLine
ORDER BY totalSales DESC;
SELECT customerNumber, customerName, SUM(quantityOrdered * priceEach) AS totalSpent
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP BY customerNumber
ORDER BY totalSpent DESC
LIMIT 5;
SELECT orderNumber, orderDate, requiredDate, shippedDate
FROM orders
WHERE shippedDate > requiredDate
ORDER BY shippedDate;
SELECT c.customerName, o.orderNumber, p.amount, p.paymentDate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN payments p ON c.customerNumber = p.customerNumber;
SELECT c.customerName
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL;
SELECT p.productName
FROM orderdetails od
RIGHT JOIN products p ON od.productCode = p.productCode
WHERE od.orderNumber IS NULL;
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS orderTotal
FROM orderdetails
GROUP BY orderNumber
HAVING orderTotal > (
  SELECT AVG(quantityOrdered * priceEach)
  FROM orderdetails
);
SELECT e.employeeNumber, e.firstName, e.lastName, COUNT(o.orderNumber) AS totalOrders
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber
ORDER BY totalOrders DESC
LIMIT 5;
SELECT customerName, AVG(amount) AS avgPayment
FROM customers
JOIN payments USING (customerNumber)
GROUP BY customerName
ORDER BY avgPayment DESC;
SELECT productName, SUM(quantityOrdered) AS totalQuantity
FROM orderdetails
JOIN products USING (productCode)
GROUP BY productName
ORDER BY totalQuantity DESC
LIMIT 10;
SELECT DATE_FORMAT(orderDate, '%Y-%m') AS month, 
       COUNT(orderNumber) AS totalOrders,
       SUM(quantityOrdered * priceEach) AS revenue
FROM orders
JOIN orderdetails USING (orderNumber)
GROUP BY month
ORDER BY month;
SELECT country, SUM(quantityOrdered * priceEach) AS revenue
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP BY country
ORDER BY revenue DESC
LIMIT 5;