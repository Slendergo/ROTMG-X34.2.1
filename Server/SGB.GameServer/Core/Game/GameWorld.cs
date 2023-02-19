using SGB.GameServer.Core.Game.Instancing;
using SGB.GameServer.Core.IO;
using SGB.GameServer.Resources;
using SGB.GameServer.Resources.Properties;
using SGB.Shared;
using System;
using System.Collections.Generic;

namespace SGB.GameServer.Core.Game
{

    public sealed class GameWorld
    {
        public Instance Instance { get; private set; }
        public int GameId { get; private set; }
        public string IdName { get; private set; }
        public string DisplayName { get; private set; }
        public int Width { get; private set; }
        public int Height { get; private set; }
        public int Seed { get; private set; }
        public int Difficulty { get; private set; }
        public bool AllowPlayerTeleport { get; private set; }
        public bool ShowDisplays { get; private set; }
        public short MaxPlayers { get; private set; }
        public GameObjectStorage GameObjectStorage { get; private set; }

        public Tile[,] Tiles { get; private set; }

        private Dictionary<int, GameWorld> GameWorlds = new Dictionary<int, GameWorld>();

        public GameWorld(Instance instance, int gameId) 
        {
            Instance = instance;
            GameId = gameId;

            GameObjectStorage = new GameObjectStorage();
        }

        public void Initialize(XMLDungeon xmlDungeon)
        {
            IdName = xmlDungeon.IdName;
            DisplayName = xmlDungeon.DisplayId;
            Width = xmlDungeon.Width;
            Height = xmlDungeon.Height;
            Seed = Random.Shared.Next();
            Difficulty = xmlDungeon.Difficulty;
            AllowPlayerTeleport = !xmlDungeon.NoPlayerTeleport;
            ShowDisplays = xmlDungeon.ShowDisplays;
            MaxPlayers = xmlDungeon.PlayerLimit;

            GenerateMap(xmlDungeon);
        }

        // todo figure out in the future how i wanna go about generating maps and parsing

        // Idea 1)
        // create room bounds
        // define corridors
        // final step is to parse the map over the bounds with enemies, walls, grounds etc
        // last step is to do post processing (adding in the noise and stuff)

        struct GenerationData
        {
            public XMLDungeon XMLDungeon { get; private set; }

            public GenerationData(XMLDungeon xmlDungeon)
            {
                XMLDungeon = xmlDungeon;
            }

            struct Room
            {
            }

            struct Collider
            {
            }

            struct Template
            {
            }
        }

        private void GenerateMap(XMLDungeon xmlDungeon)
        {
            using var t = new TimedProfiler($"GameWorld::GenerateMap()");
            Tiles = new Tile[Width, Height];

            var generationData = new GenerationData(xmlDungeon);

            GenerationDefaultTiles(ref generationData);
            GenerateStartRoom(ref generationData);
            GenerateMainBranch(ref generationData);
            GenerateSubBranch(ref generationData);
            DoGlobals(ref generationData);
        }

        private void GenerateStartRoom(ref GenerationData generationData)
        {
            using var t = new TimedProfiler($"GameWorld::GenerateStartRoom()");

            // todo parse the room
        }

        private void GenerateMainBranch(ref GenerationData generationData)
        {
            using var t = new TimedProfiler($"GameWorld::GenerateMainBranch()");
        }

        private void GenerateSubBranch(ref GenerationData generationData)
        {
            using var t = new TimedProfiler($"GameWorld::GenerateSubBranch()");
        }

        private void GenerationDefaultTiles(ref GenerationData generationData)
        {
            using var t = new TimedProfiler($"GameWorld::GenerationDefaultTiles()");

            var defaultType = GameLibrary.GroundTypeFromId(generationData.XMLDungeon.DefaultTile);
            for (var x = 0; x < Width; x++)
                for (var y = 0; y < Height; y++)
                    Tiles[x, y] = new Tile()
                    {
                        Type = defaultType,
                        X = x,
                        Y = y
                    };
        }

        private void DoGlobals(ref GenerationData generationData)
        {
            using var t = new TimedProfiler($"GameWorld::DoGlobals()");

            // todo
            foreach (var replace in generationData.XMLDungeon.GlobalReplaceTiles)
            {
                switch (replace.Func)
                {
                    case XMLDungeon.GlobalFuncEnum.None:
                    case XMLDungeon.GlobalFuncEnum.RandomLinesX:
                    case XMLDungeon.GlobalFuncEnum.RandomLinesY:
                    case XMLDungeon.GlobalFuncEnum.PerlinProb:
                    case XMLDungeon.GlobalFuncEnum.AroundSpawn:
                    case XMLDungeon.GlobalFuncEnum.PerlinMod:
                    case XMLDungeon.GlobalFuncEnum.CGNoise:
                        break;
                }
            }

            foreach (var place in generationData.XMLDungeon.GlobalPlaceObjects)
            {
                switch (place.Func)
                {
                    case XMLDungeon.GlobalFuncEnum.None:
                    case XMLDungeon.GlobalFuncEnum.PerlinProb:
                        break;
                }
            }

            // todo SurroundWith
        }

        // this session stuff here is temporary

        private List<Session> Sessions = new List<Session>();
        private List<Session> SessionsToAdd = new List<Session>();
        private List<Session> SessionsToRemove = new List<Session>();
        public void AddSession(Session session)
        {
            SessionsToAdd.Add(session);
        }

        public void RemoveSession(Session session)
        {
            SessionsToRemove.Add(session);
        }

        public GameObject CreateNewObject(string idName, double x, double y)
        {
            var go = new GameObject()
            {
                X = x,
                Y = y,
                ObjectType = GameLibrary.ObjectTypeFromId(idName),
            };

            // todo
            return go;
        }

        public bool Update(double dt)
        {
            // update the other worlds first
            UpdateGameWorlds(dt);

            // handle mes logic here

            // add connected sessions
            foreach(var session in SessionsToAdd)
                Sessions.Add(session);
            SessionsToAdd.Clear();

            // handle the logic for each session
            foreach (var session in Sessions)
                if (session.StateManager.IsReady)
                {
                    // update tiles, and add/remove objects
                    // update entity stats and positions
                    session.StateManager.UpdateState.NewState(dt);
                }

            //update behaviors and gameobject logic
            GameObjectStorage.Update(dt);

            // remove dead gameobjects
            GameObjectStorage.Cleanup();

            // remove disconnected sessions
            foreach (var session in SessionsToRemove)
                _ = Sessions.Remove(session);
            SessionsToRemove.Clear();

            return true;
        }

        private void UpdateGameWorlds(double dt)
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
