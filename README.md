# Pet Platform

## Functionality
In our website, you can either be a pet borrower or pet owner. As a pet borrower, you could update your preferences for pets so that you get better match results, and after your interactions with pets, you could leave reviews for them. As a pet owner, you could search for desirable pets, and add other users as friend.Pet owners can also browse current events, add new events and update/delete events. 
## Structure explanation
Our repo contains db, which includes the petdb sample data; flask-app that includes two blueprints for two of our users - pet borrowers and pet owners - and we have 17 routes in total. Thundertests includes all of our tests for routes. 

This repo contains 3 Docker containers: 
1. A MySQL container that reads in the db file for data
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers

1. Clone this repository.  
2. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
3. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
4. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
5. Build the images with `docker compose build`
6. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 


## Walkthrough

[Click here to watch YouTube walkthrough](https://youtu.be/csGcMOTE54E)




