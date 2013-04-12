package interacquizz

class Reponse {
	String intitule
	String commentaire
	SessionReponse sessionRep
	Boolean valide
	int vote
	
	String toString() {
		intitule
	}
	
    static constraints = {
		intitule(blank:false)
    }
}
