package interacquizz

class SessionReponse {
	Question question
	static hasMany = [reponses:Reponse]
	Boolean visible
	Boolean cloture
	String cleeAcces
	
    static constraints = {
    }
}
