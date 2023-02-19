using System.Collections.Generic;

namespace SGB.GameServer.Core.Game
{
    public sealed class GameObjectStorage
    {
        private int NextObjectId = 0;

        private readonly Dictionary<int, GameObject> Objects = new Dictionary<int, GameObject>();
        private readonly List<GameObject> ObjectsToRemove = new List<GameObject>();

        public int GetNextObjectId() => NextObjectId++;

        public GameObject FindObject(int id) => Objects.TryGetValue(id, out var ret) ? ret : null;

        public void Add(GameObject gameObject) => Objects.Add(gameObject.Id, gameObject);

        public void Update(double dt)
        {
            foreach (var go in Objects.Values)
                if (!go.Update(dt))
                    ObjectsToRemove.Add(go);
        }

        public void Cleanup()
        {
            foreach (var go in ObjectsToRemove)
                _ = Objects.Remove(go.Id);
            ObjectsToRemove.Clear();
        }
    }
}
