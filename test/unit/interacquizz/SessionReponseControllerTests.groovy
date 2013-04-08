package interacquizz



import org.junit.*
import grails.test.mixin.*

@TestFor(SessionReponseController)
@Mock(SessionReponse)
class SessionReponseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/sessionReponse/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sessionReponseInstanceList.size() == 0
        assert model.sessionReponseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sessionReponseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sessionReponseInstance != null
        assert view == '/sessionReponse/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/sessionReponse/show/1'
        assert controller.flash.message != null
        assert SessionReponse.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionReponse/list'

        populateValidParams(params)
        def sessionReponse = new SessionReponse(params)

        assert sessionReponse.save() != null

        params.id = sessionReponse.id

        def model = controller.show()

        assert model.sessionReponseInstance == sessionReponse
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionReponse/list'

        populateValidParams(params)
        def sessionReponse = new SessionReponse(params)

        assert sessionReponse.save() != null

        params.id = sessionReponse.id

        def model = controller.edit()

        assert model.sessionReponseInstance == sessionReponse
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/sessionReponse/list'

        response.reset()

        populateValidParams(params)
        def sessionReponse = new SessionReponse(params)

        assert sessionReponse.save() != null

        // test invalid parameters in update
        params.id = sessionReponse.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/sessionReponse/edit"
        assert model.sessionReponseInstance != null

        sessionReponse.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/sessionReponse/show/$sessionReponse.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        sessionReponse.clearErrors()

        populateValidParams(params)
        params.id = sessionReponse.id
        params.version = -1
        controller.update()

        assert view == "/sessionReponse/edit"
        assert model.sessionReponseInstance != null
        assert model.sessionReponseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/sessionReponse/list'

        response.reset()

        populateValidParams(params)
        def sessionReponse = new SessionReponse(params)

        assert sessionReponse.save() != null
        assert SessionReponse.count() == 1

        params.id = sessionReponse.id

        controller.delete()

        assert SessionReponse.count() == 0
        assert SessionReponse.get(sessionReponse.id) == null
        assert response.redirectedUrl == '/sessionReponse/list'
    }
}
