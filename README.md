# Toolbox 
This docker image contains various utility tools like ab (apache bench), siege, curl, wget, ping, netcat, nslookup, host, perf, psql, mysql etc.. The image is typically used for running a "_one-off_" pod/container in kubernetes for debugging purposes.

## Usage
```bash
kubectl run --rm utils -it --generator=run-pod/v1 --image nicolaihald/toolbox bash
```

### PostgreSQL Client 
```bash
# Example 1:
psql -h hostname -U test -d test

# Example 2.1 (pgbench): 
psql -U pguser -c "create database pxdemo;"
pgbench  -U pguser -i -s 50 pxdemo; 

# Example 2.2: 
#   Typically used in a scenario when testing failover: 
while true; do
    if ! /usr/bin/pg_isready -h localhost -U pguser &>/dev/null; then 
        echo '  --- SERVER DOWN !!! ---';
    fi;
    echo 'up';
    sleep 1;
done;

# Example 2.3: 
#   Typically used in a scenario when testing failover (along with #2):
export PGPASSWORD=password
while true; do
    psql -h localhost pxdemo -U pguser -w -c "SELECT count(*) FROM pgbench_accounts;"
    sleep 3;
done;
```

### Apache Bench
```bash
# Example 1:
ab -k -n 20000 -c 350 -H "Accept-Encoding: gzip, deflate" example.com

# -n:  Number of requests to perform.
#
# -c:  Concurrency. Number of multiple requests to make at a time.
#
# -k:  Use HTTP KeepAlive. Sends the KeepAlive header, which asks the web server to not shut down the connection after each request is done, but to instead keep reusing it.
#
# -H : Add Arbitrary header line, eg. 'Accept-Encoding: gzip'. Inserted after all normal header lines. (repeatable) 
# Adds an extra header "Accept-Encoding: gzip, deflate" to further simulte a realistic request.
# The "mod_deflate" is almost always used to compress the text/html output 25%-75% - the effects of which should not be dismissed due to it's impact on the overall performance of the web server (i.e., can transfer 2x the data in the same amount of time, etc). 
```

