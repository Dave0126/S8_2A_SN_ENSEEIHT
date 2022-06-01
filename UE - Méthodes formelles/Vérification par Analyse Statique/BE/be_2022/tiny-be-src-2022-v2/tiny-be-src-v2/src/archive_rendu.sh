#!/bin/sh

DIR=$(dirname $0)
LOGIN=$(whoami)

echo $DIR

# checking validity of the code
pushd $DIR
ocamlbuild -use-ocamlfind check.native
if [ $? -ne 0 ]; then
    echo "LE CODE NE COMPILE PAS: VERIFIEZ VOTRE SOURCE ET COMMENTEZ LES PARTIES PROBLEMATIQUES!!! SI LE CODE NE COMPILE PAS, LE BE NE SERA PAS EVALUE."
    exit 1
fi
popd
rm $DIR/check.native


mkdir ${LOGIN}
cp ${DIR}/domains/congruences.ml ${LOGIN}
cp ${DIR}/domains/produitCongruencesIntervalles.ml ${LOGIN}
tar czf ${LOGIN}.tgz ${LOGIN}
rm -rf ${LOGIN}

echo "Vérifiez que l'archive ${LOGIN}.tgz contient bien les fichiers congruences.ml"
echo "et produitCongruencesIntervalles.ml avec votre travail puis envoyez la"
echo "via Moodle sur la page du cours: "
echo "https://moodle-n7.inp-toulouse.fr/course/view.php?id=1990#section-5"
