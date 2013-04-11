package interacquizz

class SessionReponse {
	Question question
	static hasMany = [reponses:Reponse]
	Boolean visible
	String phase
	String cleeAcces
	
    static constraints = {
		phase inList: ["ajoutReponses", "validation", "vote", "resultat"]
    }
}
