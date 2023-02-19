ARG IMAGE_VARIANT=slim-buster
ARG OPENJDK_VERSION=8
ARG PYTHON_VERSION=3.9.8

FROM python:${PYTHON_VERSION}-${IMAGE_VARIANT} AS py3
FROM openjdk:${OPENJDK_VERSION}-${IMAGE_VARIANT}

COPY --from=py3 / /

ARG PYSPARK_VERSION=3.2.0
RUN pip --no-cache-dir install pyspark==${PYSPARK_VERSION}
RUN pip install --no-cache-dir --upgrade -r /workspaces/BigData_Project/requirements.txt
RUN apt update && apt upgrade -y
RUN apt install curl -y
RUN curl https://downloads.apache.org/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz --output hadoop.tar.gz
RUN tar -xzf hadoop.tar.gz
RUN cp -r hadoop-2.10.1/ /usr/local/
RUN rm -rf hadoo*
ENV PATH="$PATH:/usr/local/hadoop-2.10.1/bin"
