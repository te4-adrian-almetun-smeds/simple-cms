# Simple-CMS

## About

A minimalistic headless CMS inspired by WordPress and Strapi.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

* Npm
* Ruby
* Bundler

### Installing

A step by step series of examples that tell you how to get a development env running.

Begin by cloning the repository to you local machine

```console
git clone git@github.com:te4-adrian-almetun-smeds/simple-cms.git
cd simple-cms
```

You will now need to install all the dependencies.

```console
cd bin/frontend && npm install
cd bin/server && bundle install
```

You should now be ready to start up the servers.

```console
frontend: npm run serve
server: rackup
```

The application should now be reachable using the outputted adresses.

## Usage

The backend follows the principles of a RESTful API and is reachable from `localhost.9292/api`
You can access a list of all reachable routes by visiting `localhost:9292/api/endpoints`
