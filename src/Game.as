package {
public class Game {

    var entityManager:EntityManager;

    public function Game() {
        entityManager = new EntityManager(10);
    }
    public function update() {
        entityManager.update();
    }
}
}
