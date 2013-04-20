package interacquizz

import org.springframework.dao.DataIntegrityViolationException

class ProfesseurController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(controller: "question", action: "list")
    }

	def connect() {
		if( session.prof ) {
			redirect(controller: "question", action: "list")
			return
		}
	}
	
	def connexion() {
		def prof = Professeur.findByIdentifiantAndMotDePasse(params.identifiant, params.motDePasse)
		if(!prof) {
			flash.messageErreur = "Identifiant ou mot de passe incorrecte"
			redirect(action: "connect")
			return
		}
		session.prof = prof
		flash.messageInfo = "Authentification r&eacute;ussie"
		redirect(controller: "question", action: "list")
	}
	
	def deconnexion() {
		session.removeAttribute("prof")
		session.invalidate()
		flash.messageInfo = "D&eacute;connexion r&eacute;ussie"
		redirect(uri: "/")
	}

    def create() {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        [professeurInstance: new Professeur(params)]
    }

    def save() {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def professeurInstance = new Professeur(params)
        if (!professeurInstance.save(flush: true)) {
            render(view: "create", model: [professeurInstance: professeurInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'professeur.label', default: 'Professeur'), professeurInstance.id])
        redirect( controller: "question", action: "list", id: professeurInstance.id)
    }

    def edit(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def professeurInstance = Professeur.get(id)
        if (!professeurInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'professeur.label', default: 'Professeur'), id])
            redirect( controller: "question", action: "list")
            return
        }

        [professeurInstance: professeurInstance]
    }

    def update(Long id, Long version) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def professeurInstance = Professeur.get(id)
        if (!professeurInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'professeur.label', default: 'Professeur'), id])
            redirect( controller: "question", action: "list")
            return
        }

        if (version != null) {
            if (professeurInstance.version > version) {
                professeurInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'professeur.label', default: 'Professeur')] as Object[],
                          "Another user has updated this Professeur while you were editing")
                render(view: "edit", model: [professeurInstance: professeurInstance])
                return
            }
        }

        professeurInstance.properties = params

        if (!professeurInstance.save(flush: true)) {
            render(view: "edit", model: [professeurInstance: professeurInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'professeur.label', default: 'Professeur'), professeurInstance.id])
        redirect( controller: "question", action: "list", id: professeurInstance.id)
    }

    def delete(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def professeurInstance = Professeur.get(id)
        if (!professeurInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'professeur.label', default: 'Professeur'), id])
            redirect( controller: "question", action: "list")
            return
        }

        try {
            professeurInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'professeur.label', default: 'Professeur'), id])
            redirect( controller: "question", action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'professeur.label', default: 'Professeur'), id])
			redirect( controller: "question", action: "list", id: professeurInstance.id)
        }
    }
}
