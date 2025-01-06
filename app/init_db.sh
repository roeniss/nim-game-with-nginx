#!/usr/bin/env bash

touch counter.db
sqlite3 counter.db < counter.db.init
