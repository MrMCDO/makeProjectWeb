########################################################################
# makeProjectWeb
# Utilité:  Ce script permet de generer les fichiers de base
#           nécessaires au lancement d'un projet web (html/css) avec le
#           contenu de base pour html et le reset pour le css
#
# Usage:    mpb [OPTION1] [Valeur] [OPTION2] [Valeur] [OPTION3] [Valeur] [OPTION4]
# Option : -p -> Permet d'indiquer le chemin ou les fichiers seront créés
#          -t -> Permet d'indiquer que l'on souhaite créer un dossier parent au projet en indiquant son nom
#          -r -> Indique que l'on souhaite générer le dossier ressources"
#          -c -> Permet l'ouverture du dossier du projet avec l'éditeur de son choix, indiqué après
#          
#
# Auteur:   Thomas Graber <thomas.graber310@gmail.com>
#
# Mise à jour le: 10/02/2022
#
# Version : 1.0
########################################################################


#!/bin/bash

bool_title=0
bool_ressources=0
bool_editeur=0
path_dest=$(pwd)
title_dir='Document'
editeur=""

function display_help {
    echo "mpb : makeProjectWeb"
    echo
    echo "Ce script permet de generer les fichiers de base nécessaires au lancement d'un projet web (html/css) avec le contenu de base pour html et le reset pour le css."
    echo
    echo 'Usage : mpb [OPTION1] [Valeur] [OPTION2] [Valeur] [OPTION3] [Valeur] [OPTION4]'
    echo
    echo 'Option : '
    echo "'-p' : Permet d'indiquer le chemin ou les fichiers seront créés"
    echo "'-t' : Permet d'indiquer que l'on souhaite créer un dossier parent au projet en indiquant son nom"
    echo "'-r' : Indique que l'on souhaite générer le dossier ressources"
    echo "'-c' : Permet l'ouverture du dossier du projet avec l'éditeur de son choix, indiqué après"
}

function verifPath() {
    if [ -d $2 ]
    then
        path_dest=$2
    else
        echo "Chemin indiqué incorect !" 1>&2
        exit 1
    fi
}

function verifTitle() {
    if [ -d "$path_dest/$title_dir" ]
    then
        echo "Le dossier que vous souhaitez existe déja !" 1>&2
        exit 1
    fi
}

function verifArg() {
    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            -h|--help) # display Help
                display_help
                exit 0
                ;;  
            -p) # Chemin
                # Action chemin ...
                verifPath $*
                path_dest=$2
                path_dest="$2"
                shift
                shift
                ;;
            -t) # Titre du dossier parent
                # Action titre dossier parent ...
                title_dir=$2
                bool_title=1
                shift
                shift
                ;;
            -r) #Bool ressources
                bool_ressources=1
                shift
                ;;
            -c) #Editeur avec lequel lancer le projet
                bool_editeur=1
                editeur="$2"
                shift
                shift
                ;;
            *) # Option invalide
                echo 'Option invalide, essayer --help' >&2
                exit 1
                ;;
        esac
    done
}

function create_dest {
    if [ $bool_title -eq 1 ]
    then
        mkdir -p "$path_dest"
    fi
    mkdir "$path_dest/styles"
    if [ $bool_ressources -eq 1 ]
    then
        mkdir "$path_dest/ressources"
    fi
}

function action {
    echo '<!DOCTYPE html>' > "$path_dest/index.html"
    echo '<html lang="en">' >> "$path_dest/index.html"
    echo '<head>' >> "$path_dest/index.html"
    echo '  <meta charset="UTF-8">' >> "$path_dest/index.html"
    echo '  <meta http-equiv="X-UA-Compatible" content="IE=edge">' >> "$path_dest/index.html"
    echo '  <meta name="viewport" #content="width=device-width, initial-scale=1.0">' >> "$path_dest/index.html"
    echo '  <link rel="stylesheet" href="styles/style.css">' >> "$path_dest/index.html"
    echo '  <title>Document</title>' >> "$path_dest/index.html"
    echo '</head>' >> "$path_dest/index.html"
    echo '<body>' >> "$path_dest/index.html"
    echo '  ' >> "$path_dest/index.html"
    echo '</body>' >> "$path_dest/index.html"
    echo '</html>' >> "$path_dest/index.html"

    echo 'html, body, div, span, applet, object, iframe,h1, h2, h3, h4, h5, h6 p, blockquote, pre,a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp,small, strike, strong, sub, sup, tt, var,b, u, i, center,dl, dt, dd, ol, ul, li,fieldset, form, label, legend,table, caption, tbody, tfoot, thead, tr, th, td,article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary,time, mark, audio, video {' > "$path_dest/styles/style.css"
    echo '    margin: 0;' >> "$path_dest/styles/style.css"
    echo '    padding: 0;' >> "$path_dest/styles/style.css"
    echo '    border: 0;' >> "$path_dest/styles/style.css"
    echo '    font-size: 100%;' >> "$path_dest/styles/style.css"
    echo '    font: inherit;' >> "$path_dest/styles/style.css"
    echo '    vertical-align: baseline;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
    echo '/* HTML5 display-role reset for older browsers */' >> "$path_dest/styles/style.css"
    echo 'article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section {' >> "$path_dest/styles/style.css"
    echo '    display: block;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
    echo 'body {' >> "$path_dest/styles/style.css"
    echo '    line-height: 1;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
    echo 'ol, ul {' >> "$path_dest/styles/style.css"
    echo '    list-style: none;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
    echo 'blockquote, q {' >> "$path_dest/styles/style.css"
    echo '    quotes: none;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
    echo 'blockquote:before, blockquote:after, q:before, q:after {' >> "$path_dest/styles/style.css"
    echo "    content: '';" >> "$path_dest/styles/style.css"
    echo '    content: none;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
    echo 'table {' >> "$path_dest/styles/style.css"
    echo '    border-collapse: collapse;' >> "$path_dest/styles/style.css"
    echo '    border-spacing: 0;' >> "$path_dest/styles/style.css"
    echo '}' >> "$path_dest/styles/style.css"
}

verifFile() {
    if [ -f "$path_dest/index.html" ]
    then
        echo 'Impossible de creer le projet : index.html déja présent !' >&2
        exit 1
    fi
    if [ -d "$path_dest/styles" ]
    then
        echo 'Impossible de creer le projet : styles déja présent !' >&2
        exit 1
    fi
    if [ -f "$path_dest/styles/style.css" ]
    then
        echo 'Impossible de creer le projet : style.css déja présent !' >&2
        exit 1
    fi
    if [[ ( $bool_ressources -eq 1 ) && ( -d "$path_dest/ressources" ) ]]
    then
        echo 'Impossible de creer le projet : ressources déja présent !' >&2
        exit 1
    fi  

}

verifArg $*
verifTitle $*
if [ $bool_title -eq 1 ]
then
    path_dest="$path_dest/$title_dir"
fi
verifFile
create_dest
action
echo 'Projet Généré avec succès ! '
if [ $bool_editeur -eq 1 ]
then
    $editeur $path_dest
fi