using SGB.GameServer.Core.IO;
using SGB.GameServer.Utils;
using SGB.Shared;
using System.Diagnostics;

namespace SGB.GameServer.Core
{
    public sealed class GameObject
    {
        public int Id;
        public int ObjectType;
        public double X;
        public double Y;
        
        public bool Update(double dt)
        {
            return false;
        }
    }

    public sealed class World
    {
        public int NextObjectId = 0;

        public int Width;
        public int Height;
        public string Name;
        public Tile[,] Tiles;
        public Dictionary<int, GameObject> Objects = new Dictionary<int, GameObject>();

        public World(int width, int height, string name)
        {
            Width = width;
            Height = height;
            Name = name;

            Tiles = new Tile[width, height];

            for (var x = 0; x < width; x++)
                for (var y = 0; y < Height; y++)
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
            foreach (var go in Objects.Values)
                _ = go.Update(dt);
            return false;
        }
    }

    public class Tile
    {
        public int X;
        public int Y;
        public int Type;
    }

    public sealed class Application : IDisposable
    {
        public readonly SessionManager SessionManager;
        public readonly SessionListener SessionListener;

        public Application()
        {
            SessionManager = new SessionManager(this);
            SessionListener = new SessionListener(this, 2050);
        }

        public void Run()
        {
            SessionListener.Start();

            // main thread will be used to handle restarting the server automatically

            var last = Stopwatch.GetTimestamp(); 
            while (true)
            {
                var now = Stopwatch.GetTimestamp();
                var dt = Stopwatch.GetElapsedTime(last).Milliseconds;

                if (dt >= 200)
                {
                    var ddt = dt * 0.001;

                    // update server state
                    HandleWorlds(ddt);
                    // send server state
                    HandleNewSessionState(ddt);

                    last = now;
                }

                Thread.Yield();
            }

        }

        private void HandleWorlds(double dt)
        {
            // tick all worlds here
        }

        private void HandleNewSessionState(double dt)
        {
            foreach (var session in SessionManager.Sessions.Values)
                if(session.StateManager.IsReady)
                    session.StateManager.UpdateState.NewState(dt);
        }

        // cleanup
        public void Dispose()
        {
            SessionManager.Dispose();
            SessionListener.Dispose();
        }
    }
}
