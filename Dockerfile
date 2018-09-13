FROM python:3.5-alpine

RUN pip install Django

# Project Files and Settings
ARG PROJECT=feedback_gateway
ARG PROJECT_DIR=/var/www/${PROJECT}
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR
ADD . $PROJECT_DIR

# Server
EXPOSE 8006
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8006", "--insecure"]

# docker build --tag feedback_gateway .
# docker run --name feedback_gateway -p 8006:8006 -d --restart always feedback_gateway

# docker save -o feedback_gateway.tar feedback_gateway
# gzip feedback_gateway.tar

# docker load -i feedback_gateway.tar.gz
