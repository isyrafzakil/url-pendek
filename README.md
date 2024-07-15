# URL Shortener Application

This is a URL shortener application built with Ruby on Rails. The application allows users to shorten URLs and provides a usage report for each shortened URL, including the number of clicks, originating geolocation, and timestamp of each visit.

## Installation Guide

### Prerequisites

Make sure you have the following installed:

- Ruby (version 3.3.0 or later)
- Rails (version 7.2 or later)
- PostgreSQL (or your preferred database)
- Node.js

### Installation Steps

1. Clone the repository:

   ```sh
   git clone https://github.com/isyrafzakil/url-pendek.git
   ```

2. Install dependencies:

   ```sh
   bundle install
   ```

3. Set up the database:

   ```sh
   rails db:create
   rails db:migrate
   ```

4. Run the Rails server:

   ```sh
   rails server
   ```

5. Visit [http://localhost:3000](http://localhost:3000) in your browser to use the application.

### Dependencies

- Ruby
- Rails
- PostgreSQL (or your preferred database)
- Node.js
- HTTParty (for fetching the title of the long URL)
- RSpec (for testing)

### Running Tests

To run the test suite, use the following command:

```sh
bundle exec rspec
```

## See it live

Visit [https://url-pendek.onrender.com/](https://url-pendek.onrender.com/)

To view the report: [https://url-pendek.onrender.com/urls/report](https://url-pendek.onrender.com/urls/report)
