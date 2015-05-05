# The conference-app

## Status

[![Build Status](https://travis-ci.org/smidig/conference-app.svg?branch=2015)](https://travis-ci.org/smidig/conference-app)

## Development setup

### Development environment
* Ruby: ruby-1.9.3-p362
* Rails: rails-3.2.13

### Ruby Version Manager (RVM)
We expect all developers to use rvm to handle their ruby version, rails and gems. Check out
[https://rvm.io](https://rvm.io) for all the details.

#### Installation of rvm
The easy way to set up rvm with correct ruby and rails:

    $ \curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled # Or, --ruby=1.9.3

#### Create a gemset for smidig
It is recommended to have a separate gemset for each ruby project.  To create a new gemset for *smidig* use the
following commands:

    $ rvm use 1.9.3
    $ $ rvm gemset create smidig
    $ rvm gemset use smidig

After creating the gemset you can quickly select the correct ruby and gemset with the following command:

    $ rvm use 1.9.3@smidig

#### Known issues

Some developers may experience problems with dependencies required by rvm, rails or ruby.

*Ex: "cannot load such file -- openssl"*
Read more: [https://rvm.io/packages/openssl](https://rvm.io/packages/openssl)

Solution:

    $ rvm get head
    $ rvm pkg remove
    $ rvm requirements run (sørg for å fikse alt du mangler!!)
    $ rvm reinstall 1.9.3


## Getting Started

### Checkout the project from github:

Start in the folder where you want to checkout the code to. Clone the project from GitHub:

    $ git clone git@github.com:smidig/conference-app.git

### Initialize you local environment
    
    $ bundle install 
    $ rake db:migrate
    $ rake db:seed
    

#### Protip! 
If you don't want to install a postgres locally you can specify bundle install without production requirements:

    $ bundle install --without production

### Server
You can start the server with the following command:

    $ rails server

The server should then be available at [http://localhost:3000](http://localhost:3000)

### Console
The console command lets you interact with your Rails application from the command line. On the underside, rails console
uses IRB, so if you’ve ever used it, you’ll be right at home. This is useful for testing out quick ideas with code and
changing data server-side without touching the website.

    $ rails console


### Testing
We use RSPEC to do Behaviour-Driven Development (BDD), a fun way to perform Test-Driven Development.

Run an indivdual spec:

    $ rspec spec/controllers/users_controller_spec.rb

#### Forever running tests
To further improve our development speed we have set up *guard*,
[github.com/guard/guard](https://github.com/guard/guard)  (with Growl/Libnotify/Notifu for notifications) and
(guard-rspec plugin)[https://github.com/guard/guard-rspec]. RSpec guard allows us to automatically launch specs when
files are modified.

To start guard:
    $ guard


## Git workflow
We have chosen to have a *stable master* approach. This means that all new developments must be done in a feature
branch, and be merged back to master when they are complete. This means that the master branch is always safe to deploy
from or to create new branches off.

### Start working on new feature
Create a new branch (assuming you are on master branch):

    $ git pull
    $ git checkout -b "feature/some_cool_new_functionality"

### Add/commit
    $ git status
    $ git add .
    $ git commit -m "What a is in this commit"

### Push branch to remote origin (github)

    $ git push origin "name of branch"

### Merge feature back to master
To merge a feature back to master you have multiple options

1.  Push branch to github and make a pull-request on githu. The main benefit of this approach is that we get code review
    with an easy way to inspect / comment / discuss the code beeing merged back to master.

2.  Merge locally:

How to merge locally:

    $ git checkout feature
    $ git fetch origin
    $ git merge master
    (resolve eventuelle merge conlicts)
    $ git checkout master
    $ git merge feature
    $ git push origin master


## Heroku

Start by installing heroku toolbelt: https://toolbelt.herokuapp.com/

We have a test version and several production verions over at heroku. To add heroku remotes:

    git remote add testsmidig git@heroku.com:testsmidig.git
    git remote add smidig2013 git@heroku.com:smidig2013.git
    git remote add smidig2014 git@heroku.com:smidig2014.git
    git remote add smidig2015 git@heroku.com:smidig2015.git

Then you can push to them with the following command (e.g. testsmidig):

    git push testsmidig master

If you change the database you typically have to run migration:

    heroku run rake db:migrate --app testsmidig
    
    
### Deployment links

Any heroku site is available on instancename.herokuapp.com. We also have some shortcuts - [test.smidig.no](http://test.smidig.no)
points to [testsmidig.herokuapp.com](http://testsmidig.herokuapp.com). We also point YEAR.smidig.no to smidigYEAR.herokuapp.com.

### Heroku/Github integration

We have heroku/github integration enabled for several instances.

The latest production site (current year) is connected to master branch. Autodeployment is turned _off_ so you have to
login to heroku and hit the deploy button.

The working branch for the current year is connected to the test.smidig.no isntance. This is also connected to Travis-CI.
Any pushes to this branch will start a Travis-CI build - and if/when that turns green - heroku will automatically deploy
to test.smidig.no.

Note that heroku deployment does not run db migration - so if the db has changed then you will need to run the following when
deployment is complete:

    heroku run rake db:migrate

## Issue tracker

We use Trello.com as [our kanban board](https://trello.com/board/smidig-app-2013/515daaeba00d423573004a20) to manage our user stories.

For bugs and feature request we use the GitHub issue tracker. 
