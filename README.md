<h1 align="center">DATE NIGHT</h1>

<br>
  
This repo is for the web application "Date Night", a rails app for keeping track of local date spots and planning upcoming dates with friends, partners, or strangers! <br>


# Table of Contents
- [Learning Goals](#learning-goals)
- [Tech & Tools Used](#tech-and-tools)
- [How to Set Up](#developer-setup)
- [How to Run Test Suite](#how-to-run-test-suite)

    
# Learning Goals

- Continue to gain competency with Ruby on Rails Fundamentals
- Use Bootstrap to create a user-friendly experience
- Implementing OAuth log-in feature
- Consuming 3rd party APIs such as google's Places and Geocoding API
- Planning and excecuting web application from idea to conception
- Testing asynchronous front-end API calls to OAuth provider and back-end application to external API's
- Implementing mailers and background workers 

# Tech and Tools
#### Gems Used:
  - [Pry](https://github.com/pry/pry-rails)
  - [Faraday](https://lostisland.github.io/faraday/)
  - [Orderly](https://github.com/jmondo/orderly)
  - [Capybara](https://github.com/teamcapybara/capybara)
  - [Figaro](https://github.com/laserlemon/figaro)
  - [Webmock](https://github.com/bblimke/webmock)
  - [VCR](https://github.com/vcr/vcr)
  - [Launchy](https://github.com/copiousfreetime/launchy)
  - [RSpec](https://github.com/rspec/rspec-metagem)
  - [Simple-Cov](https://github.com/simplecov-ruby/simplecov)
  - [Factory Bot for Rails](https://github.com/thoughtbot/factory_bot_rails)
  - [Faker](https://github.com/faker-ruby/faker)
  - [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)
  - [Bootstrap](https://github.com/twbs/bootstrap) 

#### Built With
  - ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) **2.7.4**
  - ![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) **5.2.8.1**
  - <img src="app/assets/images/rspec_badge.png" alt="RSpec" height="30"> **3.12.0**
  - ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
  - ![Heroku](https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white)
  - <img src="app/assets/images/CircleCi_logo.png" alt="Circle Ci" height="30">

# Developer Setup
<ol>
  <li>Fork and clone this repository</li>
  <li>cd into the root directory</li>
  <li>Run <code>bundle install</code></li>
  <li>Run <code>bundle exec figaro install</code></li>
  <li>Run <code>rails db:{create,migrate}</code></li>
  <li> [Sign up to use the Google Places](https://developers.google.com/maps/documentation/places/web-service/overview) </li>

  In config > application.yml

  ```
     google_key: <your_google_api_key>
  ```
  <li>To run this server, run <code>rails s</code> in your terminal</li>
  <li>To stop the local server, use command <code>Control + c</code></li>


</ol>

# How to Run Test Suite
  After set up:
  <ol>
    <li>Run <code>bundle exec rspec spec</code></li>
  </ol>



