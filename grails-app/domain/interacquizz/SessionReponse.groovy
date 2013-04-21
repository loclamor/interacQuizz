package interacquizz

class SessionReponse {
	Question question
	String nom
	static hasMany = [reponses:Reponse]
	Boolean visible
	String phase
	String cleeAcces
	
    static constraints = {
		nom blank: true, nullable: true
		phase inList: ["ajoutReponses", "validation", "vote", "resultat"]
		cleeAcces unique: true
    }
}
