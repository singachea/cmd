SELECT * 
FROM processes 
WHERE pid in (${pid})
ORDER BY pid;