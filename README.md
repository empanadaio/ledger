# Ledger

A sample [Elixir Phoenix](https://www.phoenixframework.org/) + [Commanded app](https://github.com/commanded/commanded) app to showcase zero-downtime upgrades in a clustered setup.

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
