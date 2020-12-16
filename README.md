# Ledger

```sh
# start nginx
script/run_nginx.sh

# start the blue server
PORT=4001 script/server blue

# start the green server
PORT=4002 script/server green

# start pinging nginx
script/pinger http://localhost:4000
```
