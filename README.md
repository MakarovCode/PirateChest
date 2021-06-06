# PirateChest
Ruby on Rails application for managing accounts and passwords encrypted via SSH keys.

# DEMO
[PirateChest](https://piratechest.geekoi.com) - Test the web app

# TECHNOLOGIES USED AND CHALLENGES
* SSH Keys Encryption / Decryption
* Ruby;
    * Version 2.7.1;
* Rails;
    * Version 6.1;
* AngularJS;
    * Legacy;
* PostgreSQL;
    * 13;
* Serket
    * I made some changes in the Serket gem in order to work with it easier.
    * Every time a user created a password (login and pass) this values are encrypted via SSH Keys and saved into the database, then they are decrypted using the when the user fetch them.

# SOME SCREENSHOTS
![screen1](https://piratechest.geekoi.com/piratechest1.png)

# HOW TO INSTALL

```ruby
# 1. Clone the repo

git clone https://github.com/MakarovCode/PirateChest.git

# 2. Run bundle

bundle

# 3. Run the DB

rails db:create db:migrate db:seed

# Type localhost:3000

# DO NOT FORGET TO install node in order to test real time functionalities
```

# DISCLAIMER
I DO NOT give support to this project any more, you are free to use the code in anyway you want, is free to use, but this web application as it is may present Bugs and Errors.

I developed this project several years ago, I kept a DEMO but is not getting supported, some libraries and dependencies maybe deprecated, the only technologies I updated were Ruby, Rails and PostgreSQL.
