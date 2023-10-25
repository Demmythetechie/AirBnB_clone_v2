#!/usr/bin/python3
"""This script generates an archive from web_static dir."""
from fabric.api import local
from datetime import datetime
from os.path import isdir


def do_pack():
    """Archives the static files."""
    time = datetime.now()
    y = time.year()
    o = time.month()
    d = time.day()
    h = time.hour()
    m = time.minute()
    s = time.second()
    try:
        name = "web_static_{}{}{}{}{}{}".format(y, o, d, h, m, s)
        if isdir('versions') is False:
            local('mkdir versions')
        local('sudo apt -y install tar')
        local("tar -cvf versions/{}.tgz web_static/*".format(name))
    except Exception:
        return None
