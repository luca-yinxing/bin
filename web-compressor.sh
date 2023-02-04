#!/bin/bash
# =============================================================================
# Informations
# =============================================================================
# Created By : Luca Gasperini <dev@xsoftware.it>
# Created At : 2019/07/23
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
: 'SVG/JS/CSS compressor script'
# =============================================================================

DIR_LIST="${1}"
DIR_REPLACE="${2}"

files=($DIR_LIST)
SCOUR_ARGS="--remove-descriptive-elements --enable-comment-stripping --no-line-breaks"


function xs_replace {
        dir=${1}
        orig=${2}
        replace=${3}
        echo $(grep -r ${orig} $dir | grep -c ${orig})
        find $dir \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s/${orig}/${replace}/g"
}

function xs_compress {
        entry=${1}
        ext=${2}

        output=$(basename -- "${entry}")
        output="${output%.*}"
        output="${dir}${output}.min.${ext}"


        if [ ${ext} == "css" ]; then
                yui-compressor $entry > $output
                echo $output
        elif [ ${ext} == "js" ]; then
                yui-compressor $entry > $output
                echo $output
        elif [ ${ext} == "svg" ]; then
                scour $entry $output $SCOUR_ARGS
                echo $output
        else
                echo "ERROR: This extension has not a compression method"
        fi
}

function xs_main {
        dir=${1}
        ext=${2}

        if [ -d  $dir ]; then
                for entry in ${dir}*.${ext}
                do
                        output=$(basename -- "${entry}")
                        if [ ${ext} == ${output#*.} ]; then
                                result=$(xs_compress ${entry} ${ext})
                                if [ $result == "ERROR:"* ]; then
                                        echo $result
                                        exit
                                fi

                                echo $entry ">" $result

                                if [ ! -z $DIR_REPLACE ]
                                then
                                        orig=$(basename -- "${entry}")
                                        replace=$(basename -- "${result}")
                                        result=$(xs_replace ${DIR_REPLACE} ${orig} ${replace})
                                        echo "Found and replaced: ${result}"
                                fi
                        fi
                done
        fi
}

for directory in "${files[@]}"
do
        directory=${directory%/}

        xs_main "${directory}/style/" "css"
        xs_main "${directory}/css/" "css"
        xs_main "${directory}/js/" "js"
        xs_main "${directory}/svg/" "svg"

done