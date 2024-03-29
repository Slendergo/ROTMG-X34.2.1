﻿using SGB.GameServer.Utils;
using System;
using System.Collections.Generic;

namespace SGB.GameServer.Core.Game.Instancing
{
    public static class InstanceManager
    {
        private static readonly List<Instance> Instances = new List<Instance>();

        static InstanceManager() { }

        public static void SpinNewInstance(InstanceType instanceType, int ticksPerSecond)
        {
            var instance = new Instance(instanceType, ticksPerSecond);
            lock (Instances)
            {
                Instances.Add(instance);
            }

            if (Environment.ProcessorCount <= 8)
                instance.RunLowHardware();
            else
                instance.Run();

            Logger.LogDebug($"A New {instanceType} Instance is Running.");
        }

        public static void Dispose()
        {
            lock (Instances)
            {
                foreach (var instance in Instances)
                    instance.Dispose();
            }
        }
    }
}
