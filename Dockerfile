FROM python:3

RUN pip install Django

# Project Files and Settings
ARG PROJECT=feedback_gateway
ARG PROJECT_DIR=/var/www/${PROJECT}
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR
ADD . $PROJECT_DIR

# Server
EXPOSE 8005
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8005", "--insecure"]

# docker build --tag feedback_gateway .
# docker run --name feedback_gateway -p 8005:8005 -d feedback_gateway

# docker save -o feedback_gateway.tar feedback_gateway
# gzip feedback_gateway.tar
