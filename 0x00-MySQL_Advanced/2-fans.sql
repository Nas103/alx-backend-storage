-- Task 2: Rank the origins of bands by the number of non-unique fans
-- The result will display the origin and the total number of fans
-- The query will order the results by the number of fans in descending order

SELECT origin, SUM(nb_fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
