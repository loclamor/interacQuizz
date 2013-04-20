package interacquizz

class Professeur {
	String nom
	String prenom
	String identifiant
	String motDePasse
	
	String toString() {
		prenom + " " + nom
	}
	
    static constraints = {
		nom(blank:false)
		prenom(blank:false)
		identifiant(blank:false, unique: true)
		motDePasse(blank:false)
    }
	
	
}
