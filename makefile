.PHONY: db

srv:
	mix phx.server

isrv:
	iex -S mix phx.server

db:
	pg_ctl start -l db.log