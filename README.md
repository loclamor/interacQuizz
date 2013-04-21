interacQuizz - tp final JEE
===========================
par loclamor et Laumaned

Master 1 Informatique DL Université Paul Sabatier - Toulouse

---------------------------------------------------------------------------

Pour tester notre application, un jeu de test est défini dans le bootstrap de grails.

Deux professeurs sont créés (identiant/motDePasse) : 
- mf/mf
- sf/sf

le premier compte possède des questions, avec des sessions de réponses, des réponses et même des votes.

Le déroulement d'un TD se fait ainsi :
- Le professeur créé les questions qu'il souhaite.
- Dans le menu, il peut afficher la liste des questions.
- En cliquant sur l'intitulé d'une question, il peut afficher la liste des sessions qui lui sont déjà associées.
- Au début, aucune session n'est associée à la question alors il peut le faire en créant une nouvelle session via le bouton + dans la liste des sessions.
- A son bon vouloir, il peut ajouter déjà des réponses ou non.
- Le professeur active une session et donne la clée d'accès à ses étudiants.
- Le professeur accède à la phase courante de la session en cliquant sur la session dans la liste des sessions.
  - en phase ajout de réponse, il peut ajouter des réponses, les valider, les modifier, ainsi que celles des étudiants. Il décide quand clôturer l'ajout.
  - en phase de validation, il ne peut que valider les dernières questions des étudiants, et lancer le vote. Il peut décider de revenir sur l'ajout de réponse.
  - en phase de vote, il décide quand clôturer le vote, et active alors l'affichage des résultats.
- L'étudiant se connecte en entrant le code de la session dans le formulaire de la page d'accueil. Il accède alors à la phase courante de la question.
  - En phase d'ajout de réponse, il est libre d'ajouter des réponses. Il peut passer à la phase suivante en cliquant sur le bouton associé.
  - En phase de validation, il doit attendre que le professeur lance le vote.
  - En phase de vote, il choisit la réponse qui lui parait la plus pertinante et clique simplement dessus. Il est alors dirigé sur la page de résultat, et invité à attendre que le professeur clôture le vote.
- La page de résultat est commune aux deux parties. On y prend note de la part de votant pour chaque réponse, et la ou les bonnes réponses ressortent en vert. Le clic sur une réponse affiche le commentaire de la réponse définie par le professeur.


Bonne utilisation !
