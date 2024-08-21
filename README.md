# README

This is a REST API for managing customer data for a small shop. It is designed to serve as the backend for a CRM interface.

- [I - System Dependencies](#i---system-dependencies)
- [II - Setup instructions](#ii---setup-instructions)
- [III - API documentation](#iii---api-documentation)
- [IV - Deployment instructions](#iv---deployment-instructions)


## I - System Dependencies
To run this project, you need to have the following dependencies installed:

- **Ruby 3.1.2**: Ensure you have the correct Ruby version installed. You can use a version manager like `rbenv` or `rvm` to manage Ruby versions.
- **Bundler**: Install it by running `gem install bundler`.
- **PostgreSQL**: The API uses PostgreSQL as the database.
- **Docker and Docker Compose**: If you prefer to use Docker to run the project.
- **Amazon S3**: The project uses Amazon S3 for file storage in production.

Or you can use the Docker setup to run the project, which will install all the dependencies for you.
You'll need to have Docker and Docker Compose installed on your machine.

## II - Setup instructions
You can run the project locally or use Docker to run it, but you'll need to set up the credentials file first.

Ask for the `key` files from the project owner and place it in `config/credentials/development.key` and `config/credentials/test.key`.

- [Local setup instructions](#local-setup)
- [Docker instructions](#docker-setup)


### Local setup

#### 1. Clone the repository:
```bash
git clone https://github.com/elmolesto/crm-service-api.git
cd crm-service-api
bundle install
```

#### 2. Create the database:
```bash
rails db:create db:migrate db:seed
```

#### 3. Set up the credentials file (if you don't have the `key` files):
Or create your own by running (after setting up the project):
```bash
rails credentials:edit --environment development
rails credentials:edit --environment test
```
The `example.yml` file in the `config/credentials` directory shows the structure of the credentials file.

#### 4. Running the test suite
```bash
bundle exec rspec
```

Check the coverage by opening the report in your browser.
- OSX terminal: `open coverage/index.html`
- Linux terminal: `xdg-open coverage/index.html`

#### 5. Running the application
```bash
bundle exec rails s
```
Use the Postman collection to test the API endpoints.

### Docker setup
If you prefer to use Docker, there are three bin scripts that will help you run the project:

#### 1. Build and run the project:
```bash
./bin/docker-setup
```

```bash
./bin/docker-dev
```

#### 2. Run the tests:
```bash
./bin/docker-test
```

You can also run an individual test file by passing the file path as an argument, for example:
```bash
./bin/docker-test spec/models/customer_spec.rb
```

#### 3. Run rails commands:
```bash
./bin/docker-rails <command>
```

For example, to create a new migration:
```bash
./bin/docker-rails g migration AddEmailToCustomers email:string
```

## III - API documentation

See the postman collection [here](https://api.postman.com/collections/412117-b55f8a7e-7325-49b0-8fc3-1a8f48925ae2?access_key=PMAT-01J5NTX560CVA1X0CCF949FMB5) or import it using the link below:

[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://app.getpostman.com/run-collection/412117-b55f8a7e-7325-49b0-8fc3-1a8f48925ae2?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D412117-b55f8a7e-7325-49b0-8fc3-1a8f48925ae2%26entityType%3Dcollection%26workspaceId%3Dd5483b05-db6a-4820-bd11-a8b4e172f989)


## IV - Deployment instructions

### Dependent services
- **GitHub Actions**: The project uses GitHub Actions for deployment.
- **Heroku**: The project is configured to deploy to Heroku automatically once the tests have passed on the main branch.
- **Amazon S3**: The project uses Amazon S3 for file storage in production.


### Heroku deployment
#### 1. Create an S3 bucket and edit the `config/credentials/production.yml` file with the S3 credentials.

#### 2. Set the following environment variable in your Heroku app:
- `RAILS_MASTER_KEY`: The contents of the `config/credentials/production.key` file.

If you don't have this file, you can create it by running `EDITOR=vim rails credentials:edit --environment production`. You'll need to add the secrets as they are in the `config/credentials/example.yml` file.

#### 3. Set the following secrets in your github repository:
- `HEROKU_API_KEY`: The API key for your Heroku account.
- `HEROKU_APP_NAME`: The name of the Heroku app you want to deploy to.
- `HEROKU_EMAIL`: The email address associated with your Heroku account.

#### 4. If you want to add some seed data:
From heroku dashboard or the heroku CLI:
```bash
heroku run rails db:seed
```

