- Package linda : `Tuple, TupleFormatException, Linda, Callback, AsynchronousCallback`
(intégralement fourni, classes et interfaces pour les codes utilisateurs, ne pas modifier)
- Package linda.shm : classe `CentralizedLinda`
(implantation de linda.Linda en mémoire partagée, à écrire sous ce nom). Vous pouvez ajouter ici d’autres classes/interfaces, mais elles seront cachées aux codes utilisateurs. Vous pouvez placer dans ce répertoire votre version d'origine (avant amélioration), à des fins de comparaison.
- Package linda.server : classe LindaClient (implantation de `linda.Linda` pour accéder à un serveur distant). Vous pouvez ajouter ici d’autres classes/interfaces, mais elles seront cachées aux codes utilisateurs
- Package linda.cache : version client/serveur avec cache côté client. Doit contenir (au moins) une version de LindaClient adaptée pour la gestion du cache, et une implémentation de Linda côté serveur. Il saera sans doute nécessaire d'éajouter d'autres classes/interfaces.
- Package linda.multiserveur
- Package linda.test : quelques tests élémentaires
- Package linda.whiteboard : un exemple d’application
- Package linda.search.basic : un noyau d’application de recherche
- Package linda.autre : ce que vous voulez.