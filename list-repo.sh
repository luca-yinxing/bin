#!/usr/bin/bash
# =============================================================================
# Informations
# =============================================================================
# Created By : Luca Gasperini <dev@xsoftware.it>
# Created At : 2022/12/30
# Project    : Simple Script
# Repository :
# Coding     : UTF-8
# =============================================================================
# License
# =============================================================================
: '
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
 
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
  
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
'
# =============================================================================
# Description
# =============================================================================
: 'List all package from repo'
# =============================================================================

server="${1}"
# "http://ftp.it.debian.org/debian/"
branch="${2}"
# "bullseye/main"

apt-cache policy $(dpkg -l | awk 'NR >= 6 { print $2 }') |
  awk -v server="$server" \
    '/^[^ ]/      { split($1, a, ":"); pkg = a[1] }
    nextline == 1 { nextline = 0; if ($2 == server && $3 == branch) print pkg }
    /\*\*\*/      { nextline = 1 }'

