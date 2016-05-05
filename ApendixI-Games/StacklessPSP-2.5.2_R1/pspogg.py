"""
Mockup which exports the pspogg API on non-PSP systems.
Totally dummy right now
"""

def init(ch): #Initializes the OGGVorbis subsystem.
    pass
def load(file): #Loads an OGG file.
    pass
def stop(): #Stop OGG playback.
    pass
def pause(): #Pauses OGG playback, call again to unpause.
    pass
def play(): #Play a loaded OGG file.
    pass
def endofstream(): #Returns 1 if stream has ended.
    pass
def getsec(): #Returns the stream play time in seconds.
    pass
def getmin(): #Returns the stream play time in minutes.
    pass
def gethour(): #Returns the stream play time in hours.
    pass
def volume(vol): #Sets the OGG subsystem volume.
    pass
def end(): #Stops playback and free up used memory.
    pass
