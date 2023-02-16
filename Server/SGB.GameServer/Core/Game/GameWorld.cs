using SGB.GameServer.Core.Game.Instancing;
using System.Collections.Generic;

namespace SGB.GameServer.Core.Game
{
    public sealed class GameWorld
    {
        public int NextObjectId = 0;

        public Instance Instance { get; private set; }
        public int GameId { get; private set; }
        public int Width { get; private set; }
        public int Height { get; private set; }
        public string Name { get; private set; }
        public Tile[,] Tiles { get; private set; }

        public Dictionary<int, GameObject> Objects = new Dictionary<int, GameObject>();

        public Dictionary<int, GameWorld> GameWorlds = new Dictionary<int, GameWorld>();

        public GameWorld(Instance instance, int gameId)
        {
            Instance = instance;
            GameId = gameId;
        }

        public void Initialize(int width, int height, string name)
        {
            Width = width;
            Height = height;
            Name = name;

            Tiles = new Tile[width, height];

            for (var x = 0; x < width; x++)
                for (var y = 0; y < height; y++)
                    Tiles[x, y] = new Tile()
                    {
                        Type = 0x36,
                        X = x,
                        Y = y
                    };
        }

        public void AddObject(GameObject gameObject)
        {
            gameObject.Id = NextObjectId++;
            Objects.Add(gameObject.Id, gameObject);
        }

        public bool Update(double dt)
        {
            UpdateGameWorldsInternal(dt);
            return UpdateInternal(dt);
        }

        private void UpdateGameWorldsInternal(double dt)
        {
            var worldsToRemove = new List<GameWorld>();
            foreach (var world in GameWorlds.Values)
                if (!world.Update(dt))
                    worldsToRemove.Add(world);

            foreach (var gameWorld in worldsToRemove)
            {
                _ = GameWorlds.Remove(gameWorld.GameId);
                GameWorldManager.RemoveWorld(gameWorld);
            }
        }

        private bool UpdateInternal(double dt)
        {
            foreach (var go in Objects.Values)
                _ = go.Update(dt);
            return true;
        }

        public bool CreateNewWorld(string dungeonName) 
        {
            var world = GameWorldManager.CreateNewWorld(Instance, dungeonName);
            if(world == null)
                return false;
            GameWorlds.Add(world.GameId, world);
            return true;
        }
    }
}
