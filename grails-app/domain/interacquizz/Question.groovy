package interacquizz

class Question {
	String intitule
	String commentaire
	Professeur createur
	static hasMany=[sessions:SessionReponse]
	
	String toString() {
		intitule
	}
	
    static constraints = {
		intitule(blank:false)
		commentaire(blank:true)
    }
}
