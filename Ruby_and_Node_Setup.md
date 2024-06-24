# A simple setup for Ruby and Node.js novices

If you don't already have [Ruby](https://www.ruby-lang.org/en/) and
[Node.js](https://nodejs.org/en/) development environments these instructions
should get you started.

All of the following instructions should be performed from the command prompt. If you are not comfortable using the command prompt you might be in the wrong place.

## Install support for the correct version of Ruby

Ruby is a popular scripting language

The documentation tools depend on the specific version of Ruby listed
int the file `.ruby-version`. The easiest way to make sure you have the correct
version is to use a Ruby environment manger. We will use [rbenv](https://github.com/rbenv/rbenv).

1. On a Mac using [Homebrew](http://brew.sh/) run the following commands
```shell
brew install rbenv
echo 'eval "$(rbenv init -)"' >>  ~/.bashrc
eval "$(rbenv init -)"
```
2. On Linux you may find `rbenv` can be installed via your package management tool.
3. If you are not able to follow the suggestions above then follow [these](https://github.com/rbenv/rbenv#basic-github-checkout) instructions.

Once rbenv is installed you can install the specific version of Ruby needed
by the Flight Manual toolchain ad follows.

Make sure you have the Atom Flight Manual repo cloned onto your local machine
and _*cd into the repo root directory*_.

Display the contents of the file `.ruby-version`.
For these examples we'll assume it contains `2.2.3`.

Run the following commands to install and use Ruby

```sh
rbenv install 2.2.3
rbenv local 2.2.3
rbenv version
```

and you should see `2.2.3`. If you are using the Bash shell you can just run

```shell
rbenv install $(cat .ruby-version)
reenv local (cat .ruby-version)
rbenv version
```
and it will look up the correct Ruby version for you.

### Installing Additional ruby packages.

Run

```sh
gem install bundler

```

Now run the  command `script/bootstrap`.
You will probably be prompted to install various packages. For instance.

```sh
gem install colorize -v '0.8.1'
gem install pry -v '0.10.4'
gem install html-pipeline -v '2.2.4'
```

After installing each package you will need to run `script/bootstrap` again

## Install Node.js

Node is an engine to run Javascript programs. The current production version
will work with the Flight Manual toolchain.

You can install a modern version of Node via your [package manager](https://nodejs.org/en/download/package-manager/).
If you don't have access to a package manager
then use one of the pre-built [installers](https://nodejs.org/en/download/)

\#TODO Double Check that npm is installed.

Alternatively you  can install a Node environment manager from the
[nvm](https://github.com/creationix/nvm) repo.
Instructions are provided in the nvm README

Once this is complete you can continue the instructions
in the Flight Manual README.md file by running the `script/bootstrap` programs
