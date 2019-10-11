## Example
```bash
kubectl run --rm utils -it --generator=run-pod/v1 --image nicolaihald/toolbox bash
```

### PostgreSQL Client 
```bash
# You will be seeing a bash prompt
psql -h hostname -U test -d test
```

### Apache Bench
```bash
...bash
ab -k -n 20000 -c 350 example.com

# By issuing the command above, you will be hitting http://example.com/ with 350 simultaneous connections 
# until 20 thousand requests are met. It will be done using the keep alive header.
 
ab -n 1000 -c 10 -k -H "Accept-Encoding: gzip, deflate" http://www.example.com/

# -n 1000 is the number of requests to make.
# -c 10 tells AB to do 10 requests at a time, instead of 1 request at a time, to better simulate concurrent visitors (vs. sequential visitors).
# -k sends the KeepAlive header, which asks the web server to not shut down the connection after each request is done, but to instead keep reusing it.

# -H : Adds an extra header "Accept-Encoding: gzip, deflate" to further simulte a realistic request.
# The "mod_deflate" is almost always used to compress the text/html output 25%-75% - the effects of which should not be dismissed due to it's impact on the overall performance of the web server (i.e., can transfer 2x the data in the same amount of time, etc). 
```
