using SGB.GameServer.Core.Game.Instancing;
using SGB.GameServer.Resources;
using SGB.Shared;
using System.Collections.Generic;
using System.Threading;

namespace SGB.GameServer.Core.Game
{
    public static class GameWorldManager
    {
        private static int NextWorldId = -1;
        private static readonly Dictionary<int, GameWorld> GameWorlds = new Dictionary<int, GameWorld>();

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
            using var t = new TimedProfiler($"CreateNewWorld: {dungeonName}");

            // todo load map n shit
            var xmlDungeon = GameLibrary.XMLDungeonFromId(dungeonName);
            if (xmlDungeon == null)
                return null;

            var gameWorld = new GameWorld(instance, gameId ?? GetNextWorldId());
            gameWorld.Initialize(xmlDungeon);
            lock(GameWorlds)
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
