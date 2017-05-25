"""Wrapper for pygame, which exports the PSP Python API on non-PSP systems."""

__author__ = "Per Olofsson, <MagerValp@cling.gu.se>"


import pygame


pygame.init()


_vol_music = 255
_vol_sound = 255

def setMusicVolume(vol):
    global _vol_music
    if vol >= 0 and vol <= 255:
        _vol_music = vol
        pygame.mixer.music.set_volume(_vol_music / 255.0)

def setSndFxVolume(vol):
    global _vol_sound
    if vol >= 0 and vol <= 255:
        _vol_sound = vol


class Music:
    def __init__(self, filename, maxchan=128, loop=False):
        self._loop = loop
        pygame.mixer.music.load(filename)
        pygame.mixer.music.set_volume(_vol_music / 255.0)
    
    def start(self):
        if self._loop:
            pygame.mixer.music.play(-1)
        else:
            pygame.mixer.music.play()
    
    def stop(self):
        pygame.mixer.music.stop()


class Sound:
    def __init__(self, filename):
        self._snd = pygame.mixer.Sound(filename)
    
    def start(self):
        self._snd.set_volume(_vol_sound / 255.0)
        self._snd.play()
