# A MAINTAINED FORK OF ANDREW GALANTS [NFLDB](https://github.com/BurntSushi/nfldb)

nfldb is a relational database bundled with a Python module to quickly and
conveniently query and update the database with data from active games.
Data is imported from
[nflgame](https://github.com/derek-adair/nflgame), which in turn gets its data
from a JSON feed on NFL.com's live GameCenter pages. This data includes, but is
not limited to, game schedules, scores, rosters and play-by-play data for every
preseason, regular season and postseason game dating back to 2009.

Here is a small teaser that shows how to use nfldb to find the top five passers
in the 2012 regular season:

```python
import nfldb

db = nfldb.connect()
q = nfldb.Query(db)

q.game(season_year=2012, season_type='Regular')
for pp in q.sort('passing_yds').limit(5).as_aggregate():
    print ( pp.player, pp.passing_yds )
```

And the output is:

```bash
[andrew@Liger ~] python2 top-five.py
Drew Brees (NO, QB) 5177
Matthew Stafford (DET, QB) 4965
Tony Romo (DAL, QB) 4903
Tom Brady (NE, QB) 4799
Matt Ryan (ATL, QB) 4719
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
[installation guide](https://github.com/derek-adair/nfldb/wiki/Installation)
on the [nfldb wiki](https://github.com/derek-adair/nfldb/wiki)
for instructions on how to setup nfldb.


### Entity-relationship diagram

Here's a condensed version that excludes play and player statistics:

[![Shortened ER diagram for nfldb](http://burntsushi.net/stuff/nfldb/nfldb-condensed.png)](http://burntsushi.net/stuff/nfldb/nfldb-condensed.pdf)

There is also a [full PDF version](http://burntsushi.net/stuff/nfldb/nfldb.pdf)
that includes every column in the database.

The nfldb wiki has a [description of the data
model](https://github.com/derek-adair/nfldb/wiki/The-data-model).

Download the 2019 nfldb PostgreSQL database
[here](https://github.com/derek-adair/nfldb/releases/download/1.0.0a2/nfldb.sql.zip)
