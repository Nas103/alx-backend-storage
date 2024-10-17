-- List Glam Rock bands by longevity

SELECT band_name, 2022 - formed AS lifespan
FROM bands
WHERE main_style = 'Glam Rock'
ORDER BY lifespan DESC;
