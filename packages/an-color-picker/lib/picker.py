#! /usr/bin/python
# -*- coding: utf-8 -*-

import pygtk
import gtk
import sys
import os

def toHtml(color):
  red = str(hex(color.red * 255 / 65535))[2:]
  green = str(hex(color.green * 255 / 65535))[2:]
  blue = str(hex(color.blue * 255 / 65535))[2:]
  if len(red) 	== 1: red 	= "0%s" % red
  if len(green) == 1: green = "0%s" % green
  if len(blue) 	== 1: blue 	= "0%s" % blue
  return ("#%s%s%s" % (red, green, blue)).upper()

# construction du dialogue
dialog = gtk.ColorSelectionDialog("ColorPicker")
colorSelection = dialog.colorsel
palette = os.getcwd()+"/palette"
if os.path.exists(palette):
  palette = ":".join(open(palette).read().strip().split("\n"))
  gtk.settings_get_default().set_property("gtk-color-palette", palette)

# Utilisation de la couleur en paramètre
initialColor = None
if len(sys.argv)>1:
  initialColor = gtk.gdk.Color(sys.argv[1].strip())
  colorSelection.set_previous_color(initialColor)
  colorSelection.set_current_color(initialColor)

# Gestion de la transparence
# colorSelection.set_has_opacity_control(True)
# colorSelection.set_current_alpha(0)

# Gestion de la palette
colorSelection.set_has_palette(True)

# exécution du dialogue
if dialog.run() == gtk.RESPONSE_OK:
  color = colorSelection.get_current_color()
  print toHtml(color)

# ménage
dialog.hide()
