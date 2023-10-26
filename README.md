# Containers-Docker

Welcome to the guide of how to make containers and pods creations, how to connect them and having a better understanding regarding Docker and Kubernetes.

Docker works as a platform as service (PaaS) and although it can offer you a whole lot of options of what to do with a container, its main focus relies on the container creation.
On the other hand, Kubernetes can be described as an container organizer, managing what you can do with your containers.

The main goal of this project was to create containers with the following images: rabbitMQ, NGINX, reddis, MariaDB, phpmyadmin and elastic search. All of them should be connected with each
other and the objective was to retrieve logs (access and error) from NGINX through elastic search logs interface. However, due to little time to do it and other projects ongoing, what was
really done was just the creation of the containers, connecting them all and then retrieving its logs via prompt. 
