# Chate

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Define .env settings and `source .env`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Docker
```
docker-compose run --rm app mix ecto.create
docker-compose run --rm app mix ecto.migrate
docker-compose run --rm app mix run priv/repo/seeds.exs
```

Build app only
```
docker-compose up -d --no-deps --build app
```