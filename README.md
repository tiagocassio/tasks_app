### Initial Setup

##### Setup the required Environment Variables

Install all Rails dependencies. Inside the project root run:

```shell
bundle install
```

##### Setup the Environment Variables

Create a new file named `.env.development.local`

```shell
cp .env .env.development.local
cp .env .env.test.local
```

##### Change env variables
```shell
RAILS_ENV=YOUR ENV (development, staging or test)
```

##### Setup Database

```shell
rails db:{drop,create,migrate}
```

##### Run seed data

```shell
rails seed:migrate
```

##### Run local server (with -b to allow external access, see at: http://localhost:3000)

```shell
rails s -b 0.0.0.0
```

##### Run RSpec tests

```shell
rspec
```
