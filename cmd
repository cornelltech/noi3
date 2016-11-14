heroku console | tee heroku.log
puts User.where("created_at > '2016-10-07 08:00:00'").to_json

pg_ctl -D /usr/local/var/postgres/ start