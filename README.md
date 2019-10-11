# SRE Toolbox 
Docker image containing various utility tools like ab (apache bench), siege, curl, wget, ping, netcat, nslookup,host, perf, psql, mysql etc.. The image is typically used for running a "_one-off_" container in Kubernetes for debugging purposes.

## Usage
```bash
kubectl run --rm utils -it --generator=run-pod/v1 --image nicolaihald/toolbox bash
```

### PostgreSQL Client 
```bash
# Example 1:
psql -h hostname -U test -d test
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
