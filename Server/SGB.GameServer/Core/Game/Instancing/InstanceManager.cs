namespace SGB.GameServer.Core.Game.Instancing
{
    public static class InstanceManager
    {
        private static readonly List<Instance> Instances = new List<Instance>();

        static InstanceManager() { }

        public static void SpinNewInstance(InstanceType instanceType, int ticksPerSecond, int? instanceId = null)
        {
            var instance = new Instance(instanceType, ticksPerSecond);
            lock (Instances)
            {
                Instances.Add(instance);
            }

            if (Environment.ProcessorCount <= 4)
                instance.RunLowHardware();
            else
                instance.Run();
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
