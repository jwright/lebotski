Lebotski
========

> Really ties Slack together.

## DESCRIPTION

Lebotski allows you to have a bit of fun in the business of Slack. It's very interesting man.

Lebotski allows a user to find a bowling alley, a dispensary, or a cocktail around you.

## INSTALLATION

* Install the depedencies

```
mix deps.get
```

* Create the database (if necessary)

You may need to adjust the database connection string in [config/dev.exs](config/dev.exs).

```
mix ecto.create
```

* Prepare environment variables

There are several environment variables that are necessary to run the application locally. We are using [direnv](https://direnv.net/) to handle the environment variables outside the application.

To set this up initially, you will need to install `direnv`.

```
brew install direnv
```

Then you need to add the following line at the end of your `~/.zshrc` file (or whatever is appropriate for your shell).

```
eval "$(direnv hook zsh)"
```

The necessary environment variables are stored in [`.envrc.example`](.envrc.example) and so you should copy this file as `.envrc`.

```
cp .envrc.example .envrc
```

Once it is copied, add the values to the `.envrc` file. Reach out to a developer to receive these values. You can then allow the new environment variables to be read in.

```
direnv allow
```

* Start the Phoenix server

```
mix phx.server
```

## TESTING

You can run the tasks with the standard mix command:

```
mix test
```

## DEPLOYMENT

This application is deployed to [Fly](fly.io) using Docker by following [this guide](https://fly.io/docs/getting-started/elixir/).

The application can manually be deployed using the [Fly CLI](https://fly.io/docs/getting-started/installing-flyctl/) with the following procedure.

First, prepare your environment for deployment. The following only needs to be done once on your current environment.

1. Install the command line interface. For MacOS, you can install via the following:

```
brew install flyctl
```

For other environments, refer to [this Guide](https://fly.io/docs/getting-started/installing-flyctl/)

2. Log in to the command line.

```
flyctl auth login
```

Now, you are ready to deply via fly CLI!

```
flyctl deploy
```

The production application lives at https://lebotski.fly.dev/.

## CONTRIBUTING

1. Clone the repository `git clone https://github.com/jwright/lebotski`
1. Create a feature branch `git checkout -b my-awesome-feature`
1. Codez!
1. Commit your changes (small commits please)
1. Push your new branch `git push origin my-awesome-feature`
1. Create a pull request `gh pr create -b jwright:main -h jwright:my-awesome-feature`
