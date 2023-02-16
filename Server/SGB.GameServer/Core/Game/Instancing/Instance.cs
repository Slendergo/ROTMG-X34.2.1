using SGB.GameServer.Core.IO;
using SGB.GameServer.Utils;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace SGB.GameServer.Core.Game.Instancing
{
    public sealed class Instance : IDisposable
    {
        public InstanceType InstanceType { get; private set; }
        public int TicksPerSecond { get; private set; }
        public int MillisecondsPerTick { get; private set; }

        public GameWorld TopLevelGameWorld { get; private set; }
        public Dictionary<int, Session> Sessions { get; private set; }

        public Instance(InstanceType instanceType, int ticksPerSecond)
        {
            InstanceType = instanceType;
            TicksPerSecond = ticksPerSecond;
            MillisecondsPerTick = 1000 / ticksPerSecond;

            var isNexus = instanceType == InstanceType.Nexus;

            TopLevelGameWorld = GameWorldManager.CreateNewWorld(this, isNexus ? "Nexus" : "Realm of the Mad God", isNexus ? -2 : null);
        }

        // to prevent system overload for lower cpu core counts
        public void RunLowHardware()
        {
            _ = Task.Factory.StartNew(() =>
            {
                var spinWait = new SpinWait();
                var last = Stopwatch.GetTimestamp();
                while (true)
                {
                    var now = Stopwatch.GetTimestamp();
                    var dt = Stopwatch.GetElapsedTime(last).Milliseconds;

                    if (dt >= MillisecondsPerTick)
                    {
                        var ddt = dt * 0.001;

                        DebugUtils.WriteLine($"[{TopLevelGameWorld.Name} ({InstanceType})] -> {MillisecondsPerTick} | {ddt}");

                        if (!TopLevelGameWorld.Update(dt))
                            break;

                        last = now;
                    }

                    spinWait.SpinOnce();
                }

                DebugUtils.WriteLine($"Instance has stopped: {TopLevelGameWorld.Name}");
            }, TaskCreationOptions.LongRunning);
        }

        public void Run()
        {
            _ = Task.Factory.StartNew(() =>
            {
                var last = Stopwatch.GetTimestamp();
                while (true)
                {
                    var now = Stopwatch.GetTimestamp();
                    var dt = Stopwatch.GetElapsedTime(last).Milliseconds;

                    if (dt >= MillisecondsPerTick)
                    {
                        var ddt = dt * 0.001;

                        DebugUtils.WriteLine($"[{TopLevelGameWorld.Name} ({InstanceType})] -> {MillisecondsPerTick} | {ddt}");

                        if (!TopLevelGameWorld.Update(dt))
                            break;

                        last = now;
                    }

                    _ = Thread.Yield();
                }

                Console.WriteLine($"Instance has stopped: {TopLevelGameWorld.Name}");
            }, TaskCreationOptions.LongRunning);
        }

        public void Dispose()
        {
            // todo cleanup here
        }
    }
}
