# README

This is a REST API for managing customer data for a small shop. It is designed to serve as the backend for a CRM interface.
Assumptions:


## System Dependencies

To run this project, you need to have the following dependencies installed:

- **Ruby 3.1.2**: Ensure you have the correct Ruby version installed. You can use a version manager like `rbenv` or `rvm` to manage Ruby versions.
- **Bundler**: Install it by running `gem install bundler`.
- **PostgreSQL**: The API uses PostgreSQL as the database.

## Configuration

### 1. Clone the repository:
```bash
git clone https://github.com/yourusername/crm-service-api.git
cd crm-service-api
bundle install
```

### 2. Add the key files:
Ask for the `key` files from the project owner and place it in `config/credentials/development.key` and `config/credentials/test.key`.

Or create your own by running:
```bash
rails credentials:edit --environment development
rails credentials:edit --environment test
```
The `example.yml` file in the `config/credentials` directory shows the structure of the credentials file.

### 3. Create the database:
```bash
rails db:create db:migrate db:seed
```

## Running the test suite
```bash
bundle exec rspec
```

Check the coverage by opening the report in your browser.
- OSX terminal: `open coverage/index.html`
- Linux terminal: `xdg-open coverage/index.html`


## Running the application
```bash
bundle exec rails s
```
Use the Postman collection to test the API endpoints.

## API documentation

See the postman collection [here](https://api.postman.com/collections/412117-b55f8a7e-7325-49b0-8fc3-1a8f48925ae2?access_key=PMAT-01J5NTX560CVA1X0CCF949FMB5) or import it using the link below:

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://app.getpostman.com/run-collection/412117-b55f8a7e-7325-49b0-8fc3-1a8f48925ae2?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D412117-b55f8a7e-7325-49b0-8fc3-1a8f48925ae2%26entityType%3Dcollection%26workspaceId%3Dd5483b05-db6a-4820-bd11-a8b4e172f989)


## Deployment instructions
It is configured to automatically deploy to Heroku once the tests have passed on main branch. You will need to set the following secrets in your github repository:
- `HEROKU_API_KEY`: The API key for your Heroku account.
- `HEROKU_APP_NAME`: The name of the Heroku app you want to deploy to.
- `HEROKU_EMAIL`: The email address associated with your Heroku account.

In heroku, you will need to set the following environment variables:
- `RAILS_MASTER_KEY`: The contents of the `config/credentials/production.key` file. If you don't have this file, you can create it by running `EDITOR=vim rails credentials:edit --environment production`. You'll need to add the secrets as they are in the `config/credentials/example.yml` file.