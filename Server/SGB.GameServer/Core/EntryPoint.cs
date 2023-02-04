using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection.Metadata;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using SGB.GameServer.Core.IO;
using SGB.GameServer.Utils;

namespace SGB.GameServer.Core
{
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
                    DebugUtils.Log(dt);
                    last = now;
                }
            }

        }

        // cleanup
        public void Dispose()
        {
            SessionManager.Dispose();
            SessionListener.Dispose();
        }
    }
}
