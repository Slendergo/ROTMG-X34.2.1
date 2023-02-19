using SGB.GameServer.Core.Game.Instancing;
using SGB.GameServer.Core.IO;
using SGB.GameServer.Resources;
using SGB.GameServer.Resources.Properties;
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

        public void Initialize(XMLDungeon xmlDungeon)
        {
            Width = xmlDungeon.Width;
            Height = xmlDungeon.Height;
            Name = xmlDungeon.DisplayId;
            Tiles = new Tile[Width, Height];

            var defaultType = GameLibrary.GroundTypeFromId(xmlDungeon.DefaultTile);
            for (var x = 0; x < Width; x++)
                for (var y = 0; y < Height; y++)
                    Tiles[x, y] = new Tile()
                    {
                        Type = defaultType,
                        X = x,
                        Y = y
                    };
        }

        private List<Session> Sessions = new List<Session>();
        public void AddSession(Session session)
        {
            Sessions.Add(session);
        }

        public void AddObject(GameObject gameObject)
        {
            gameObject.Id = NextObjectId++;
            Objects.Add(gameObject.Id, gameObject);
        }

        public bool Update(double dt)
        {
            foreach(var s in Sessions)
            {
                if (!s.StateManager.IsReady)
                    continue;

                s.StateManager.UpdateState.HandleUpdate();
                s.StateManager.UpdateState.NewState(dt);
            }

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
