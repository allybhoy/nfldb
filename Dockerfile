FROM derekadair/python-workflow:dev
WORKDIR /code
COPY ./ /code
RUN pip install -e ./
COPY ./config.ini /virtualenv/share/nfldb/config.ini
