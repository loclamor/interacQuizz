package interacquizz



import org.junit.*
import grails.test.mixin.*

@TestFor(ReponseController)
@Mock(Reponse)
class ReponseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/reponse/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.reponseInstanceList.size() == 0
        assert model.reponseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.reponseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.reponseInstance != null
        assert view == '/reponse/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/reponse/show/1'
        assert controller.flash.message != null
        assert Reponse.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/reponse/list'

        populateValidParams(params)
        def reponse = new Reponse(params)

        assert reponse.save() != null

        params.id = reponse.id

        def model = controller.show()

        assert model.reponseInstance == reponse
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/reponse/list'

        populateValidParams(params)
        def reponse = new Reponse(params)

        assert reponse.save() != null

        params.id = reponse.id

        def model = controller.edit()

        assert model.reponseInstance == reponse
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/reponse/list'

        response.reset()

        populateValidParams(params)
        def reponse = new Reponse(params)

        assert reponse.save() != null

        // test invalid parameters in update
        params.id = reponse.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/reponse/edit"
        assert model.reponseInstance != null

        reponse.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/reponse/show/$reponse.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        reponse.clearErrors()

        populateValidParams(params)
        params.id = reponse.id
        params.version = -1
        controller.update()

        assert view == "/reponse/edit"
        assert model.reponseInstance != null
        assert model.reponseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/reponse/list'

        response.reset()

        populateValidParams(params)
        def reponse = new Reponse(params)

        assert reponse.save() != null
        assert Reponse.count() == 1

        params.id = reponse.id

        controller.delete()

        assert Reponse.count() == 0
        assert Reponse.get(reponse.id) == null
        assert response.redirectedUrl == '/reponse/list'
    }
}
