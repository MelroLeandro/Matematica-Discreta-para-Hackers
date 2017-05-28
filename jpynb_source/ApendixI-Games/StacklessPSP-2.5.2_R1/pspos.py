"""Wrapper which exports the pspnet API on non-PSP systems."""

__author__ = "Per Olofsson, <MagerValp@cling.gu.se>"


import os
import time


# file I/O constants
O_RDONLY = os.O_RDONLY
O_WRONLY = os.O_WRONLY
O_RDWR   = os.O_RDWR
O_CREAT  = os.O_CREAT
O_EXCL   = os.O_EXCL


# IDs for use in SystemParam functions
PSP_SYSTEMPARAM_ID_STRING_NICKNAME     = 1
PSP_SYSTEMPARAM_ID_INT_ADHOC_CHANNEL   = 2
PSP_SYSTEMPARAM_ID_INT_WLAN_POWERSAVE  = 3
PSP_SYSTEMPARAM_ID_INT_DATE_FORMAT     = 4
PSP_SYSTEMPARAM_ID_INT_TIME_FORMAT     = 5
PSP_SYSTEMPARAM_ID_INT_TIMEZONE        = 6
PSP_SYSTEMPARAM_ID_INT_DAYLIGHTSAVINGS = 7
PSP_SYSTEMPARAM_ID_INT_LANGUAGE        = 8
PSP_SYSTEMPARAM_ID_INT_UNKNOWN         = 9

# Valid values for PSP_SYSTEMPARAM_ID_INT_ADHOC_CHANNEL
PSP_SYSTEMPARAM_ADHOC_CHANNEL_AUTOMATIC = 0
PSP_SYSTEMPARAM_ADHOC_CHANNEL_1         = 1
PSP_SYSTEMPARAM_ADHOC_CHANNEL_6         = 6
PSP_SYSTEMPARAM_ADHOC_CHANNEL_11        = 11

# Valid values for PSP_SYSTEMPARAM_ID_INT_WLAN_POWERSAVE
PSP_SYSTEMPARAM_WLAN_POWERSAVE_OFF = 0
PSP_SYSTEMPARAM_WLAN_POWERSAVE_ON  = 1

# Valid values for PSP_SYSTEMPARAM_ID_INT_DATE_FORMAT
PSP_SYSTEMPARAM_DATE_FORMAT_YYYYMMDD = 0
PSP_SYSTEMPARAM_DATE_FORMAT_MMDDYYYY = 1
PSP_SYSTEMPARAM_DATE_FORMAT_DDMMYYYY = 2

# Valid values for PSP_SYSTEMPARAM_ID_INT_TIME_FORMAT
PSP_SYSTEMPARAM_TIME_FORMAT_24HR = 0
PSP_SYSTEMPARAM_TIME_FORMAT_12HR = 1

# Valid values for PSP_SYSTEMPARAM_ID_INT_DAYLIGHTSAVINGS
PSP_SYSTEMPARAM_DAYLIGHTSAVINGS_STD    = 0
PSP_SYSTEMPARAM_DAYLIGHTSAVINGS_SAVING = 1

# Valid values for PSP_SYSTEMPARAM_ID_INT_LANGUAGE
PSP_SYSTEMPARAM_LANGUAGE_JAPANESE            = 0
PSP_SYSTEMPARAM_LANGUAGE_ENGLISH             = 1
PSP_SYSTEMPARAM_LANGUAGE_FRENCH              = 2
PSP_SYSTEMPARAM_LANGUAGE_SPANISH             = 3
PSP_SYSTEMPARAM_LANGUAGE_GERMAN              = 4
PSP_SYSTEMPARAM_LANGUAGE_ITALIAN             = 5
PSP_SYSTEMPARAM_LANGUAGE_DUTCH               = 6
PSP_SYSTEMPARAM_LANGUAGE_PORTUGUESE          = 7
PSP_SYSTEMPARAM_LANGUAGE_RUSSIAN             = 8
PSP_SYSTEMPARAM_LANGUAGE_KOREAN              = 9
PSP_SYSTEMPARAM_LANGUAGE_CHINESE_TRADITIONAL = 10
PSP_SYSTEMPARAM_LANGUAGE_CHINESE_SIMPLIFIED  = 11


_bus_frq = 111
_cpu_frq = 222

def getclocks():
    return (getclock(), getbus())

def setclocks(cpu, bus):
    setclock(cpu)
    setbus(bus)

def getbus():
    global _bus_frq
    return _bus_frq

def setbus(mhz):
    global _bus_frq
    if mhz < 1 or mhz > 167:
        raise OSError("Bad BUS frequency: %d" % mhz)
    _bus_frq = mhz

def getclock():
    global _bus_frq
    return _cpu_frq

def setclock(mhz):
    global _cpu_frq
    if mhz < 1 or mhz > 333:
        raise OSError("Bad CPU frequency: %d" % mhz)
    _cpu_frq = mhz


def freemem():
    return 3000 * 1024

def realmem():
    return 8000 * 1024


def battery():
    return (1, 1, 0, 100, 0, 30, 3600)


def getsystemparam(param):
    if param == PSP_SYSTEMPARAM_ID_STRING_NICKNAME:
        return getnickname()
        
    elif param == PSP_SYSTEMPARAM_ID_INT_ADHOC_CHANNEL:
        return PSP_SYSTEMPARAM_ADHOC_CHANNEL_AUTOMATIC
        
    elif param == PSP_SYSTEMPARAM_ID_INT_WLAN_POWERSAVE:
        return PSP_SYSTEMPARAM_WLAN_POWERSAVE_ON
        
    elif param == PSP_SYSTEMPARAM_ID_INT_DATE_FORMAT:
        return PSP_SYSTEMPARAM_DATE_FORMAT_YYYYMMDD
        
    elif param == PSP_SYSTEMPARAM_ID_INT_TIME_FORMAT:
        return PSP_SYSTEMPARAM_TIME_FORMAT_24HR
        
    elif param == PSP_SYSTEMPARAM_ID_INT_TIMEZONE:
        # Timezone offset from UTC in minutes
        if time.daylight:
            return time.altzone / 60
        else:
            return time.timezone / 60
        
    elif param == PSP_SYSTEMPARAM_ID_INT_DAYLIGHTSAVINGS:
        return time.altzone
        
    elif param == PSP_SYSTEMPARAM_ID_INT_LANGUAGE:
        return PSP_SYSTEMPARAM_LANGUAGE_ENGLISH
    
    elif param == PSP_SYSTEMPARAM_ID_INT_UNKNOWN:
        return 1
    
    else:
        raise OSError("Could not get system parameter")

def getnickname():
    try:
        import getpass
        user = getpass.getuser()
    except:
        return "PythonPSP Player"
    try:
        import pwd
        gecos = pwd.getpwnam(user)[4]
    except:
        return user
    if gecos:
        return gecos
    else:
        return user


def powertick():
    pass
