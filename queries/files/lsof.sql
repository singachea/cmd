WITH opened_files AS 
    (SELECT pid, count(*) AS opened_files 
        FROM process_open_files 
        GROUP BY pid 
        ORDER BY count(*) DESC 
        LIMIT 15)
SELECT DISTINCT of.pid, of.opened_files, p.name, p.path 
FROM processes p 
    INNER JOIN opened_files of
    ON p.pid = of.pid
ORDER BY of.opened_files DESC;

