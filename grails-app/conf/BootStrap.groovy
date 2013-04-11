import interacquizz.Professeur
import interacquizz.Question
import interacquizz.SessionReponse

class BootStrap {

    def init = { servletContext ->
		
		println("### initialisation...")
		//données de test
		def prof1 = new Professeur(nom: "Migeon", prenom: "F", identifiant: "mf", motDePasse: "mfmf")
		if(!prof1.save(flush:true)){
			println("erreur enregistrement prof1");
			prof1.errors.allErrors.each( {e -> println (e) } )
		}
		
		def prof2 = new Professeur(nom: "Silvestre", prenom: "F", identifiant: "sf", motDePasse: "sfsf")
		if(!prof2.save(flush:true)){
			println("erreur enregistrement prof2");
			prof2.errors.allErrors.each( {e -> println (e) } )
		}
		
		def prof = Professeur.findByIdentifiant("mf")
		def quest1 = new Question(intitule: "Pourquoi la terre tourne ?", commentaire: "", createur: prof)
		if(!quest1.save(flush:true)){
			println("erreur enregistrement quest1");
			quest1.errors.allErrors.each( {e -> println (e) } )
		}
		
		def quest = Question.get(1)
		def sess1 = new SessionReponse(question: quest, visible: true, phase: "ajoutReponses", cleeAcces: "plop")
		if(!sess1.save(flush:true)){
			println("erreur enregistrement sess1");
			sess1.errors.allErrors.each( {e -> println (e) } )
		}
		println("### initialisation terminée")
    }
    def destroy = {
    }
}
