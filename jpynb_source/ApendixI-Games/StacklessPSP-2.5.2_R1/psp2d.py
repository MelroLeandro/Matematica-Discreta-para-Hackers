# -*- coding: latin-1 -*-

"""Wrapper for PyGame, which exports the psp2d API on non-PSP systems."""

__author__ = "Per Olofsson, <MagerValp@cling.gu.se>"
# based on the implementation by Boris Buegling, <boris@icculus.org>
# patched to include Controller class from Kousu's wrapper


import sys
import time
import threading

import pygame

from pygame.locals import *


pygame.init()
pygame.display.set_caption('PythonPSP player')
_screen = pygame.display.set_mode((480, 272), pygame.DOUBLEBUF|pygame.HWSURFACE)


# slightly over-engineered, but it matches the PSP implementation
class Color:
    """Contains RGBA values between 0 and 255 for a color."""
    
    color_components = ("red", "green", "blue", "alpha")
    
    def __init__(self, red, green, blue, alpha=0):
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        for name, value in self.__dict__.items():
            if type(value) != int:
                raise TypeError("%s component must be an integer." % name)
            if value < 0 or value > 255:
                raise ValueError("%s component must be between 0 and 255" % name)
    
    def __getattr__(self, name):
        """Read RGBA attributes."""
        if name in Color.color_components:
            return self.__dict__[name]
        else:
            raise AttributeError("Color instance has no attribute '%s'" % name)
    
    def __setattr__(self, name, value):
        """Set RGBA attributes."""
        if not name in Color.color_components:
            raise AttributeError("Color instance has no attribute '%s'" % name)
        if type(value) != int:
            raise TypeError("%s component must be an integer." % name)
        if value < 0 or value > 255:
            raise ValueError("%s component must be between 0 and 255" % name)
        self.__dict__[name] = value
    
    def __delattr__(self, name):
        """Delete RGBA attributes (ok, let's not)"""
        if name in Color.color_components:
            raise TypeError("Cannot delete %s component" % name)
        else:
            raise AttributeError("Color instance has no attribute '%s'" % name)
    
    def pygame_tuple(self):
        """Return RGBA values as a tuple for pygame."""
        return (self.red, self.green, self.blue, 255 - self.alpha)


class Controller:
    """
    This class gives access to the state of the pad and buttons. The state is
    read upon instantiation and is accessible through read-only properties.
    """
    
    def __init__(self):
        """
        While the controller has a mousepos property the mouse is being
        dragged which is mapped to the joystick being moved. mousepos is used
        to calculate a distance to pretend the joystick is moving.
        """
        
        self.analogX = 0
        self.analogY = 0
        if hasattr(self, 'mousepos'):
            newpos = pygame.mouse.get_pos()
            pygame.draw.line(_screen, (0, 0, 0), self.mousepos, newpos)
            pygame.display.flip()
            self.analogX, self.analogY = (b - a for a, b in zip(self.mousepos, newpos))
            if self.analogX < -127:
                self.analogX = -127
            elif self.analogX > 128:
                self.analogX = 128
            if self.analogY < -127:
                self.analogY = -127
            elif self.analogY > 128:
                self.analogY = 128
        
        # update the in-memory keystate
        pygame.event.pump()
        keys = pygame.key.get_pressed()
        # make a list of all the IDs of the currently pressed keys
        self.keys = [i for i, pressed in enumerate(keys) if pressed]
        
        for e in pygame.event.get():
            if e.type == QUIT:
                # this is a little hook to make the program nice to the rest
                # of the system. Under the assumption that the app will often
                # be querying the controller, this here serves to kill the app
                # if the user clicks close or something
                sys.exit(0)
            if e.type == MOUSEBUTTONDOWN:
                # cache the position, used in calculating how much to give to
                # the joystick
                Controller.mousepos = e.pos
            if e.type == MOUSEBUTTONUP:
                del Controller.mousepos
    
    @property
    def start(self):
        return K_v in self.keys
    @property
    def select(self):
        return K_c in self.keys
    
    @property
    def triangle(self):
        return K_w in self.keys
    @property
    def square(self):
        return K_a in self.keys
    @property
    def circle(self):
        return K_s in self.keys
    @property
    def cross(self):
        return K_z in self.keys
    
    @property
    def up(self):
        return K_UP in self.keys
    @property
    def left(self):
        return K_LEFT in self.keys
    @property
    def down(self):
        return K_DOWN in self.keys
    @property
    def right(self):
        return K_RIGHT in self.keys
    
    @property
    def l(self):
        return K_q in self.keys
    @property
    def r(self):
        return K_e in self.keys


class Char:
    """Character containing a pygame surface with pixel data, its width, and height."""
    
    def __init__(self, surface):
        self._surface = surface
        self._width = surface.get_width()
        self._height = surface.get_height()
    
    @property
    def surface(self):
        return self._surface
    
    @property
    def height(self):
        return self._height
    
    @property
    def width(self):
        return self._width


class Font:
    """SFont compatible font class."""
    
    def __init__(self, filename):
        surface = pygame.image.load(filename)
        self.height = surface.get_height() - 1 # -1 to account for the row of pinks
        self.char = dict()
        
        font_chars = list("!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ")
        # the color to be used as character delimiter
        refcolor = surface.get_at((0,0))
        x = 0
        while x < surface.get_width() and len(font_chars):
            if surface.get_at((x, 0)) != refcolor:
                start = x
                while x < surface.get_width() and surface.get_at((x, 0)) != refcolor:
                    x += 1
                end = x
                self.char[font_chars.pop(0)] = Char(surface.subsurface((start, 1, end - start, self.height)))
            x += 1
        # create an empty surface the same size as ! for spaces
        space_surface = pygame.Surface((self.char["!"].width, self.char["!"].height))
        space_surface.set_alpha(0)
        self.space = Char(space_surface)
    
    def chars(self, text):
        """Generate Char objects for each char in text."""
        for c in text:
            if self.char.has_key(c):
                yield self.char[c]
            else:
                yield self.space
    
    def textHeight(self, text):
        return self.height
    
    def textWidth(self, text):
        width = 0
        for c in self.chars(text):
            width += c.width
        return width
    
    def drawText(self, drw, x, y, text):
        for c in self.chars(text):
            drw.blit(c.surface, dx=x, dy=y)
            x += c.width


def _blit(dst, src, sx=0, sy=0, w=-1, h=-1, dx=0, dy=0, blend=False, dw=-1, dh=-1):
    if w == -1:
        w = src.get_width()
    if h == -1:
        h = src.get_height()
    
    if dw < 0:
        dw = w
    if dh < 0:
        dh = h
    
    if dx >= dst.get_width() or dy >= dst.get_height():
        return
        
    scalex = dw * 1.0 / w
    scaley = dh * 1.0 / h
    
    w = min(w, dst.get_width() - dx)
    h = min(h, dst.get_height() - dy)
    
    #targetw = src.get_width() - sx
    #targeth = src.get_height() - sy
    
    #if dx + scalex * w >= targetw:
    #    w = int((targetw - dx) / scalex)
    #if dy + scaley * h >= targeth:
    #    h = int((targeth - dy) / scaley)
    
    if w <= 0 or h <= 0:
        return
    
    src = src.subsurface(sx, sy, w, h)
    
    if blend:
        if dw != w or dh != h:
            src = pygame.transform.smoothscale(src, (dw, dh))
    
    pygame.Surface.blit(dst, src, (dx, dy))


IMG_PNG = 0
IMG_JPEG = 1

class Image(pygame.Surface):
    def __init__(self, *args):
        if len(args) == 2:
            pygame.Surface.__init__(self, (args[0], args[1]), pygame.SRCALPHA, 32)
            self.set_alpha(255)
        else:
            if type(args[0]) is Image:
                surf = args[0]
            else:
                if type(args[0]) != str:
                    raise TypeError("Argument must be a string")
                surf = pygame.image.load(args[0])
            pygame.Surface.__init__(self, (surf.get_width(), surf.get_height()),
                                    pygame.SRCALPHA, 32)
            self.blit(surf)
    
    def clear(self, color):
        self.fill(color.pygame_tuple())
    
    def blit(self, src, sx=0, sy=0, w=-1, h=-1, dx=0, dy=0, blend=False, dw=-1, dh=-1):
        _blit(self, src, sx, sy, w, h, dx, dy, blend, dw, dh)
    
    def fillRect(self, x, y, w, h, color):
        self.fill(color.pygame_tuple(), pygame.Rect(x, y, w, h))
    
    def saveToFile(self, filename, type=IMG_PNG):
        pygame.image.save(self, filename)
    
    def putPixel(self, x, y, color):
        self.set_at((x, y), color.pygame_tuple())
    
    def getPixel(self, x, y):
        (r, g, b, a) = self.get_at((x, y))
        return Color(r, g, b, 255 - a)
        
    @property
    def width(self):
        return self.get_width()
    
    @property
    def height(self):
        return self.get_height()


class Screen:
    def __init__(self):
        pass
    
    def blit(self, src, sx=0, sy=0, w=-1, h=-1, dx=0, dy=0, blend=False, dw=-1, dh=-1):
        _blit(_screen, src, sx, sy, w, h, dx, dy, blend, dw, dh)
    
    def swap(self):
        pygame.display.flip()
        pygame.event.pump()
    
    def clear(self, color):
        _screen.fill(color.pygame_tuple())
    
    def fillRect(self, x, y, w, h, color):
        _screen.fill((x,y,w,h), color.pygame_tuple())
    
    def saveToFile(self, filename, type=IMG_PNG):
        pygame.image.save(_screen, filename)
    
    def putPixel(self, x, y, color):
        _screen.set_at((x, y), color.pygame_tuple())
    
    def getPixel(self, x, y):
        (r, g, b, a) = _screen.get_at((x, y))
        return Color(r, g, b, 255 - a)
    
    @property
    def width(self):
        return _screen.get_width()
    
    @property
    def height(self):
        return _screen.get_height()


class Mask:
    """  This is a 2-dimensionnal bit field, intended to be used in collision detection.. """
    # TODO: Implement this.
    
    def __init__(self, img, x, y, w, h, threshold):
        pass
    
    def collide(self, msk):
        pass
    
    def union(self, msk):
        pass
    
    def isIn(self, x, y):
        pass


TR_USER = 0
TR_PLUS = 1
TR_MULT = 2
TR_G2A  = 3
TR_GRAY = 4
TR_BW   = 5

class Transform:
    """A class used to make pixel-based transformations on images."""
        
    def __init__(self, type, param=0.0):
        if type(type) == int:
            self.type = type
            self.param = param
        elif hasattr(type, "__call__"):
            self.type = TR_USER
            self.param = type
            self.apply = self.apply_slow_callback
        else:
            raise TypeError("Argument must be either an integer or a callable")
    
    def apply(self, img):
        if self.type == TR_USER:
            for y in range(img.height):
                for x in range(img.width):
                    color = self.param(x, y, img.getPixel(x, y))
                    if not color:
                        return
                    img.putPixel(x, y, color)
        elif self.type == TR_PLUS:
            for y in range(img.height):
                for x in range(img.width):
                    color = img.getPixel(x, y)
                    color.red   = min(255, color.red   + self.param)
                    color.green = min(255, color.green + self.param)
                    color.blue  = min(255, color.blue  + self.param)
                    img.putPixel(x, y, color)
        elif self.type == TR_MULT:
            if param <= 0:
                black = Color(0, 0, 0)
                for y in range(img.height):
                    for x in range(img.width):
                        img.putPixel(x, y, black)
            else:
                for y in range(img.height):
                    for x in range(img.width):
                        color = img.getPixel(x, y)
                        color.red   = min(255, color.red   * self.param)
                        color.green = min(255, color.green * self.param)
                        color.blue  = min(255, color.blue  * self.param)
                        img.putPixel(x, y, color)
        elif self.type == TR_G2A:
            for y in range(img.height):
                for x in range(img.width):
                    color = img.getPixel(x, y)
                    color.alpha = (color.red + color.green + color.blue) / 3
                    img.putPixel(x, y, color)
        elif self.type == TR_GRAY:
            for y in range(img.height):
                for x in range(img.width):
                    color = img.getPixel(x, y)
                    gray = (color.red + color.green + color.blue) / 3
                    color.red   = gray
                    color.green = gray
                    color.blue  = gray
                    img.putPixel(x, y, color)
        elif self.type == TR_BW:
            for y in range(img.height):
                for x in range(img.width):
                    color = img.getPixel(x, y)
                    gray = (color.red + color.green + color.blue) / 3
                    if gray > self.param:
                        color.red   = 255
                        color.green = 255
                        color.blue  = 255
                    else:
                        color.red   = 0
                        color.green = 0
                        color.blue  = 0
                    img.putPixel(x, y, color)


class BlitBatch:
    def __init__(self):
        self._lst = list()
    
    def add(self, img):
        self._lst.append(img)
    
    def blit(self):
        for img in self._lst:
            screen.blit(img.data[0], dx=img.data[1], dy=img.data[2])


class TimerThread(threading.Thread):
    def __init__(self, func, timeout):
        threading.Thread.__init__(self)
        self.function = func
        self.timeout = timeout / 1000
    
    def run(self):
        while True:
            time.sleep(self.timeout)
            if not self.function():
                break


class Timer:
    def __init__(self, timeout):
        self.thr = TimerThread(self.fire, timeout)
    
    def fire(self):
        raise NotImplementedError('Override in your subclass.')
    
    def run(self):
        self.thr.start()
    
