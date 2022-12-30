#!/usr/bin/bash
# =============================================================================
# Informations
# =============================================================================
# Created By : Luca Gasperini <dev@xsoftware.it>
# Created At : 2022/07/13
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
: 'Create a ghost user on /var/www/'
# =============================================================================

USR="${1}"

USR_SHELL="/usr/sbin/nologin"
USR_COMMENT="${USR} web user"
USR_BASEDIR="/var/www/${USR}"

useradd --shell "${USR_SHELL}" --system --home-dir "${USR_BASEDIR}" --comment "${USR_COMMENT}" "${USR}"
mkdir "${USR_BASEDIR}"
chown ${USR}:${USR} "${USR_BASEDIR}"
