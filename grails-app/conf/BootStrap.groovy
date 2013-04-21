import interacquizz.Professeur
import interacquizz.Question
import interacquizz.Reponse
import interacquizz.SessionReponse
import interacquizz.Vote

class BootStrap {

    def init = { servletContext ->
		
		if(Professeur.count() == 0) {
			println("### initialisation...")
			//données de test
			def prof1 = new Professeur(nom: "Migeon", prenom: "F", identifiant: "mf", motDePasse: "mf")
			if(!prof1.save(flush:true)){
				println("erreur enregistrement prof1");
				prof1.errors.allErrors.each( {e -> println (e) } )
			}
			
			def prof2 = new Professeur(nom: "Silvestre", prenom: "F", identifiant: "sf", motDePasse: "sf")
			if(!prof2.save(flush:true)){
				println("erreur enregistrement prof2");
				prof2.errors.allErrors.each( {e -> println (e) } )
			}
			
			def prof = Professeur.findByIdentifiant("mf")
			def quest1 = new Question(intitule: "Pourquoi la Terre tourne ?", commentaire: "donnez vos sources", createur: prof)
			if(!quest1.save(flush:true)){
				println("erreur enregistrement quest1");
				quest1.errors.allErrors.each( {e -> println (e) } )
			}
			
			def q1 = Question.get(1)
			def sess1 = new SessionReponse(nom:"cours 1 JEE", question: q1, visible: true, phase: "ajoutReponses", cleeAcces: "plop")
			if(!sess1.save(flush:true)){
				println("erreur enregistrement sess1");
				sess1.errors.allErrors.each( {e -> println (e) } )
			}
			def rep1 = new Reponse(intitule: "La Terre s'est creee en tournant et a garde son axe de rotation par la suite", commentaire: "", sessionRep: sess1, valide: true, vote: 0)
			if(!rep1.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep1 + "\" ajoutee a la question \"" + sess1.getQuestion() + "\"")
			} 
			def rep2 = new Reponse(intitule: "La Terre est ronde", commentaire: "", sessionRep: sess1, valide: false, vote: 0)
			if(!rep2.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep2 + "\" ajoutee a la question \"" + sess1.getQuestion() + "\"")
			}
			def rep3 = new Reponse(intitule: "Un geant s'occupe de faire tourner la Terre", commentaire: "comme une toupie", sessionRep: sess1, valide: false, vote: 0)
			if(!rep3.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep3 + "\" ajoutee a la question \"" + sess1.getQuestion() + "\"")
			}
			
			def quest2 = new Question(intitule: "Pourquoi l'Homme ne peut pas voler ?", commentaire: "", createur: prof)
			if(!quest2.save(flush:true)){
				println("erreur enregistrement quest2");
				quest2.errors.allErrors.each( {e -> println (e) } )
			}
			
			def q2 = Question.get(2)
			def sess2 = new SessionReponse(nom:"cours 2 JEE", question: q2, visible: true, phase: "ajoutReponses", cleeAcces: "plip")
			if(!sess2.save(flush:true)){
				println("erreur enregistrement sess2");
				sess2.errors.allErrors.each( {e -> println (e) } )
			}
			
			def sess3 = new SessionReponse(nom:"cours 3 JEE", question: q2, visible: true, phase: "resultat", cleeAcces: "plap")
			if(!sess3.save(flush:true)){
				println("erreur enregistrement sess3");
				sess3.errors.allErrors.each( {e -> println (e) } )
			}
			
			def rep4 = new Reponse(intitule: "L'apensanteur de la Terre attire toute masse vers son centre", commentaire: "", sessionRep: sess3, valide: false, vote: 0)
			if(!rep4.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep4 + "\" ajoutee a la question \"" + sess3.getQuestion() + "\"")
			}
			def rep5 = new Reponse(intitule: "Il n'a pas d'ailes", commentaire: "pas comme les oiseaux", sessionRep: sess3, valide: false, vote: 0)
			if(!rep5.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep5 + "\" ajoutee a la question \"" + sess3.getQuestion() + "\"")
			}
			def rep6 = new Reponse(intitule: "Il peut avec la technologie...", commentaire: "cf les avions", sessionRep: sess3, valide: true, vote: 0)
			if(!rep6.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep6 + "\" ajoutee a la question \"" + sess3.getQuestion() + "\"")
			}
			def rep7 = new Reponse(intitule: "Voler c'est tricher", commentaire: "et tricher c'est mal", sessionRep: sess3, valide: false, vote: 0)
			if(!rep7.save(flush:true)){
				println("!!!! erreur enregistrement reponse");
			}
			else {
				println("Reponse \"" + rep7 + "\" ajoutee a la question \"" + sess3.getQuestion() + "\"")
			}
			def vote1 = new Vote(reponse: rep4);
			if (!vote1.save(flush: true)) {
				println("vote echoue")
			}
			def vote2 = new Vote(reponse: rep4);
			if (!vote2.save(flush: true)) {
				println("vote echoue")
			}
			def vote3 = new Vote(reponse: rep4);
			if (!vote3.save(flush: true)) {
				println("vote echoue")
			}
			def vote4 = new Vote(reponse: rep5);
			if (!vote4.save(flush: true)) {
				println("vote echoue")
			}
			def vote5 = new Vote(reponse: rep5);
			if (!vote5.save(flush: true)) {
				println("vote echoue")
			}
			def vote6 = new Vote(reponse: rep6);
			if (!vote6.save(flush: true)) {
				println("vote echoue")
			}
			def vote7 = new Vote(reponse: rep6);
			if (!vote7.save(flush: true)) {
				println("vote echoue")
			}
			def vote8 = new Vote(reponse: rep6);
			if (!vote8.save(flush: true)) {
				println("vote echoue")
			}
			def vote9 = new Vote(reponse: rep6);
			if (!vote9.save(flush: true)) {
				println("vote echoue")
			}
			println("### initialisation terminee")
		}
    }
    def destroy = {
    }
}
