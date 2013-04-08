package interacquizz

import org.springframework.dao.DataIntegrityViolationException

class SessionReponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [sessionReponseInstanceList: SessionReponse.list(params), sessionReponseInstanceTotal: SessionReponse.count()]
    }

    def create() {
        [sessionReponseInstance: new SessionReponse(params)]
    }

    def save() {
        def sessionReponseInstance = new SessionReponse(params)
        if (!sessionReponseInstance.save(flush: true)) {
            render(view: "create", model: [sessionReponseInstance: sessionReponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), sessionReponseInstance.id])
        redirect(action: "show", id: sessionReponseInstance.id)
    }

    def show(Long id) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        [sessionReponseInstance: sessionReponseInstance]
    }

    def edit(Long id) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        [sessionReponseInstance: sessionReponseInstance]
    }

    def update(Long id, Long version) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (sessionReponseInstance.version > version) {
                sessionReponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sessionReponse.label', default: 'SessionReponse')] as Object[],
                          "Another user has updated this SessionReponse while you were editing")
                render(view: "edit", model: [sessionReponseInstance: sessionReponseInstance])
                return
            }
        }

        sessionReponseInstance.properties = params

        if (!sessionReponseInstance.save(flush: true)) {
            render(view: "edit", model: [sessionReponseInstance: sessionReponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), sessionReponseInstance.id])
        redirect(action: "show", id: sessionReponseInstance.id)
    }

    def delete(Long id) {
        def sessionReponseInstance = SessionReponse.get(id)
        if (!sessionReponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
            return
        }

        try {
            sessionReponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sessionReponse.label', default: 'SessionReponse'), id])
            redirect(action: "show", id: id)
        }
    }
}
