FROM python:3.7-alpine
#From DockerHub we  use the Python alpine image
# is a lightweight version of docker that  runs python 3.7
MAINTAINER Salvador Fuentes

ENV PYTHONUNBUFFERED 1
#Puts the requirements from the requirements txt json
COPY ./requirements.txt /requirements.txt
#install the package for the database
RUN apk add --update --no-cache postgresql-client jpeg-dev
#temporary requirements
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

#Install those requirements
RUN pip install -r /requirements.txt

#unistall the temporary dependencies 
RUN apk del .tmp-build-deps


#make a directory and switch to it
RUN mkdir /app
WORKDIR /app
#copy  the folder form the  local machine to the docker image
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
#User for running applications
#Switches docker to the user that was create it
#this is used for security to avoid access to root image on the local machine

#This instruction is to make the user the owner of the created vol folder and its sub folders
RUN chown -R user:user /vol/

#The user can do everythingh  with the directoru and rest can read
RUN chmod -R 755 /vol/web

USER user

#TO use it go to the terminal and the  api folder and run comand:  docker build .