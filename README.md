# Organizador de tareas

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Simple Ruby on Rails Organizer application.

- User login and register
- Dashboard with all task created or assigned
- Task creation, editing and state(start, finish)

### Installation

Requires [RoR](https://rubyonrails.org/) and [MongoDB](https://www.mongodb.com/es) to run.

Clone the repo
Install dependencies.

```sh
$ git clone https://github.com/RubDevs/Organizador.git
$ cd Organizador
$ bundle install
```

In order to see it in action you must run MongoDB 4.2.7 server

Now everything is ready, just run the server.

```
$ rails server
```

Demo  
![login](/assets/logintasker.png)  
![dashboard](/assets/dashboardtasker.png)  
![create](/assets/createtask.png)

## License

MIT

Proyecto del curso de Ruby on rails de platzi.

Setup:

- Ruby version 2.7.1

- Rails version 6.0.3.2

- Database on Postgres
- [Deployed at](https://rubdevsorganizador.herokuapp.com/)
