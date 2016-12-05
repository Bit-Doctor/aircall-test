# [Aircall.io](https://aircall.io) - Backend technical test

The purpose of the test is to reproduce one of our typical use case on the backend part of Aircall: __call forwarding__.

The story is the following:

- Jane (CEO), Peter (CTO) and Luke (COO) are in the same company.
- The company has 3 different phone numbers: Main Office, Sales number and Support number.
- The company is using Aircall in order to manage its calls! Currently they are using two features of Aircall: call forwarding and call history.
- Every user is connected to at least one Aircall App.

It's 9AM in the office and first calls are coming in!
## Setup

You will need to create a `dev.env` and a `prod.env`.

The available var are:
```
# Required
PLIVO_ID=
PLIVO_TOKEN=
# Required in prod.env
SECRET_KEY_BASE=
```

## How to run

1. **Install docker and docker-compose: [docker.com](https://www.docker.com/products/overview)**

2. **Run the app:**

  ```
  docker-compose up --build -d
  ```
3. **Setup the databade**

  ```
  docker-compose run --rm web rails db:setup
  ```

3. **You can now see the app [live](http://localhost:8000)**

## How to deploy

1. **You will need docker-machine: [docker.com](https://www.docker.com/products/overview)**

2. **Create a ec2 instance with docker**

  ```
  docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key *******  aircall
  ```

3. **Connect docker to your new instance**

  ```
  eval $(docker-machine env aircall)
  ```

4. **Build and run**

  ```
  docker-compose -f docker-compose.prod.yml up --build -d
  docker-compose -f docker-compose.prod.yml run --rm web rails assets:precompile
  docker-compose -f docker-compose.prod.yml run --rm web rails db:setup
  ```

5. **You may need to add port `80` to your VPC**
