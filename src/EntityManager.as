package {

public class EntityManager {

    var _entities:Vector.<Entity>;


    public function EntityManager(numberOfEntities:int) {
        for(var i:int; i < numberOfEntities; i++) {
            _entities.insertAt(numberOfEntities , new Entity("", 0, 0, 0, 0));
        }
    }

    public function update() {
        var e:Entity;
        for(e in _entities) {
            
        }
    }
}
}
