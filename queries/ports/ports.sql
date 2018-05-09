SELECT lp.pid, lp.port, lp.address, p.name, p.path
FROM listening_ports lp 
    INNER JOIN processes p
ON lp.pid = p.pid
WHERE lp.port > 0
ORDER BY lp.port;