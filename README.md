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

This application is deployed to [Gigalixir](gigalixir.com) using [Distillery](bitwalker/distillery) by following [this guide](https://gigalixir.readthedocs.io/en/latest/modify-app/distillery.html#using-distillery).

The application is automatically deployed to production when the following happens:

1. Update the version number in the [VERSION](./VERSION) file.
2. Merge into the `main` branch.

The application can manually be deployed using `git` with the following procedure.

First, prepare your environment for deployment. The following only needs to be done once on your current environment.

1. Add a header to signal to Gigalixir that this should be a hot code deployment.

```
git config --worktree --add http.extraheader "GIGALIXIR-HOT: true" # enables hot-code reloading
```

2. Install the command line interface. For MacOS, you can install via the following:

```
brew tap gigalixir/brew && brew install gigalixir
```

For other environments, refer to [this section in the Guide](https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html#install-the-command-line-interface)

3. Log in to the command line.

```
gigalixir login
```

4. Add the git remote with your account credentials.

```
gigalixir git:remote tatsu
```

5. Rename the remote to point to the environment.

```
git remote rename gigalixir production
```

6. Add your SSH public key so you can run migrations if necessary.

```
gigalixir account:ssh_keys:add "$(cat ~/.ssh/id_rsa.pub)"
```

Now, you are ready to deply via git!

```
git push production
```

You can run migrations with the following:

```
gigalixir ps:migrate
```

The production application lives at https://lebotski.gigalixirapp.com.

## CONTRIBUTING

1. Clone the repository `git clone https://github.com/jwright/lebotski`
1. Create a feature branch `git checkout -b my-awesome-feature`
1. Codez!
1. Commit your changes (small commits please)
1. Push your new branch `git push origin my-awesome-feature`
1. Create a pull request `gh pr create -b jwright:main -h jwright:my-awesome-feature`
