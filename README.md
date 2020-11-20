# Ledger

```sh
# start nginx
script/run_nginx.sh

# start server 'a'
PORT=4001 script/server a

# start server 'b'
PORT=4002 script/server b

# start pinging b
script/pinger http://localhost:4002
```
