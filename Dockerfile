FROM python:3.5-alpine

RUN pip install Django

# Project Files and Settings
ARG PROJECT=feedback_gateway
ARG PROJECT_DIR=/var/www/${PROJECT}
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR

COPY feedback_gateway/* ${PROJECT_DIR}/feedback_gateway/
COPY contact db.sqlite3/* ${PROJECT_DIR}/contact/
COPY manage.py ${PROJECT_DIR}/
COPY db.sqlite3 ${PROJECT_DIR}/

# Server
EXPOSE 8006
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "manage.py"]
#CMD ["runserver", "--settings=feedback_gateway.settings_prod", "--insecure", "0.0.0.0:8006"]
CMD ["runserver", "0.0.0.0:8006"]

# docker stop feedback-gateway
# docker rm feedback-gateway
# docker rmi feedback-gateway
# docker build --tag igrek51/feedback-gateway:latest .

# rm feedback-gateway.tar.gz
# docker save -o feedback-gateway.tar feedback-gateway
# gzip feedback-gateway.tar

# docker load -i feedback-gateway.tar.gz
# docker run --rm --name feedback-gateway -p 8006:8006 -d --restart always feedback-gateway


# docker login --username=igrek51
## docker tag feedback-gateway igrek51/feedback-gateway:latest
# docker push igrek51/feedback-gateway
# docker pull igrek51/feedback-gateway:latest
# docker run --name feedback-gateway -p 8006:8006 -d --restart always igrek51/feedback-gateway:latest
