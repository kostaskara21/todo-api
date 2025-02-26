# Ruby RESTful API for Managing Todos

This is a simple Ruby API that allows users to manage their todos and todo items. It supports user signup, login, and token-based authentication using JWT. Redis is used to blacklist tokens when a user logs out.
This ensures that the token cannot be used again to make requests, even if it is intercepted. Redis is used as an in-memory store for blacklisted tokens.

| Endpoint               | Functionality              |
|------------------------|---------------------------|
| **POST** /signup       | Signup                    |
| **POST** /auth/login   | Login                     |
| **GET** /auth/logout   | Logout                    |
| **GET** /todos         | List all todos and items  |
| **POST** /todos        | Create a new todo         |
| **GET** /todos/:id     | Get a todo                |
| **PUT** /todos/:id     | Update a todo             |
| **DELETE** /todos/:id  | Delete a todo and items   |
| **GET** /todos/:id/items/:iid  | Get a todo item   |
| **POST** /todos/:id/items | Create a new todo item |
| **PUT** /todos/:id/items/:iid  | Update a todo item |
| **DELETE** /todos/:id/items/:iid | Delete a todo item |


## Features
- User authentication with JWT tokens
- CRUD operations for managing todos and todo items
- Token blacklisting with Redis after logout
- Fully tested with RSpec 





## Installation(Follow the steps below to set up the project locally)
```bash
   git clone https://github.com/kostaskara21/todo-api.git
   cd todo-api
   #Install the required Ruby gems:
   bundle install
   #Create the database:
   rails db:create
   #Run the migrations:
   rails db:migrate
   #Start the Rails server:
   rails server
```
The application should now be running on http://localhost:3000.

# Endpoints

## Signup
To sign up a new user, run the following command:

```bash
http :3000/signup name=ash email=ash@email.com password=foobar password_confirmation=foobar
```

This will return a JWT token that you will use to authenticate in subsequent requests.

---

## Login
To log in and get the **JWT token**, use:

```bash
http :3000/auth/login email=ash@email.com password=foobar
```

---

## Logout
To log out and blacklist the JWT token using **Redis**, run:

```bash
http :3000/auth/logout \ Authorization:'<your_jwt_token>'
```

After logout, the token will be blacklisted in Redis and cannot be used again.

---


## Todos

### Get all todos
```bash
http :3000/todos \ Authorization:'<your_jwt_token>'
```

### Create a new todo
```bash
http POST :3000/todos title="Mozart" created_by=1 \ Authorization:'<your_jwt_token>'
```

### Get a specific todo
```bash
http :3000/todos/1 Authorization:'<your_jwt_token>'
```

### Update a specific todo
```bash
http PUT :3000/todos/1 title="Beethoven" \ Authorization:'<your_jwt_token>'
```

### Delete a specific todo
```bash
http DELETE :3000/todos/1 \ Authorization:'<your_jwt_token>'
```

---

## Todo Items

### Get all items for a specific todo
```bash
http :3000/todos/2/items \ Authorization:'<your_jwt_token>'
```

### Create a new item for a todo
```bash
http POST :3000/todos/2/items name="Listen to 5th Symphony" done=false \ Authorization:'<your_jwt_token>'
```

### Update a specific todo item
```bash
http PUT :3000/todos/2/items/1 done=true \ Authorization:'<your_jwt_token>'
```

### Delete a specific todo item
```bash
http DELETE :3000/todos/2/items/1 \ Authorization:'<your_jwt_token>'
```
