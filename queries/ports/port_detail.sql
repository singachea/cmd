SELECT * 
FROM listening_ports lp 
    INNER JOIN processes p
ON lp.pid = p.pid
WHERE 
    lp.port = ${port}
    AND lp.port > 0
ORDER BY lp.port;