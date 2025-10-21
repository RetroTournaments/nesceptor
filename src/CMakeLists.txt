################################################################################
##
## Copyright (C) 2025 Matthew Deutsch
##
## nesceptor is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## nesceptor is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with nesceptor; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
##
################################################################################
cmake_minimum_required(VERSION 3.15)


add_executable(hello
    hello.c
)

pico_enable_stdio_usb(hello 1)
pico_add_extra_outputs(hello)

target_link_libraries(hello pico_stdlib)
