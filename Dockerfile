FROM python:3.7-alpine
#From DockerHub we  use the Python alpine image
# is a lightweight version of docker that  runs python 3.7
MAINTAINER Salvador Fuentes

ENV PYTHONUNBUFFERED 1
#Puts the requirements from the requirements txt json
COPY ./requirements.txt /requirements.txt
#Install those requirements
RUN pip install -r /requirements.txt

#make a directory and switch to it
RUN mkdir /app
WORKDIR /app
#copy  the folder form the  local machine to the docker image
COPY ./app /app

RUN adduser -D user
#User for running applications
#Switches docker to the user that was create it
#this is used for security to avoid access to root image on the local machine
USER user

#TO use it go to the terminal and the  api folder and run comand:  docker build .