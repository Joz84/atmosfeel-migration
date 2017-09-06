## Get ready

### Software dependencies

* Ruby >= 2.1
  * You should consider installing it with [rbenv](https://github.com/sstephenson/rbenv)
* Imagemagick
* Redis
* Elasticsearch
* MySQL

### Install Ruby gems with Bundler

* `gem install bundler`
* `rbenv rehash` only if you are using rbenv
* `bundle` 

### Configuration files

First you have to execute `bin/setup` then read and edit if necessary:

* `config/database.yml`
* `config/payplug_credentials.yml`
* `config/paypal.yml`
* `config/secrets.yml`
* `config/paypal_urls.yml.erb`
* `config/payplug_urls.yml.erb`
* `.env`

In case you have got an error related to the migrations, run manually:

* `rake db:setup`
* `rake db:fixtures:load`

**Do that only when `config/database.yml` is fixed**

#### PayPlug configuration

run `rake payplug:config` generates a config file related to the actual environment using PayPlug API

### ENV vars

Located in `.env`

* `ADMIN_EMAIL` email used for the first created admin
* `ADMIN_PWD` password used for the first created admin
* `LOCAL_HOST` is where the server is hosted 

## Run locally

`foreman start`

## MailCatcher

In development email are readable [here](http://localhost:1080) if Mailcatcher is installed and running (require Ruby >= 2.2.2)

```
gem install 'mailcatcher'
```

## Deploy on the server

Using [Capistrano](http://capistranorb.com/)

### Useful commands

* cap production setup
  * prepare the server to receive the application
  * you have to run it just once
* cap production deploy
  * deploy the application from master branch
* cap production rails:console
  * gives access to a rails console on the production server
* cap production logs:rails
  * tails log from the rails application
* cap production logs:nginx
  * tails log from nginx

## Elasticsearch related commands 

```
# Import data from your model (pass name as CLASS environment variable).
rake environment elasticsearch:import:model CLASS='Opus'
    
# Force rebuilding the index (delete and create):
rake environment elasticsearch:import:model CLASS='Opus' FORCE=y
```