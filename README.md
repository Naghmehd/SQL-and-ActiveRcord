== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

1. How many users are there? 51

  User.count

   ``(0.2ms)  SELECT COUNT(*) FROM "users"
=> 51
``

2. What are the 5 most expensive items?


  Item.order('items.price DESC').limit(5)

``Item Load (0.3ms)  SELECT  "items".* FROM "items"  ORDER BY items.price DESC LIMIT 5
=> [#<Item:0x007f8d7623c9f8
  id: 25,
  title: "Small Cotton Gloves",
  category: "Automotive, Shoes & Beauty",
  description: "Multi-layered modular service-desk",
  price: 9984>,
 #<Item:0x007f8d7623c750
  id: 83,
  title: "Small Wooden Computer",
  category: "Health",
  description: "Re-engineered fault-tolerant adapter",
  price: 9859>,
 #<Item:0x007f8d7623c548
  id: 100,
  title: "Awesome Granite Pants",
  category: "Toys & Books",
  description: "Upgradable 24/7 access",
  price: 9790>,
 #<Item:0x007f8d7623c200
  id: 40,
  title: "Sleek Wooden Hat",
  category: "Music & Baby",
  description: "Quality-focused heuristic info-mediaries",
  price: 9390>,
``

3. What's the cheapest book?
  "Ergonomic Granite Chair"

Item.where(category: 'Books').order('items.price ASC').limit(1)

``Item Load (0.3ms)  SELECT  "items".* FROM "items" WHERE "items"."category" = ?  ORDER BY items.price ASC LIMIT 1  [["category", "Books"]]
=> [#<Item:0x007f8d773d9d78
id: 76,
title: "Ergonomic Granite Chair",
category: "Books",
description: "De-engineered bi-directional portal",
price: 1496>]
``
4. Who lives at "6439 Zetta Hills, Willmouth, WY"? Do they have another address?
  Corrina Little.

  ``4] pry(main)> User.joins(:addresses).where(addresses: {street: '6439 Zetta Hills'}).take
  User Load (0.2ms)  SELECT  "users".* FROM "users" INNER JOIN "addresses" ON "addresses"."user_id" = "users"."id" WHERE "addresses"."street" = ? LIMIT 1  [["street", "6439 Zetta Hills"]]
=> #<User:0x007f8d772194c0
 id: 40,
 first_name: "Corrine",
 last_name: "Little",
 email: "rubie_kovacek@grimes.net">
``
  Addresses for Corrina Little:

  ``Address.where(user_id:40).limit(10)
  Address Load (0.2ms)  SELECT  "addresses".* FROM "addresses" WHERE "addresses"."user_id" = ? LIMIT 10  [["user_id", 40]]
=> [#<Address:0x007f8d73f338f8
  id: 43,
  user_id: 40,
  street: "6439 Zetta Hills",
  city: "Willmouth",
  state: "WY",
  zip: 15029>,
 #<Address:0x007f8d73f33448
  id: 44,
  user_id: 40,
  street: "54369 Wolff Forges",
  city: "Lake Bryon",
  state: "CA",
  zip: 31587>]
``

5. Correct Virginie Mitchell's address to "New York, NY, 10108".

``User.where(first_name: 'Virginie')
  User Load (0.2ms)  SELECT "users".* FROM "users" WHERE "users"."first_name" = ?  [["first_name", "Virginie"]]
=> [#<User:0x007f8d749223c8
  id: 39,
  first_name: "Virginie",
  last_name: "Mitchell",
  email: "daisy.crist@altenwerthmonahan.biz">]
  ``
  ``Address.update(41, :city => "Austin", :state => "TX")
  Address Load (0.2ms)  SELECT  "addresses".* FROM "addresses" WHERE "addresses"."id" = ? LIMIT 1  [["id", 41]]
   (0.1ms)  begin transaction
  SQL (0.9ms)  UPDATE "addresses" SET "city" = ?, "state" = ? WHERE "addresses"."id" = ?  [["city", "Austin"], ["state", "TX"], ["id", 41]]
   (0.6ms)  commit transaction
=> #<Address:0x007f8d77408010
 id: 41,
 user_id: 39,
 street: "12263 Jake Crossing",
 city: "Austin",
 state: "TX",
 zip: 34705>
 ``

 6. How much would it cost to buy one of each tool?

 => 7383

 ``tools = Item.where(category: "Tools")
  Item Load (0.3ms)  SELECT "items".* FROM "items" WHERE "items"."category" = ?  [["category", "Tools"]]
=> [#<Item:0x007f8d74b5f9d8
  id: 32,
  title: "Practical Rubber Shirt",
  category: "Tools",
  description: "De-engineered multimedia info-mediaries",
  price: 1107>,
 #<Item:0x007f8d74b567e8
  id: 80,
  title: "Incredible Plastic Gloves",
  category: "Tools",
  description: "Operative mission-critical emulation",
  price: 5437>,
 #<Item:0x007f8d74b565b8
  id: 87,
  title: "Awesome Plastic Shirt",
  category: "Tools",
  description: "Balanced multimedia paradigm",
  price: 839>]
[2] pry(main)> tools.sum('price')
   (0.2ms)  SELECT SUM("items"."price") FROM "items" WHERE "items"."category" = ?  [["category", "Tools"]]
=> 7383
``

7. How many total items did we sell?

=> 2130

``(0.2ms)  SELECT SUM("orders * quantity") FROM "orders"
=> 2139
``

8. How much was spent on books? 550010

``Order.joins("JOIN items On orders.item_id = items.id").where("items.category = 'Books' ").sum("quantity*price")
or
Order.joins('INNER JOIN items ON orders.item_id = items.id').where(' "items".category = \'Books\' ').sum('items.price * orders.quantity')``


9. Simulate buying an item by inserting a User for yourself and an Order for that User.

id: 52,
first_name: "Abbey",
last_name: "Hendric",
email: "abbey@email.com"

id: 379,
user_id: 52,
item_id: 6,
quantity: 20,

``User.find_or_create_by(first_name: 'Abbey', last_name: 'Hendric',email: 'abbey@email.com')
  User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."first_name" = ? AND "users"."last_name" = ? AND "users"."email" = ? LIMIT 1  [["first_name", "Abbey"], ["last_name", "Hendric"], ["email", "abbey@email.com"]]
   (0.1ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "users" ("first_name", "last_name", "email") VALUES (?, ?, ?)  [["first_name", "Abbey"], ["last_name", "Hendric"], ["email", "abbey@email.com"]]
   (0.7ms)  commit transaction
=> #<User:0x007f8d77669818
 id: 52,
 first_name: "Abbey",
 last_name: "Hendric",
 email: "abbey@email.com">
 ``

 ``Order.find_or_create_by(user_id: 52, item_id: 6, quantity: 20, created_at: Time.now)
  Order Load (0.3ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."user_id" = ? AND "orders"."item_id" = ? AND "orders"."quantity" = ? AND "orders"."created_at" = ? LIMIT 1  [["user_id", 52], ["item_id", 6], ["quantity", 20], ["created_at", "2016-03-29 21:34:03.809610"]]
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "orders" ("user_id", "item_id", "quantity", "created_at") VALUES (?, ?, ?, ?)  [["user_id", 52], ["item_id", 6], ["quantity", 20], ["created_at", "2016-03-29 21:34:03.809610"]]
   (6.6ms)  commit transaction
=> #<Order:0x007f8d77558ff0
 id: 379,
 user_id: 52,
 item_id: 6,
 quantity: 20,
 created_at: Tue, 29 Mar 2016 21:34:03 UTC +00:00>
 ``
------------------------------------------NOTES--------------------------------------

addresses orders users items schema_migrations

items : id|title|category|description|price

addresses : id|user_id|street|city|state|zip

users : id|first_name|last_name|email

orders : id|user_id|item_id|quantity|created_at
