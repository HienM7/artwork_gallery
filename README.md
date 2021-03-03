# ROR Artwork Gallery

An artwork gallery website written in Ruby on Rails.

The live demo version is available at [artrails.herokuapp.com](https://artrails.herokuapp.com/) (it may take a moment for the page to load due to Heroku's app sleeping policy).


## Installation (for Ubuntu 18.04+)

*(Full instructions can be found on [TOP website](https://www.theodinproject.com/courses/ruby-on-rails/lessons/your-first-rails-application-ruby-on-rails))*

1. Install packages/libraries
    ```
    sudo apt update

    sudo apt upgrade

    sudo apt install gcc make libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev
    ```
2. Install Ruby

    Install rbenv
    ```
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv

    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    exit
    ```
    ```
    mkdir -p "$(rbenv root)"/plugins

    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

    rbenv -v
    ```
    Install Ruby
    ```
    rbenv install 2.7.2 --verbose

    rbenv global 2.7.2

    ruby -v
    ```
3. Install Rails
    ```
    gem install rails

    rails -v
    ```
4. Install Yarn
    ```
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt update && sudo apt install yarn

    yarn --version
    ```
5. Install PostgreSQL and create a database ([Detailed instructions here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04))
    ```
    sudo apt update

    sudo apt install postgresql postgresql-contrib libpq-dev
    ```
6. Set config environment variables **(or use .env instead)**
    ```
    export POSTGRES_USER="<your pg username>"

    export POSTGRES_PASSWORD="<your pg password>"

    export POSTGRES_DB="<your pg database>"

    export RAILS_ENV="development"
    ```
6. Move to your directory of choice and clone this project
    ```
    git clone git@github.com:HienM7/artwork_gallery.git
    ```
7. Run bundle and rake
    ```
    bundle install

    rake db:setup

    rake db:migrate

    rake db:seed
    ```
8. If you make it here, you should have the website up and running locally when entering this in your terminal:
    ```
    rails s
    ```

## Features
