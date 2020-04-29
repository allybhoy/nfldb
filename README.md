# A MAINTAINED FORK OF ANDREW GALANTS [NFLDB](https://github.com/BurntSushi/nfldb)

nfldb is a relational database bundled with a Python module to quickly and
conveniently query and update the database with data from active games.
Data is imported from
[nflgame](https://github.com/derek-adair/nflgame), which in turn gets its data
from a JSON feed on NFL.com's live GameCenter pages. This data includes, but is
not limited to, game schedules, scores, rosters and play-by-play data for every
preseason, regular season and postseason game dating back to 2009.

## Setup Docker Compose
1. Clone this project
```
git clone https://github.com/derek-adair/nfldb.git && cd nfldb
```
2. Download the latest DB from the [release tab](https://github.com/derek-adair/nfldb.git)
```
export NFLDB_VERSION="1.0.0a4"
wget https://github.com/derek-adair/nfldb/releases/download/$NFLDB_VERSION/nfldb2019.sql.zip && \
    unzip nfldb2019.sql.zip
```
3. Start Postgres & import the database (this can take a while...)
```
docker-compose up -d postgres
docker exec -i nfldb-postgres psql -U postgres -c "CREATE DATABASE nfldb;"
docker exec -i nfldb-postgres psql -U postgres nfldb < nfldb.sql
# cleanup
rm nfldb2019.sql.zip nfldb.sql
```
4. Boot up a nfldb container
```bash
docker-compose run --rm nfldb
```
5. Run some things
```python
import nfldb

db = nfldb.connect()
q = nfldb.Query(db)

q.game(season_year=2019, season_type='Regular')
for pp in q.sort('passing_yds').limit(5).as_aggregate():
    print ( pp.player, pp.passing_yds )
```

And the output is:

```bash
Jameis Winston (NO, QB) 5109
Dak Prescott (DAL, QB) 4902
Jared Goff (LA, QB) 4638
Philip Rivers (IND, QB) 4615
Matt Ryan (ATL, QB) 4466
```

### Documentation and getting help

[comprehensive API documentation](http://nfldb.derekadair.com).
Tutorials, more examples and a description of the data model can be found
on the [nfldb wiki](https://github.com/derek-adair/nfldb/wiki).

If you need any help or have found a bug, please
[open a new issue on nfldb's issue
tracker](https://github.com/derek-adair/nfldb/issues/new)

OR come visit us in discord on channel https://discord.gg/G7uay2.


### Installation and dependencies

nfldb depends on the following Python packages available in
[PyPI](https://pypi.python.org/pypi):
[nflgame](https://pypi.python.org/pypi/nflgame),
[psycopg2](https://pypi.python.org/pypi/psycopg2),
[pytz](https://pypi.python.org/pypi/pytz) and
[enum34](https://pypi.python.org/pypi/enum34).

Please see the
[installation guide](https://github.com/BurntSushi/nfldb/wiki/Installation)
on the [nfldb wiki](https://github.com/BurntSushi/nfldb/wiki)
for instructions on how to setup nfldb.


### Entity-relationship diagram

Here's a condensed version that excludes play and player statistics:

[![Shortened ER diagram for nfldb](http://burntsushi.net/stuff/nfldb/nfldb-condensed.png)](http://burntsushi.net/stuff/nfldb/nfldb-condensed.pdf)

There is also a [full PDF version](http://burntsushi.net/stuff/nfldb/nfldb.pdf)
that includes every column in the database.

The nfldb wiki has a [description of the data
model](https://github.com/derek-adair/nfldb/wiki/The-data-model).

Download the 2019 nfldb PostgreSQL database from your matching release [here](https://github.com/derek-adair/nfldb/releases).  They are attached under "assets".
