REMOTE=gopher:~/www/burntsushi.net/stuff/nfldb/

all:
	@echo "Specify a target."

pypi: docs longdesc.rst
	rm -rf dist/
	python setup.py sdist bdist_wheel
	twine upload dist/*

docs: 
	pdoc --html --html-dir ./doc --overwrite ./nfldb

er:
	./scripts/nfldb-write-erd > /tmp/nfldb.er
	erd -i /tmp/nfldb.er -o doc/nfldb.pdf
	erd -i /tmp/nfldb.er -o doc/nfldb.png

	./scripts/nfldb-write-erd --condense > /tmp/nfldb-condensed.er
	erd -i /tmp/nfldb-condensed.er -o doc/nfldb-condensed.pdf
	erd -i /tmp/nfldb-condensed.er -o doc/nfldb-condensed.png

	rsync doc/nfldb*{pdf,png} $(REMOTE)

sql:
	./scripts/nfldb-dump /tmp/nfldb.sql
	(cd /tmp && zip nfldb.sql.zip nfldb.sql)
	rsync --progress /tmp/nfldb.sql.zip $(REMOTE)
	rm -f /tmp/nfldb.{sql,sql.zip}

longdesc.rst: nfldb/__init__.py docstring
	pandoc -f markdown -t rst -o longdesc.rst docstring
	rm -f docstring

docstring: nfldb/__init__.py
	./scripts/extract-docstring > docstring

dev-install:
	rm -rf ./dist
	python setup.py sdist
	pip install -U dist/*.tar.gz

pep8:
	pep8-python2 nfldb/{__init__,db,query,sql,team,types,version}.py
	pep8-python2 tests/test_{query,sql}.py
	pep8-python2 scripts/{nfldb-update,nfldb-write-erd}

push:
	git push origin master
	git push github master
