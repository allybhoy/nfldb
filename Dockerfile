FROM derekadair/python-workflow:dev
WORKDIR /code
COPY ./ /code
RUN pip install -e ./
