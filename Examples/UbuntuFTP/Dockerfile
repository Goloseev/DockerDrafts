FROM ubuntu
LABEL maintainer="jeffmshale@gmail.com"
ENV ADMIN="jeff"
RUN echo -----doing updates---------
RUN apt-get update >/dev/null && apt-get upgrade -y >/dev/null\
    && echo ------обновил----------------
#RUN apt-get install vsftpd -y >/dev/null
RUN apt-get install nginx -y >/dev/null

RUN echo 'Hi, I am in your container!!!!!!!!!!!!!' \
        >/usr/share/nginx/html/index.html

#пример копирования произвольной папки в docker 
#COPY ./app_data ./app_data_in_docker

# пример скачивания файла и разбития строки на две
ADD https://raw.githubusercontent.com/discdiver/pachy-vid/master/sample_vids/vid1.mp4 \
/my_app_directory/


#RUN ["mkdir", "/a_directory"]

EXPOSE 80

# пример запуска python скрипта, команда замещается указанием bash
#CMD ["python", "./my_script.py"]
