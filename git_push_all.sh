#!/bin/bash
# =============================================================================
# Informations
# =============================================================================
# Created By : Luca Gasperini <dev@xsoftware.it>
# Created At : 2019/07/17
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
: 'Push all listed repo'
# =============================================================================

GIT_DIR_LIST="${1}"

if [ -z "${2}" ]
then
      GIT_COMMIT_MSG="AUTOMATIC: Pushing everything."
else
      GIT_COMMIT_MSG="${2}"
fi


files=($GIT_DIR_LIST)

echo "Total directory in array : ${#files[*]}"

for f in "${files[@]}"
do
        cd "$f"
        git add .
        git commit -m "${GIT_COMMIT_MSG}"
        git push origin master
done