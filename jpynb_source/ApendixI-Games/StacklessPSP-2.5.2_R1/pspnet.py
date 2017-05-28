#!/usr/bin/env python

"""Wrapper which exports the pspnet API on non-PSP systems."""

__author__ = "Per Olofsson, <MagerValp@cling.gu.se>"


import time, thread
from socket import gethostbyname, gethostname


class Error(Exception):
    """Base class for exceptions in this module."""
    def __init__(self, value):
        self.value = value
    def __str__(self):
        if type(self.value) == str:
            return self.value
        else:
            return repr(self.value)


state = 0
err = False
errmsg = ""

def connectToAPCTL(n = 1, callback = None, timeout=-1):
    global state
    global err
    global errmsg
    
    if state == 4:
        # already connected
        raise Error("sceNetApctlConnect returns 80410a80\n")
    
    state = 0
    err = False
    
    if not n in (1, 2, 6, 7):
        # invalid config
        raise Error("sceNetApctlConnect returns 80110601\n")
    
    statelast = -1
    start_time = time.time()
    thread.start_new_thread(__connectToAPCTL, (n,))
    while True:
        if err:
            raise Error(errmsg)
        st = getAPCTLState()
        if st > statelast:
            print "callback(%d)" % st
            if callback:
                callback(st)
            statelast = st
        if st == 4:
            if callback:
                callback(-1)
            return
        time.sleep(0.05)
        if timeout > 0:
            now = time.time()
            if (now - start_time) > timeout:
                raise Error("Timeout while trying to connect")

def __connectToAPCTL(n):
    global state
    global err
    global errmsg
    time.sleep(0.4)
    state = 2
    if n != 1:
        # only config 1 works, the others time out
        return
    time.sleep(0.4)
    state = 3
    time.sleep(0.4)
    state = 4

def disconnectAPCTL():
    global state
    state = 0

def getIP():
    return gethostbyname(gethostname())

def enumConfigs():
    return [(1, "Kringla", "0.0.0.0"),
            (2, "Lingvistik", "0.0.0.0"),
            (6, "Spelmannen 6", "0.0.0.0"),
            (7, "Kristinelund", "0.0.0.0")]

def wlanSwitchState():
    return True

def wlanEtherAddr():
    return "00:00:00:00:00:00"

def getAPCTLState():
    return state


def _test_callback(state):
    print "state", state

if __name__ == '__main__':
    connectToAPCTL(1, _test_callback)
    time.sleep(2)
