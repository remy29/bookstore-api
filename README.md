# README

* Ruby version ruby-2.6.5
* Rails version 6.0.0.rc1
* mysql2 db

* Configuration
  - `bundle i`
  - remove .example from config/secrets.example.yml and config/database.example.yml

* Database setup
  - `rails db:setup`

* How to run the test suite
  - `rails test`

* Running tasks
  - `whenever --update-crontab --set environment='development'`

* Stopping tasks
  - `crontab -r`

* Running server
  - `rails s -p 3001`

* Accessing 'front end'
  - `Active admin used as a simple front end allowing for detailed access to book database`
  - `located at http://localhost:3001/admin`
  - `login credentials are found in secrets.yml. Set username to value in bookstore_api_key and password to value in bookstore_secret_key`

* Example requests:
* GET http://localhost:3001/book_stock_management/index
* GET http://localhost:3001/book_stock_management/show
  ``` JSON
  params = {
    "store": "Another bookstore?!",
    "status": "out_of_stock"
  }
  ```
* POST http://localhost:3001/book_stock_management/create
  ``` JSON
  params = {
    "title": "title1",
    "author": "author1",
    "isbn": "123-446-789-122-1",
    "stores": "[{\"name\":\"Books! Books? Books!\",\"stock\":5},{\"name\":\"Big John's Big Books\",\"stock\":1}]"
  }
  ```
* PATCH http://localhost:3001/book_stock_management/update
  ``` JSON
  params = {
    "store": "Books! Books? Books!",
    "isbn": "123-446-789-122-1",
    "stock": 2
  }
  ```
* DELETE http://localhost:3001/book_stock_management/destroy?isbn=123-446-789-122-1

* Authorization handled by HTTP Basic Auth. Refer to secrets.yml for values. Set username to value in bookstore_api_key and password to value in bookstore_secret_key