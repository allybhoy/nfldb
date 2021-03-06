FROM derekadair/python-workflow:dev
WORKDIR /usr/local
RUN pip install pdoc3 wheel
RUN wget https://github.com/jgm/pandoc/releases/download/2.9.2.1/pandoc-2.9.2.1-1-amd64.deb
RUN dpkg -i $(pwd)/pandoc-2.9.2.1-1-amd64.deb

WORKDIR /code
COPY ./ /code
RUN make dev-install
COPY ./config.ini.sample /virtualenv/share/nfldb/config.ini
