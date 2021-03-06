package interacquizz

import org.springframework.dao.DataIntegrityViolationException

class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        
		def questionInstanceList = Question.findAllByCreateur(session.prof)
        [questionInstanceList: questionInstanceList, questionInstanceTotal: questionInstanceList.size()]
    }

    def create() {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        [questionInstance: new Question(params)]
    }

    def save() {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def questionInstance = new Question(params)
        if (!questionInstance.save(flush: true)) {
            render(view: "create", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "list", id: questionInstance.id)
    }

    def edit(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        [questionInstance: questionInstance]
    }

    def update(Long id, Long version) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'question.label', default: 'Question')] as Object[],
                          "Another user has updated this Question while you were editing")
                render(view: "edit", model: [questionInstance: questionInstance])
                return
            }
        }

        questionInstance.properties = params

        if (!questionInstance.save(flush: true)) {
            render(view: "edit", model: [questionInstance: questionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.id])
        redirect(action: "list", id: questionInstance.id)
    }

    def delete(Long id) {
		if( !session.prof ) {
			redirect(controller: "professeur", action: "connect")
			return
		}
        def questionInstance = Question.get(id)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
            return
        }

        try {
			println("deleting question " + questionInstance + "...")
			def sessionRep = SessionReponse.findAllByQuestion(questionInstance)
			for (SessionReponse sess : sessionRep) {
				def reponses = Reponse.findAllBySessionRep(sess)
				println("deleting session " + sess.nom + "...")
				for (Reponse rep : reponses) {
					println("deleting reponse " + rep + "...")
					def votes = Vote.findAllByReponse(rep)
					for (Vote vote : votes) {
						println("deleting a vote...")
						vote.delete(flush: true)
					}
					rep.delete(flush: true)
				}
				sess.delete(flush: true)
			}
            questionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "list", id: id)
        }
    }
}
