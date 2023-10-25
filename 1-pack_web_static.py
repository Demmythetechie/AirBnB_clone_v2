#!/usr/bin/python3
"""
This script generates an archive from web_static dir
"""
from fabric import Connection, task
from datetime import datetime


@task
def do_pack(context):
    """
    This script generates an archive from web_static dir
    """

    time = datetime.now()
    y = time.year()
    o = time.month()
    d = time.day()
    h = time.hour()
    m = time.minute()
    s = time.second()

    try:
        name = f"web_static_{y}{o}{d}{h}{m}{s}"
        lcl = Connection(host="localhost", user="demilade")
        lcl.local('mkdir versions')
        lcl.local('sudo apt -y install tar')
        lcl.local(f"tar -cvf versions/{name}.tgz web_static/*")
    except Exception:
        return None
