package interacquizz



import org.junit.*
import grails.test.mixin.*

@TestFor(ProfesseurController)
@Mock(Professeur)
class ProfesseurControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/professeur/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.professeurInstanceList.size() == 0
        assert model.professeurInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.professeurInstance != null
    }

    void testSave() {
        controller.save()

        assert model.professeurInstance != null
        assert view == '/professeur/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/professeur/show/1'
        assert controller.flash.message != null
        assert Professeur.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/professeur/list'

        populateValidParams(params)
        def professeur = new Professeur(params)

        assert professeur.save() != null

        params.id = professeur.id

        def model = controller.show()

        assert model.professeurInstance == professeur
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/professeur/list'

        populateValidParams(params)
        def professeur = new Professeur(params)

        assert professeur.save() != null

        params.id = professeur.id

        def model = controller.edit()

        assert model.professeurInstance == professeur
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/professeur/list'

        response.reset()

        populateValidParams(params)
        def professeur = new Professeur(params)

        assert professeur.save() != null

        // test invalid parameters in update
        params.id = professeur.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/professeur/edit"
        assert model.professeurInstance != null

        professeur.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/professeur/show/$professeur.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        professeur.clearErrors()

        populateValidParams(params)
        params.id = professeur.id
        params.version = -1
        controller.update()

        assert view == "/professeur/edit"
        assert model.professeurInstance != null
        assert model.professeurInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/professeur/list'

        response.reset()

        populateValidParams(params)
        def professeur = new Professeur(params)

        assert professeur.save() != null
        assert Professeur.count() == 1

        params.id = professeur.id

        controller.delete()

        assert Professeur.count() == 0
        assert Professeur.get(professeur.id) == null
        assert response.redirectedUrl == '/professeur/list'
    }
}
