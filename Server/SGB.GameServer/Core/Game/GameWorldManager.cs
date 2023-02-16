using SGB.GameServer.Core.Game.Instancing;

namespace SGB.GameServer.Core.Game
{
    public static class GameWorldManager
    {
        private static int NextWorldId = -1;
        private static readonly Dictionary<int, GameWorld> GameWorlds = new Dictionary<int, GameWorld>();

        static GameWorldManager() { }

        public static int GetNextWorldId() => Interlocked.Increment(ref NextWorldId);

        public static GameWorld FindWorld(int gameId)
        {
            lock (GameWorlds)
            {
                if (GameWorlds.TryGetValue(gameId, out var ret))
                    return ret;
            }
            return null;
        }

        public static GameWorld CreateNewWorld(Instance instance, string dungeonName, int? gameId = null)
        {
            // todo load map n shit

            var gameWorld = new GameWorld(instance, gameId ?? GetNextWorldId());
            gameWorld.Initialize(64, 64, dungeonName);
            lock (GameWorlds)
            {
                GameWorlds.Add(gameWorld.GameId, gameWorld);
            }
            return gameWorld;
        }

        public static void RemoveWorld(GameWorld world)
        {
            lock (GameWorlds)
            {
                _ = GameWorlds.Remove(world.GameId);
            }
        }
    }
}
