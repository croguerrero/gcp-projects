FROM python:3.9-slim

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install \
    nginx \
    python3-dev \
    build-essential

COPY ./requirements.txt ./requirements.txt
RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt
COPY templates /templates
COPY ./meme_api.py ./meme_api.py

EXPOSE 80
CMD [ "python3", "meme_api.py" ]