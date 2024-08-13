# API Test - The CRM Service

Welcome to the second phase of The Agile Monkeys recruitment process!

In this phase, we'll ask you to build a synthetic API project using your technology of choice. You can use any programming language or tool, but we recommend using the one you feel most comfortable with.

## Objective

The objective is to create a REST API to manage customer data for a small shop. It will serve as the backend for a CRM interface that is being developed by a different team. As the lead developer of the backend project, you'll be in charge of the API design and implementation.

## API Requirements

The API should be accessible only by a registered user through an authentication mechanism.

### User Capabilities

A registered user can:

- **List all customers** in the database.
- **Get full customer information**, including a photo URL.
- **Create a new customer**:
  - A customer should have at least the following fields:
    - Name (required)
    - Surname (required)
    - ID (required)
    - Photo
  - Image uploads should be manageable.
  - The customer should have a reference to the user who created it.
- **Update an existing customer**:
  - The customer should hold a reference to the last user who modified it.
- **Delete an existing customer**.

### Admin Capabilities

In addition to the user capabilities, an admin can:

- **Manage users**:
  - Create users.
  - Delete users.
  - Update users.
  - List users.
  - Change admin status.

## Design Recommendations

The specific design is up to you, but we recommend taking advantage of tools and libraries provided by your platform of choice.

You will be invited to a Slack channel where you can communicate with our team. We encourage candidates to explain why they chose a specific framework, library, or approach! Feel free to ask any questions you may have.

## Project Submission

Please create a git repository for the project on GitHub or Bitbucket and share the link with the team in the Slack channel.

## Evaluation Criteria

### Required

- **Good code quality**:
  - Readability and simplicity.
  - Good semantics.
  - Idiomatic code and adoption of framework standards.
  - Write your code as if you were to publish it to production.
- **Good software architecture**:
  - Low coupling.
  - Ease of change.
  - Good use of design patterns.
  - Use of framework or specific language patterns.
- **Good communication with the team**.
- **Basic security measures**:
  - Authentication
  - Authorization
  - SQL injection and XSS prevention
- **Completeness and correctness of the solution**.

### Extra Points

- **Good README file** with a getting started guide.
- **Tests** implemented for the solution.
- Making the project **setup easier for newcomers**.
- The application follows the [twelve-factor app principles](https://12factor.net) to ensure scalability.
- **OAuth 2 protocol** for authentication (you can use a third-party public OAuth provider).
- The project is ready for **Continuous Deployment** using a provider (e.g., AWS).
- The project uses **Docker, Vagrant, or other tools** to simplify configuring development environments.

---

Good luck!

**The Agile Monkeys**
