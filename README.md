# Tickets Notifier

### Description
A simple application that notifies the user about a task that is expiring in an interval that is set by the user

#### Technical Approach (Used one)
- We leverage the use of `cron` jobs provided by `sidekiq` where we have a job that is set to run every minute and checks which user have set this hour and minute as a preferred time of day to receive the notifications,
if there are users then we send notifications to the users if and only if the ticket falls with in the time that the user set to get notification and the end of the day, tickets out of bounds will be discarded.
- Also we avoid duplicate emails by marking the ticket as have received a reminder after sending the email
- Also building the system to be able to accomodate more types of notifications in the future (can be seen in `NotificationService` and abstraction in `Notification`.

#### Other Approach (Not used)
Is to enqueue a job when ever a `ticket` is made, however this approach has multiple problems:
  - Queues can be flooded easily which will result in memory over flow for sidekiq resulting in jobs failing (encountered this in one of my previous companies that i have worked for)
  - Always keeping track of the jobs and deleting jobs and renqueuing them if `due_date` changed for `ticket` or `due_date_reminder_time` or `interval` changes for the `user`

#### Verdict
Using the first approach lets us not worry about if something change or not in the data that decides when the ticket is enqueued


### Installation
**prerequisites**
```ruby
  ruby '3.3.2'
  postgresql '16.3'
  redis '7.2.5'
```
**installing**

```ruby
  bundle install
  rails db:create
  rails db:migrate
  gem install mailcatcher (to open and view mail)
```
**Running the app**

```ruby
mailcatcher
rails s
```
**In another terminal**
```ruby
  redis-server (or run it in deamon mode based on your system)
  bundle exec sidekiq
```


### Usage
- After running the app navigate to `localhost:3000` you will see a blank page with a link to `create user` create one and set the desired timezone and other data
- After that create ticket from the user page (keep in mind all tickets are created in UTC time)
- When the preferred time of the user come and the ticket falls with in bounds a mail will get triggered for it

### Tests
To run tests run the following command
```ruby
  rspec
```

### Further Development
  - Improving the ui of the application
  - Writing integration tests for the controllers
  - Handling out of scope cases such: if task is 100% progress then mark it as completed
  - Dockerizing the whole application and using docker-compose for it
  
  
