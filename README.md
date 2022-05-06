# README

* Ruby version ruby-2.6.5
* Rails version 6.0.0.rc1

* Configuration
  - `bunlde i`
  - remove .example from config/secrets.example.yml and config/database.example.yml

* Database creation
  - `rails db:setup`

* How to run the test suite
  - `rails test`

* Running tasks
  - `whenever -w`

* Stopping tasks
  - `crontab -r`

* Running server
  - `rails s -p 3001`

* Accessing 'front end'
  - `Active admin used as a simple front end allowing for detailed access to book database, as well as creation/edit/ delete functionality`
  - `localted at http://localhost:3001/admin`

* Example requests:
* GET http://localhost:3001/book_stock_management/index
* GET http://localhost:3001/book_stock_management/show?isbn=123-446-789-122-1
* POST http://localhost:3001/book_stock_management/create
  ```
  params = {
    "title": "a titlddde",
    "author": "JP COOdddL GUY",
    "isbn": "123-446-789-122-1",
    "stock": 0
  }
  ```
* PATCH http://localhost:3001/book_stock_management/update?isbn=123-446-789-122-1
  ```
  params = {
    "stock": 0
  }
  ```
* DELETE http://localhost:3001/book_stock_management/destroy?isbn=123-446-789-122-1