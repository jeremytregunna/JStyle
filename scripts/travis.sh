#!/bin/sh
set -e

xctool project JStyle.xcodeproj -scheme JStyle build test -sdk iphonesimulator -arch i386

