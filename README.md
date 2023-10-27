# Containers-Docker

Welcome to the guide of how to make containers and pods creations, how to connect them and having a better understanding regarding Docker and Kubernetes.

Docker works as a platform as service (PaaS) and although it can offer you a whole lot of options of what to do with a container, its main focus relies on the container creation.
On the other hand, Kubernetes can be described as an container organizer, managing what you can do with your containers.

The main goal of this project was to create containers with the following images: rabbitMQ, NGINX, reddis, MariaDB, phpmyadmin and elastic search. All of them should be connected with each
other and the objective was to retrieve logs (access and error) from NGINX through elastic search logs interface. However, due to little time to do it and other projects ongoing, what was
really done was just the creation of the containers, connecting them all and then retrieving its logs via prompt. 

This project was done in a group of 4 people, so 3 of them were responsible to achieve the goal of this by using just Docker and i was responsible for achieving this goal using something
that we never had any contact: Kubernetes. So, i am going to explain how to achieve the same results as i did using Kubernetes.

First of all, on Docker Desktop go to the configurations page and then Kubernetes: enable it. After a while it will be installed and you will be able to use it. The path that i followed
in order to achieve my goals was: inserting containers inside of pods and then, once all pods are running, i did HTTP requisitions from one pod to another. However, there is something really important about that: each pod has its own IP address. So, every container inside of your pode also have the same IP address of the pod. In this case, all you need to do is make an HTTP request from one pod to another and then they will be talking to each other. But you have a problem there: a pod can restart at any time. If this restart happens, this IP adress will be changed to another one. However, there is a better way to make this connection between then: using a Service. A Service requires another file.yaml, in which you will specify which pod you want to reach out to, so if the pod gets restarted, it makes no difference. 

Let's get started. First of all, look at my .yaml files here to see how the structure of those files should be in order to create the containers with the desired image inside of your pod and also to see how the structure of the Service is. After having created the file.yaml of the pod, you should use the command kubectl create -f <your_file>.yaml. So now you have your pod with your container inside of it. If you want to create another one, you just need to change the specifications inside of it and then use kubectl apply -f <your_file>.yaml. If you want to make sure if your pod was created, use kubectl get pods, but if you want more information about it (like ports, IP addresses, etc.) use kubectl get pods -o wide. 

Like i said before, all containers inside of a pod has the same IP address of the pod. So, for example, if you want to make a HTTP request from one container that is inside of a pod to a container that is inside of another pod, then all you need to do is access the bash of the container that you want to make the requisition. In this case, use kubectl exec -it <your_pod> -- /bin/sh. Now, you are inside of your pod. If you want to check if the container contains the same IP address of the pod, use hostname -i. Now, in order to make the request, you will need to install some things. I used wget and curl to do it, but maybe there is other commands that can give you the same result. Wget and curl will probably not be installed, so in this case, do the following steps:
1. apt-get update
2. apt-get install wget
3. apt-get install procps
4. apt-get install curl procps

Now that you have one of them or both installed, all you need to do is: wget (or curl) http://IP_of_destiny:port. This will make a request to your other container. If you want to do a wrong requistion, do the same thing but after the port write /route but make sure it is a non existing route. 

If you want to have access to the logs of the container that received those requisitions, you have two ways. In my case i was trying to access the logs for NGINX container, so this steps probably will be different if your application is different than mine. But, if you are using NGINX as well, do the following:
On NGINX, you can access two files of logs: access and error. Both are on /var/log/nginx/. However, depending on your user's permissions, even if your container has logs, they will not be writen on those files. In this case, they will be probably be seen on your stdout. If that is your case, use kubectl logs <your_pod>. 

If your logs doesn't contain enough information for you, then you can access NGINX configurations file (nginx.conf) on etc/nginx and change your configurations.

Thanks for reading!


